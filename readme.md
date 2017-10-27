# iDep-Restful-API

[![](https://www.r-pkg.org/badges/version/plumber)](https://www.r-pkg.org/pkg/plumber)

Integrated Differential Expression and Pathway analysis (iDEP) of transcriptomic data. See documentation and manuscript. Based on annotation of 69 metazoa and 42 plant genomes in Ensembl BioMart as of 6/4/2017. Additional data from KEGG, Reactome, MSigDB (human), GSKB (mouse) and araPath (arabidopsis). For feedbacks or data contributions (genes and GO mapping of any species), please contact us, or visit our homepage. Send us suggestions or any error message to help improve iDEP.


## Installation

> Docker Awesome List: https://github.com/veggiemonk/awesome-docker

You can install the idep by docker



root@8cefc847e3e0:/tmp/data# psql -c "CREATE TABLE mapping  ( "id" TEXT,"ens" TEXT,"species" REAL,"idType" INTEGER );" -U idep -d idep
CREATE TABLE
root@8cefc847e3e0:/tmp/data# psql -c "COPY mapping(id, ens, species, idType) FROM '/tmp/data/map.csv' delimiter ',' csv header;" -U idep -d idep


## Swagger 

### predata
### kmean 