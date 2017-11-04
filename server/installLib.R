list.of.packages <- c("method", "RSQLite","gplots","ggplot2","e1071","reshape2","DT","RPostgreSQL", "dplyr", "uuid")
list.of.bio.packages  <- c( "limma", "DESeq2","edgeR","gage", "PGSEA", "fgsea", "ReactomePA", "pathview","PREDA","PREDAsampledata",
  "sfsmisc","lokern","multtest","hgu133plus2.db")
#Install Require packages
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
new.bio.packages <- list.of.bio.packages[!(list.of.bio.packages %in% installed.packages()[,"Package"])]
if(length(list.of.bio.packages)){
  source("https://bioconductor.org/biocLite.R")
  biocLite(new.bio.packages, suppressUpdates = T)
} 
#Load Packages
lapply(list.of.packages, require, character.only = TRUE)
lapply(list.of.bio.packages, require, character.only = TRUE)