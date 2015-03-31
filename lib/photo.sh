#!/bin/bash
#
NOW=$(date +"%Y%m%d_%H%M%S")

raspistill -o "/home/jan/Bilder/aufnahmen/img_${NOW}.jpg" -t 1 -w 1296 -h 972 -n
