#!/bin/bash
#
NOW=$(date +"%Y%m%d_%H%M%S")
FILENAME="/home/jan/Bilder/aufnahmen/img_${NOW}_${1}.jpg"

raspistill -o "${FILENAME}" -t 1 -w 1296 -h 972 -n
