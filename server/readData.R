
User = setRefClass("User", fields=list(users = "ANY"),
  methods = list(
    initialize = function(){
      
    },
    addNewUserSession = function(){
      # library(uuid)
      # uuid::UUIDgenerate()
    },
    checkAlive = function() {
      
    },
    removeSessionStorage = function() {
      
    }
  )
)
ReadData = setRefClass("ReadData",
  fields = list(
    targetGMT = 'data.table',
    finalResult = 'ANY'
  ),
  methods = list(
    initialize = function() {
      dataType =c(TRUE)
      inFile = "data_go/GSE37704_sailfish_genecounts.csv" #"expression1_no_duplicate.csv"
      # 0.Read file
      x <- read.csv(inFile)	# try CSV
      isLessThen3Col = dim(x)[2] <= 2
      if(isLessThen3Col)   # if less than 3 columns, try tab-deliminated
        x <- read.table(inFile, sep="\t",header=TRUE)
      # Create numeric matrix 
      # 1. Type Checking 
      numCol = dim(x)[2]
      for(i in 2:numCol)
        dataType = c( dataType, is.numeric(x[,i]))
      if(sum(dataType) <=2) return (NULL)  # only less than 2 columns are numbers
      x <- x[,dataType]  # only keep numeric columns
      # 2. order by sd
      x = x[order(-apply(x[,2:dim(x)[2]],1,sd) ),]  # sort by SD
      x <- x[!duplicated(x[,1]) ,]  # remove duplicated genes
      rownames(x) <- x[,1]
      x <- as.matrix(x[,c(-1)])
      # missng value for median value
      if(sum(is.na(x))>0) {# if there is missing values
        print("there is missing")
        rowMeans <- apply(x,1, function (y)  median(y,na.rm=T))
        for(i in 1:dim(x)[1])
          x[i, which( is.na(x[i,]))] <- rowMeans[i]
      }
      
      x<-x[,-1] # except geneID
      mean.kurtosis = mean( apply(x,2, kurtosis) )
      x <- round(x,0) # enforce the read counts to be integers. Sailfish outputs has decimal points.
      x <- x[ which( apply(x,1,max) >= 300 ) , ] # remove all zero counts
      
      rawCounts = x;
      
      # Compute kurtosis
      mean.kurtosis = mean(apply(x,2, kurtosis))
      x <- round(x,0) # enforce the read counts to be integers. Sailfish outputs has decimal points.
      #x <- x[ which( apply(x,1,max) >= input$minCounts ) , ] # remove all zero counts
      dge <- DGEList(counts=x)
      dge <- calcNormFactors(dge)
      myCPM <- cpm(dge, prior.counts = 3 )
      #x <- x[which(rowSums(  myCPM > input$minCounts)  > 1 ),]  # at least two samples above this level
      rm(dge); rm(myCPM)
      tem = rep("A",dim(x)[2]); tem[1] <- "B"  
      colData = cbind(colnames(x), tem )
      colnames(colData)  = c("sample", "groups")
      dds <- DESeqDataSetFromMatrix(countData = x, colData = colData, design = ~ groups)
      dds <- estimateSizeFactors(dds) # estimate size factor for use in normalization later for started log method
      CountsTransform =1 
      countsLogStart=4
      if(CountsTransform == 3 && dim(counts(dds))[2] <= 10 ) { # rlog is slow, only do it with 10 samples
        x <- rlog(dds, blind=TRUE); 
        x <- assay(x) 
      }  else {
        if (CountsTransform == 2 ) {    # vst is fast but aggressive
          x <- vst(dds, blind=TRUE)
          x <- assay(x)  
        } else{  # normalized by library sizes and add a constant.
          x <- log2( counts(dds, normalized=TRUE) + countsLogStart )   # log(x+c)
        }
      }
      .self$finalResult <- list(data = as.matrix(x), mean.kurtosis = mean.kurtosis, rawCounts = rawCounts)
    },
    createUserSession = function() {
      UUIDgenerate()
    }
  )
)

