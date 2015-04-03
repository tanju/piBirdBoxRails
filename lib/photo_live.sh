#!/bin/bash
#
# This script takes a image and prepares it for live image page

# May be useful to store image permanently
#NOW=$(date +"%Y%m%d_%H%M%S")
#FILENAME="/home/jan/Bilder/aufnahmen/img_live_${NOW}_${1}.jpg"

FILENAME="/home/jan/prg/ruby/vogelhaus/public/assets/images/capt_live_640.jpg"

raspistill -o "${FILENAME}" -t 1 -w 648 -h 486 -n -ISO 640
