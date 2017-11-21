#!/bin/bash

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
