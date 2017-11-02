library(plumber)
source('readData.R')
source('kmean/kmean.R')
source('setup.R', echo=F)
r <- plumb("./plumberImp.R")  # Where 'myfile.R' is the location of the file shown above
r$run(port=8000)