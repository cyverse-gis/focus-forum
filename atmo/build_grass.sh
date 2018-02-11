#!/bin/bash

sudo apt-get -y update 

# install build dependency packages:
sudo apt-get build-dep -yy --allow-unauthenticated grass

# Install binary PROJ GEOS & GDAL 
sudo apt-get install -yy --allow-unauthenticated \
	libproj-dev \
	proj-data \
	proj-bin \
	libgeos-dev \
	libgdal-dev \
	python-gdal \
	gdal-bin

wget -nv --no-check-certificate https://grass.osgeo.org/grass74/source/grass-7.4.0.tar.gz \
	 && sudo tar xzf grass-7.4.0.tar.gz -C /opt \
	 && cd /opt/grass-7.4.0 \
	 
sudo chown $USER:root /opt/grass-7.4.0 -R

# configure to taste..
CFLAGS="-O2 -Wall" LDFLAGS="-s" ./configure \
    --with-openmp \
    --with-python=yes \
    --enable-largefile=yes \
    --with-nls \
    --with-cxx \
    --with-proj-share=/usr/share/proj/ \
    --with-geos \
    --with-wxwidgets \
    --with-cairo \
    --with-opengl-libs=/usr/include/GL \
    --with-freetype=yes --with-freetype-includes="/usr/include/freetype2/" \
    --with-postgres=yes --with-postgres-includes="/usr/include/postgresql" \
    --with-sqlite=yes \
    --with-mysql=yes --with-mysql-includes="/usr/include/mysql" \
    --with-odbc=no \
     2>&1 | tee config_log.txt

 # build using nproc CPU cores
 NPROC=$(nproc)
 time sudo make -j $NPROC 2>&1 | tee build_log.txt

 sudo make install