PreWork = setRefClass("PreWork",
  fields = list(
    dds = 'ANY',
    x1 = 'ANY',
    x2 = 'ANY',
    x3 = 'ANY',
    finalResult = 'ANY'
  ),
  methods = list(
    initialize = function(x) {
      tem = rep("A",dim(x)[2]); 
      tem[1] <- "B" # making a fake design matrix to allow process, even when there is no replicates
      colData = cbind(colnames(x), tem )
      colnames(colData)  = c("sample", "groups")
      ddsTemp <- DESeqDataSetFromMatrix(countData = x,colData = colData,design = ~ groups)
      .self$dds <- estimateSizeFactors(ddsTemp) # estimate size factor for use in normalization later for started log
    },
    buildRLog = function(){
      x1Temp <- rlog(.self$dds, blind=TRUE); 
      .self$x1 <- assay(x1Temp) 
    },
    buildVst = function(){
      # vst is fast but aggressive
      x2Temp <- vst(.self$dds, blind=TRUE)
      .self$x2 <- assay(x2Temp)
    },
    buildLog2 = function(){
      # normalized by library sizes and add a constant.
      .self$x3 <- log2( counts(.self$dds, normalized=TRUE) + 1 )   # log(x+c)
    },
    drawPlot = function (x) {
      myColors = rainbow(dim(x)[2])
      # layout(matrix(c(1,1,2,3), 2, 2, byrow = TRUE))
      plot(density(x[,1]),col = myColors[1], lwd=2,
        xlab="Expresson values", ylab="Density", main= "Distribution of transformed data",
        cex.lab=1, cex.axis=1, cex.main=1, cex.sub=1
        ,ylim=c(0, max(density(x[,1])$y)) 
      )
      for(i in 2:dim(x)[2])
        lines(density(x[,i]),col=myColors[i], lwd=2 )
      legend("topright", cex=1,colnames(x), lty=rep(1,dim(x)[2]), col=myColors )
    },
    drawBoxPlot = function(x){
      # boxplot of first two samples, often technical replicates
      boxplot(x, las = 2, ylab="Transformed expression levels",
        main="Distribution of transformed data",cex.lab=1, cex.axis=1, cex.main=1, cex.sub=1)
    },
    drawLinePlot = function(x){
      plot(x[,1:2],xlab=colnames(x)[1],ylab=colnames(x)[2], 
        main="Scatter plot of first two samples",cex.lab=1, cex.axis=1, cex.main=1, cex.sub=1)    
    },
    # myheatmap2 <- function (x,bar,n=-1 ) {
    #   # 20 colors for kNN clusters
    #   mycolors = sort(rainbow(20))[c(1,20,10,11,2,19,3,12,4,13,5,14,6,15,7,16,8,17,9,18)] 
    #   # number of genes to show
    #   ngenes = as.character( table(bar))
    #   if(length(bar) >n && n != -1) {ix = sort( sample(1:length(bar),n) ); bar = bar[ix]; x = x[ix,]}
    #   # this will cutoff very large values, which could skew the color 
    #   x=as.matrix(x)-apply(x,1,mean)
    #   cutoff = median(unlist(x)) + 3*sd (unlist(x)) 
    #   x[x>cutoff] <- cutoff
    #   cutoff = median(unlist(x)) - 3*sd (unlist(x)) 
    #   x[x< cutoff] <- cutoff
    #   #colnames(x)= detectGroups(colnames(x))
    #   heatmap.2(x,  Rowv =F,Colv=F, dendrogram ="none",
    #     col=greenred(75), density.info="none", trace="none", scale="none", keysize=.3
    #     ,key=F, labRow = F
    #     ,RowSideColors = mycolors[bar]
    #     ,margins = c(8, 24)
    #     ,srtCol=45
    #   )
    #   legend.text = paste("Cluster ", toupper(letters)[unique(bar)], " (N=", ngenes,")", sep="")
    #   par(lend = 1)           # square line ends for the color legend
    #   legend("topright",      # location of the legend on the heatmap plot
    #     legend = legend.text, # category labels
    #     col = mycolors,  # color key
    #     lty= 1,             # line style
    #     lwd = 10            # line width
    #   )
    # },
    # distance function = 1-PCC (Pearson's correlation coefficient)
    # dist2 <- function(x, ...) {
    #   as.dist(1-cor(t(x), method="pearson"))
    # },
    convertID = function (query, selectOrg) {
      convert <- dbConnect(PostgreSQL(),
        host = "192.241.138.85", port = "5432",
        user = "idep", password = "sdsu57007", dbname="idep")
      querySet <- cleanGeneSet( unlist( strsplit( toupper(query),'\t| |\n|\\,')))
      # querySet is ensgene data for example, ENSG00000198888, ENSG00000198763, ENSG00000198804
      querySTMT <- paste( "select distinct id,ens,species from mapping where id IN ('", paste(querySet,collapse="', '"),"')",sep="")
      result <- dbGetQuery(convert, querySTMT)
      if( dim(result)[1] == 0  ) return(NULL) #if there is no record return NULL
      if(selectOrg == "BestMatch") {
        comb = paste( result$species,result$idType)
        sortedCounts = sort(table(comb),decreasing=T)
        recognized =names(sortedCounts[1])
        result <- result[which(comb == recognized),]
        speciesMatched=sortedCounts
        names(speciesMatched )= sapply(as.numeric(gsub(" .*","",names(sortedCounts) ) ), findSpeciesByIdName  ) 
        speciesMatched <- as.data.frame( speciesMatched )
        if(length(sortedCounts) == 1) { # if only  one species matched
          speciesMatched[1,1] <-paste( rownames(speciesMatched), "(",speciesMatched[1,1],")",sep="")
        } else {# if more than one species matched
          speciesMatched[,1] <- as.character(speciesMatched[,1])
          speciesMatched[,1] <- paste( speciesMatched[,1]," (",speciesMatched[,2], ")", sep="") 
          speciesMatched[1,1] <- paste( speciesMatched[1,1],"   ***Used in mapping***  To change, select from above and resubmit query.") 	
          speciesMatched <- as.data.frame(speciesMatched[,1])
        }
      } else { # if species is selected
        result <- result[which(result$species == selectOrg ) ,]
        if( dim(result)[1] == 0  ) return(NULL) #stop("ID not recognized!")
        speciesMatched <- as.data.frame(paste("Using selected species ", findSpeciesByIdName(selectOrg) )  )
      }
      
      result <- result[which(!duplicated(result[,2]) ),] # remove duplicates in ensembl_gene_id
      result <- result[which(!duplicated(result[,1]) ),] # remove duplicates in user ID
      
      colnames(speciesMatched) = c("Matched Species (genes)" ) 
      conversionTable <- result[,1:2]
      colnames(conversionTable) = c("User_input","ensembl_gene_id")
      conversionTable$Species = sapply(result[,3], findSpeciesByIdName )
      
      .self$finalResult <- list(originalIDs = querySet,
        IDs=unique( result[,2]), 
        species = findSpeciesById(result$species[1]), 
        #idType = findIDtypeById(result$idType[1] ),
        speciesMatched = speciesMatched,
        conversionTable = conversionTable)
    }
  )
)


