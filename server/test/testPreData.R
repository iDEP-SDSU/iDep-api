source('readData.R')
source('setup.R', echo=F)

### TODO: ORGINFO data
convert <- dbConnect(PostgreSQL(),
  host = "192.241.138.85", port = "5432",
  user = "idep", password = "sdsu57007", dbname="idep")
orgInfo <- dbGetQuery(convert, paste("select distinct * from orgInfo " ))
orgInfo <- orgInfo[order(orgInfo$name),]
######## 

readDataObj <- ReadData()
data <- readDataObj$finalResult$rawCounts
preDataObj <- PreWork(data)
preDataObj$buildRLog()

# preDataObj$x1
preDataObj$drawPlot(preDataObj$x1)
preDataObj$drawBoxPlot(preDataObj$x1)
preDataObj$drawLinePlot(preDataObj$x1)

querySet <- rownames(data)
converted <- preDataObj$convertID(querySet, "BestMatch")


################ TODO: Kmean class


library(tictoc)
tic()
### K-mean Heatmap: 6 Seconds
n <- 2000
x <- data
x = 100* x[1:n,] / apply(x[1:n,],1,function(y) sum(abs(y))) 
set.seed(2)
k=4
cl = kmeans(x, k, iter.max = 50)
hc <- hclust2(dist2(cl$centers-apply(cl$centers,1,mean) )  )# perform cluster for the
tem = match(cl$cluster,hc$order)
newData = x[order(tem),] # data 
bar = sort(tem)
#bar
kmean.result <- list( x = newData, bar = bar)
afterMean <- kmean.result$x - apply(kmean.result$x,1,mean)
myheatmap2( afterMean, kmean.result$bar, 1000)
toc()

### Enriched pathways for each cluster
library(dplyr)
row_means <- as_tibble(kmean.result$x) %>%
  mutate(mean = rowMeans(.[,])) 

## Redis 
library(rredis)
redisConnect(host="bioinformatics.sdstate.edu", port=6379)
gmtDataKey <- redisKeys()
ix = grep(converted$species[1,1],gmtDataKey)
tempT <- redisGet(gmtDataKey[ix])
# print(object.size(tempT) ,unit="MB")
df <- as_tibble(tempT)

resultGene <- df %>% 
  filter(gene %in% querySet) %>% 
  group_by(pathwayID) %>%
  summarise(n = n())
#Reduce('|', lapply(data, '%in%', condition)) will be much faste

pathwayIDs = resultGene %>% filter ( n >= 5 & n <= 1000 ) # better version

## Find geneSets information
pathwayIDs = as.data.frame(pathwayIDs)
geneSets = lapply(pathwayIDs[,1], function(x)  resultGene[which(resultGene$pathwayID==x),1]) #???

