
#source('classes/librarySetup.R', echo=T)
source('classes/DataClass.R', echo=T)

library("rhdf5")



#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}


#* @get /human
normalMean <- function(samples=10){
  destination_file = "human_matrix.h5"
  genes = h5read(destination_file, "meta/genes")
  genes
}

#* @get /sample
normalMean <- function(samples=10){
  destination_file = "human_matrix.h5"
  samples = h5read(destination_file, "meta/Sample_geo_accession")
  samples
}

#* @get /tissue
normalMean <- function(samples=10){
  destination_file = "human_matrix.h5"
  tissue = h5read(destination_file, "meta/Sample_geo_accession")
  tissue
}

#* Get a graph of the values
#* @get /plots
plots <- function(){
  # load data
  dataObj <- DataClass$new(filePath="GSE37704_sailfish_genecounts.csv")
  localData = dataObj$data
  dt2 = localData[, lapply(.SD, sum, na.rm=TRUE), .SDcols=colsToSum]
  list(result =as.matrix(dt2/1e6))
}

#* Get a data from hdf5 file
#' @param fname If provided, filter the data to only this species (e.g. 'human_matrix.h5')
#' @param ref If provided, filter the data to only this species (e.g. 'meta/Sample_geo_accession')
#* @get /hdf5Read
hdf5Read <-function(fname, ref) {
  print("hit")
  result = h5read(fname, ref)
  return(result)
}

library(devtools)
install_github("shinyAce", "trestletech")
