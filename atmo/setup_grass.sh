#!/bin/bash

# set locale (this fixes an error we had in GRASS environment on startup)
    locale-gen en_US en_US.UTF-8
    dpkg-reconfigure locales 
    echo "LC_ALL=en_US.UTF-8" >> /etc/environment
    echo "LANG=en_US.UTF-8" >> /etc/environment
    
    echo "Updating library paths"
    cd /etc/ld.so.conf.d
    echo "/opt/eemt/lib" >> eemt.conf
    echo "/opt/eemt/lib64" >> eemt.conf
    echo "/opt/eemt/grass-7.4.0/lib" >> grass.conf
    ldconfig

# once everything is built, we can install GRASS extensions
# Create a dummy mapset so we can install Addons
# Run GRASS74 and Install Addons
    
    export LC_ALL=en_US.UTF-8 && \
        export LANG=en_US.UTF-8 && \
        export PATH=/opt/eemt/bin:/opt/eemt/grass-7.4.0/bin:/opt/eemt/grass-7.4.0/scripts/:$PATH && \
        export GISBASE=/opt/eemt/grass-7.4.0 && \
        rm -rf mytmp_wgs84 && \
        grass74 -text -c epsg:3857 ${PWD}/mytmp_wgs84 -e && \
        echo "g.extension -s extension=r.sun.mp ; g.extension -s extension=r.sun.hourly ; g.extension -s extension=r.sun.daily" | grass74 -text ${PWD}/mytmp_wgs84/PERMANENT


# Setup GRASS Environment
WORKING_DIR=/tmp
LOCATION=$HOME/Documents/tmp_${WORKING_DIR}/PERMANENT
GRASSRC=$HOME/.grassrc74_${WORKING_DIR}
export GISRC=${GRASSRC}
export GRASS_VERBOSE=0

echo "GISDBASE: $HOME/grass_data" >> $GRASSRC
echo "LOCATION_NAME: tmp_${WORKING_DIR}" >> $GRASSRC
echo "MAPSET: PERMANENT" >> $GRASSRC
echo "GRASS_GUI: text" >> $GRASSRC

# Create a mapset
grass74 -c epsg:3857 ${PWD}/mytmp -e

# Run GRASS72
grass74 ${PWD}/mytmp/PERMANENT
