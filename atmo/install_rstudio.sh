#!/bin/bash

# Created by: https://github.com/Robinlovelace/install-gis-ubuntu
# Modified for CyVerse Atmosphere by Tyson Swetnam

# Ubuntu 16.04 installation

# install R/RStudio - see
# http://stackoverflow.com/questions/29667330
echo "install a few dependancies"
sudo apt-get update -y
sudo apt-get install libgstreamer0.10-0 -y
sudo apt-get install libgstreamer-plugins-base0.10-dev -y
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install libopenblas-base -y
sudo apt-get install libxml2-dev -y
sudo apt-get install make -y
sudo apt-get install gcc -y
sudo apt-get install git -y
sudo apt-get install pandoc -y
sudo apt-get install libjpeg62 -y
sudo apt-get install unzip -y
sudo apt-get install curl -y
sudo apt-get install littler -y
sudo apt-get install openjdk-7-* -y
sudo apt-get install gedit -y
sudo apt-get install jags -y
sudo apt-get install imagemagick -y
sudo apt-get install docker-engine -y
sudo apt-get install libv8-dev -y
sudo apt-get install gdebi-core -y

echo "edit the sources file to prepare to install R"
# see http://cran.r-project.org/bin/linux/ubuntu/README

sudo sh -c 'echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" >> /etc/apt/sources.list' 

echo "get keys to install R"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9 

echo "install R and some helpers"
sudo apt-get update
sudo apt-get install r-base  -y
sudo apt-get install r-base-dev -y
sudo apt-get install r-cran-xml  -y
sudo apt-get install r-cran-rjava -y
sudo R CMD javareconf # for rJava

echo "install RStudio-Server from the web"

sudo apt-get install -f -y
sudo wget https://download2.rstudio.org/rstudio-server-1.1.383-amd64.deb
sudo gdebi --non-interactive rstudio-server-1.1.383-amd64.deb

echo "start R and install commonly used packages"
# http://stackoverflow.com/q/4090169/1036500
# Make an R script file to use in a moment...
LOADSTUFF="options(repos=structure(c(CRAN='http://cran.rstudio.com/')))
update.packages(checkBuilt = TRUE, ask = FALSE)
packages <- c('devtools', # for easy package development and installation from github
              'knitr',    # for dynamic documents
              'roxygen2',  # for installing sf
              'tidyverse' # stack of packages from Hadley Wickham and friends
              )
install.packages(packages)
# from github
devtools::install_github(c('rstudio/leaflet'))
geopkgs = c(
  'sp',       # spatial data classes and functions
  'rgdal',    # spatial data I/O
  'rgeos',    # spatial manipulation
  'sf',       # newschool spatial data classes + functions
  'tmap',     # powerful and flexible mapping package
  'mapview',  # a quick way to create interactive maps (depends on leaflet)
  'shiny',    # for converting your maps into online applications
  'OpenStreetMap', # for downloading OpenStreetMap tiles
  'rasterVis',# raster visualisation (depends on the raster package)
  'geojsonio',# for reading/writing geojson files
  'rmapshaper', # access to the mapshaper JavaScript library from R
  'stplanr'   # some functions from transport planning
)
install.packages(geopkgs)"

# put that R code into an R script file
FILENAME1="loadstuff.r"
sudo echo "$LOADSTUFF" > /tmp/$FILENAME1

# Make a shell file that contains instructions in bash for running that R script file
# from the command line. There may be a simpler way, but nothing I tried worked.
NEWBASH='#!/usr/bin/env
sudo Rscript /tmp/loadstuff.r'
FILENAME2="loadstuff.sh"

# put that bash code into a shell script file
sudo echo "$NEWBASH" > /tmp/$FILENAME2

# run the bash file to exectute the R code and install the packages
sh /tmp/loadstuff.sh
# clean up by deleting the temp file
rm /tmp/loadstuff.sh
