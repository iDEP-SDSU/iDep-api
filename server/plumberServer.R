library(plumber)
source('readData.R')
source('kmean/kmean.R')
source('setup.R', echo=F)

r <- plumb("./plumberImp.R")  
r$run(port=8000)