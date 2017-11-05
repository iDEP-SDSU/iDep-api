library(plumber)
# source('installLib.R')
source('setup.R', echo=F)
source('readData.R')
source('kmean/kmean.R')


r <- plumb("plumberImp.R")
r$run(host='0.0.0.0', port=8000)
