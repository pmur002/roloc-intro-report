
# Base image
FROM ubuntu:16.04
MAINTAINER Paul Murrell <paul@stat.auckland.ac.nz>

# add CRAN PPA
RUN apt-get update && apt-get install -y apt-transport-https
RUN echo 'deb https://cloud.r-project.org/bin/linux/ubuntu xenial/' > /etc/apt/sources.list.d/cran.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install additional software
# R stuff
RUN apt-get update && apt-get install -y \
    xsltproc \
    r-base=3.4* \ 
    libxml2-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    bibtex2html \
    subversion 

# For building the report
RUN Rscript -e 'install.packages(c("knitr", "devtools"), repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("xml2", "1.1.1", repos="https://cran.rstudio.com/")'

# The main report package(s)
RUN Rscript -e 'library(devtools); install_github("pmur002/roloc@v0.1", repos="https://cran.rstudio.com/")'

# Packages used in the report
# For gridGraphics (for BrailleR)
RUN apt-get update && apt-get install -y imagemagick
RUN Rscript -e 'library(devtools); install_github("ajrgodfrey/BrailleR@7c3a623")'
RUN Rscript -e 'library(devtools); install_version("colorspace", "1.3-2", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("ggplot2", "2.2.1", repos="https://cran.rstudio.com/")'
RUN Rscript -e 'library(devtools); install_version("stringr", "1.2.0", repos="https://cran.rstudio.com/")'


