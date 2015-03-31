#!/bin/bash
#
# Script zum Starten der Birdbox Komponenten

# init temperature recording
tmp_temperature=`cat /sys/class/thermal/thermal_zone0/temp`
compare_temperature=${tmp_temperature:0:2}
echo "$compare_temperature" >/tmp/cpu_temperature

# Birdbox client
cd ~
cd prg/ruby/vogelhaus/lib
(./birdbox_client.sh &)

# rails
cd ..
(rails s &)
