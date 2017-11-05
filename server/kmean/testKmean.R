# Test kmean 

source('setup.R', echo=F)
source('readData.R')
source('kmean/kmean.R')


library(tictoc)

tic()
readDataObj <- ReadData()
data <- readDataObj$finalResult$rawCounts


# Initialize Kmean 
kmeanObj <- KmeansDrive$new(data)

kmeanObj$originData
kmeanObj$heatmapData



kmeanObj2 <- KmeansDrive$new(data)
kmeanObj2$originData


kmeanObj$preprocess(n=1000)
kmeanObj$heatmapData

# kmeanObj$heatmapData
kmeanObj$myheatmap2(n=1000)

toc()

# Test different parameters 
n=3000
k=4
kmeanObj$preprocess(n=n, k=k)
kmeanObj$heatmapData

kmeanObj$myheatmap2(1000)



# Takes 20s
# n=4000 
# k=6
# kmeanObj$preprocess(n=n, k=k)
# kmeanObj$myheatmap2(n=2000)
