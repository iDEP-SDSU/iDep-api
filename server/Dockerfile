FROM rocker/r-base
MAINTAINER Kevin Son <eunwoo.son@sdstate.edu>

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  # libcurl4-gnutls-dev \
  libcurl4-openssl-dev \
  libxml2-dev \
  libxml2  \
  # https://stackoverflow.com/questions/42287164/install-udunits2-package-for-r3-3
  libudunits2-dev \ 
  libmariadb-client-lgpl-dev

RUN R -e 'install.packages(c("devtools"))'
RUN R -e 'devtools::install_github("trestletech/plumber")'
RUN R -e 'install.packages(c("method", "RSQLite","gplots","ggplot2","e1071","reshape2","DT","RPostgreSQL", "dplyr", "uuid"))'
RUN R -e 'source("https://bioconductor.org/biocLite.R"); biocLite(c("limma", "DESeq2","edgeR","gage", "PGSEA", "fgsea", "ReactomePA", "pathview","PREDA","PREDAsampledata", "sfsmisc","lokern","multtest","hgu133plus2.db"), suppressUpdates = T)'

COPY ./ /usr/local/src/plumber/
WORKDIR /usr/local/src/plumber/
VOLUME /usr/local/src/plumber/

EXPOSE 8000