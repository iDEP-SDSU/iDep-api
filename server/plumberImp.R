
readDataObj <- ReadData()
data <- readDataObj$finalResult$rawCounts
preDataObj <- PreWork(data)
preDataObj$buildRLog()
count <- 0

#* @filter logger
function(req){
  cat(as.character(Sys.time()), "-", 
    req$REQUEST_METHOD, req$PATH_INFO, "-", 
    req$HTTP_USER_AGENT, "@", req$REMOTE_ADDR, "\n")
  plumber::forward()
}

#* @filter setuser
function(req){
  un <- req$cookies$user
  # Make req$username available to endpoints
  req$username <- un
  plumber::forward()
}

#* @filter cors
cors <- function(res) {
  res$setHeader("Access-Control-Allow-Origin", "*")
  plumber::forward()
}

#* @get /status
function(req){
  
  status = list(msg = "ALIVE", date = Sys.time())
  return(status)
}


#* @get /sessionCounter
function(req){
  if (!is.null(req$session$counter)){
    count <- as.numeric(req$session$counter)
  }
  req$session$counter <- count + 1
  return(paste0("This is visit #", count))
}

#* @get /transform
transform <- function() {
  preDataObj$buildRLog()
  preDataObj$buildVst()
  preDataObj$buildLog2()
  return ("Done")
}

#* @get /transform/log
transform <- function() {
  options(digits=2)
  logList <- list()
  cols <- colnames(preDataObj$x1)
  for(col in 1:length(cols)){
    colName <- cols[col]
    normal <- density(preDataObj$x2[,col])
    logList[[ colName ]] <- list(x=normal$x, y=normal$y)
  }
  return(logList)
}

#* @get /transform/vst
transform <- function() {
  options(digits=2)
  logList <- list()
  cols <- colnames(preDataObj$x2)
  for(col in 1:length(cols)) {
    colName <- cols[col]
    normal <- density(preDataObj$x2[,col])
    logList[[ colName ]] <- list(x=normal$x, y=normal$y)
  }
  return(logList)
}

#* @get /transform/log2
transform <- function() {
  options(digits=2)
  logList <- list()
  cols <- colnames(preDataObj$x3)
  for(col in 1:length(cols)) {
    colName <- cols[col]
    normal <- density(preDataObj$x3[,col])
    logList[[ colName ]] <- list(x=normal$x, y=normal$y)
  }
  return(logList)
}

#* @get /logData
normalMean <- function(res) {
  preDataObj$x1
}

#* @get /plot1
#' @png
normalMean <- function(res) {
  preDataObj$drawPlot(preDataObj$x1)
}

#* @get /plot2
#' @png
normalMean <- function(res) {
  preDataObj$drawBoxPlot(preDataObj$x1)
}

#* @get /plot3
#' @png
normalMean <- function(res) {
  preDataObj$drawLinePlot(preDataObj$x1)
}

#* @get /heatmap
#' @png
normalMean <- function(res) {
  kmeanObj <- KmeansDrive$new(data)
  kmeanObj$myheatmap2(n=1000)
}

#* @get /heatmapdata
normalMean <- function(res) {
  kmeanObj <- KmeansDrive$new(data)
  kmeanObj$myheatmapProcess(n=1000)
  kmeanObj$myHeatMapData
}

