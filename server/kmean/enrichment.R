library(R6)
Enrichment = R6Class("Enrichment",
    public = list(
        mycolors = NULL,
        heatColors = NULL,
        pathwayIDs = 'ANY',
        heatmapData = NULL,
        originData = NULL,

        initialize = function(data) {

        },

        findSpeciesByIdName = function (speciesID){ # find species name use id
            return( orgInfo[which(orgInfo$id == speciesID),3]  )
        },

        # Clean up gene sets. Remove spaces and other control characters from gene names  
        cleanGeneSet = function (x){
            # remove duplicate; upper case; remove special characters
            x <- unique( toupper( gsub("\n| ","",x) ) )
            x <- x[which( nchar(x)>1) ]  # genes should have at least two characters
            return(x)
        },

        findSpeciesById <- function (speciesID){ # find species name use id
            return( orgInfo[which(orgInfo$id == speciesID),]  )
        },

        convertID = function (query,selectOrg) {

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
            
            finalResult <- list(originalIDs = querySet,
                IDs=unique( result[,2]), 
                species = findSpeciesById(result$species[1]), 
                #idType = findIDtypeById(result$idType[1] ),
                speciesMatched = speciesMatched,
                conversionTable = conversionTable)

            return(finalResult)
        }
    )
)