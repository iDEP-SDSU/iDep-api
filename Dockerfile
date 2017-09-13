FROM rocker/shiny:latest

MAINTAINER Kevin Son "eunwoo.son@sdstate.edu"

RUN apt-get update -qq && apt-get install -y \
  git-core \
  libssl-dev \
  libcurl4-gnutls-dev

# install additional packages
COPY ./RSet /usr/local/src/myscripts
WORKDIR /usr/local/src/myscripts

CMD ["Rscript", "packages.R"]
CMD ["Rscript", "bioLitePackages.R"]

CMD ["/usr/bin/shiny-server.sh"]
