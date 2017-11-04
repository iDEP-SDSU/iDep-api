library(plumber)
source('installLib.R')
source('readData.R')
source('kmean/kmean.R')
source('setup.R', echo=F)

r <- plumb("plumberImp.R")
r$run(host='0.0.0.0', port=8000)