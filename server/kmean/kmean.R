library(R6)
KmeansDrive = R6Class("KmeansDrive",
  public = list(
    mycolors = NULL,
    heatColors = NULL,
    pathwayIDs = 'ANY',
    heatmapData = NULL,
    originData = NULL,

    initialize = function(data) {
      self$mycolors <- sort(rainbow(20))[c(1,20,10,11,2,19,3,12,4,13,5,14,6,15,7,16,8,17,9,18)] # 20 colors for kNN clusters
      self$heatColors <- rbind(greenred(75),bluered(75),colorpanel(75,"green","black","magenta"))

      
      self$originData <- data
      self$preprocess()
    },

    pathwayIDFreq = function(querySet, df) {
      .self$pathwayIDs <- df %>%
        filter(gene %in% querySet) %>%
        group_by(pathwayID) %>%
        summarise(n = n())
    },
    # Utility
    cleanGeneSet = function (x){
      # remove duplicate; upper case; remove special characters
      x <- unique( toupper( gsub("\n| ","",x) ) )
      x <- x[which( nchar(x)>1) ]  # genes should have at least two characters
      return(x)
    },
    findSpeciesByIdName = function (speciesID){ # find species name use id
      return( orgInfo[which(orgInfo$id == speciesID),3]  )
    },
    #find idType based on index
    findIDtypeById = function(x){ # find
      return( idIndex$idType[ as.numeric(x)] )
    },
    findSpeciesById = function (speciesID){ # find species name use id
      return( orgInfo[which(orgInfo$id == speciesID),]  )
    },
    hclust2 = function(x, method="average", ...){  # average linkage
      hclust(x, method=method, ...)
    },
    dist2 = function(x, ...) {
      as.dist(1-cor(t(x), method="pearson"))
    },
    preprocess = function(n=2000, k=4){
      x <- self$originData
      x = 100* x[1:n,] / apply(x[1:n,],1,function(y) sum(abs(y)))
      cl = kmeans(x, k, iter.max = 50)
      hc <- self$hclust2(self$dist2(cl$centers-apply(cl$centers,1,mean) )  )# perform cluster for the
      tem = match(cl$cluster,hc$order)
      newData = x[order(tem),] # data
      bar = sort(tem)
      #bar
      kmean.result <- list( x = newData, bar = bar)
      afterMean <- kmean.result$x - apply(kmean.result$x,1,mean)
      self$heatmapData <- afterMean
    },
    
    myheatmap2 = function (bar=NULL, n=-1, mycolor=1, clusterNames=NULL) {
      set.seed(2)
      # number of genes to show
      x <- self$heatmapData
      ngenes = as.character( table(bar))
      if(length(bar) >n && n != -1) {
        ix = sort( sample(1:length(bar),n) )
        bar = bar[ix]
        x = x[ix,]
      }

      # this will cutoff very large values, which could skew the color
      x=as.matrix(x)-apply(x,1,mean)
      cutoff = median(unlist(x)) + 3*sd (unlist(x))
      x[x>cutoff] <- cutoff
      cutoff = median(unlist(x)) - 3*sd (unlist(x))
      x[x< cutoff] <- cutoff

      if(is.null(bar)) # no side colors
        heatmap.2(x,  Rowv =F,Colv=F, dendrogram ="none",
          col=self$heatColors[as.integer(mycolor),], density.info="none", trace="none", scale="none", keysize=.3
          ,key=F, labRow = F,
          #,RowSideColors = mycolors[bar]
          margins = c(8, 24)
          ,srtCol=45
        )
      else
        heatmap.2(x,  Rowv =F,Colv=F, dendrogram ="none",
          col=self$heatColors[as.integer(mycolor),], density.info="none", trace="none", scale="none", keysize=.3
          ,key=F, labRow = F,RowSideColors = mycolors[bar],margins = c(8, 24),srtCol=45
        )

      if(!is.null(bar)) {
        legend.text = paste("Cluster ", toupper(letters)[unique(bar)], " (N=", ngenes,")", sep="")
        if( !is.null( clusterNames ) && length(clusterNames)>= length( unique(bar)))
          legend.text = paste(clusterNames[ 1:length( unique(bar) )  ], " (N=", ngenes,")", sep="")
        par(lend = 1)           # square line ends for the color legend
        legend("topright",      # location of the legend on the heatmap plot
          legend = legend.text, # category labels
          col = mycolors,  # color key
          lty= 1,             # line style
          lwd = 10 )           # line width
      }
    }
  )
)


# readDataObj <- ReadData()
# data <- readDataObj$finalResult$rawCounts

# # Initialize Kmean
# kmeanObj <- KmeansDrive$new(data)
# kmeanObj$heatmapData

# layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))

# n=2000
# k=4
# kmeanObj$preprocess(n=n, k=k)
# kmeanObj$myheatmap2(kmean.result$bar, 1000)

# n=3000
# k=4
# kmeanObj$preprocess(n=n, k=k)
# kmeanObj$myheatmap2(kmean.result$bar, 1000)

# n=5000
# k=4
# kmeanObj$preprocess(n=n, k=k)
# kmeanObj$myheatmap2(kmean.result$bar, 1000)

# n=7000
# k=4
# kmeanObj$preprocess(n=n, k=k)
# kmeanObj$myheatmap2(kmean.result$bar, 1000)
