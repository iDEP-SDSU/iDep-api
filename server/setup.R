Rlibs = c("RSQLite","gplots","ggplot2","e1071","reshape2","DT","RPostgreSQL", "dplyr")
biocLibs = c( "limma", "DESeq2","edgeR","gage", "PGSEA", "fgsea", "ReactomePA", "pathview","PREDA","PREDAsampledata",
  "sfsmisc","lokern","multtest","hgu133plus2.db")
lapply(Rlibs, require, character.only = TRUE)
lapply(biocLibs, require, character.only = TRUE)
