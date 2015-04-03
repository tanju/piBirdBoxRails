#!/bin/bash
#
NOW=$(date +"%Y%m%d_%H%M%S")
FILENAME="/home/jan/Bilder/aufnahmen/img_${NOW}_${1}.jpg"

raspistill -o "${FILENAME}" -t 250 -w 1296 -h 972 -n

# convert image
convert "${FILENAME}" -resize "640x640" "/home/jan/prg/ruby/vogelhaus/public/assets/images/capt_current_640.jpg"
