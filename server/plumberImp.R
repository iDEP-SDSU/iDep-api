#source('classes/librarySetup.R', echo=T)
# source('classes/DataClass.R', echo=T)
source('readData.R')
source('setup.R', echo=F)

readDataObj <- ReadData()
data <- readDataObj$finalResult$rawCounts
preDataObj <- PreWork(data)
preDataObj$buildRLog()

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

#* @get /plot1
#' @png
normalMean <- function(res){
  preDataObj$drawPlot(preDataObj$x1)
}

#* @get /plot2
#' @png
normalMean <- function(res){
  preDataObj$drawBoxPlot(preDataObj$x1)
}

#* @get /plot3
#' @png
normalMean <- function(res){
  preDataObj$drawLinePlot(preDataObj$x1)
}