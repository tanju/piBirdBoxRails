#!/bin/bash
#
# This script reads the CPU's temperature and adds a new record into
# the database, if the temperature changed.
#
# The temperature value is cut to one decimal (i.e. 47.001 -> 47.0)
#
# Jan Arnhold, March 2013

tmp_temperature=`cat /sys/class/thermal/thermal_zone0/temp`
curr_temperature=${tmp_temperature:0:3}
compare_temperature=${tmp_temperature:0:2}
prev_temperature=`cat /tmp/cpu_temperature`

if [ $(($compare_temperature - $prev_temperature)) -gt 1  ] || [ $(($prev_temperature - $compare_temperature )) -gt 1  ]
then
	echo "$compare_temperature" >/tmp/cpu_temperature
	
	timestamp=`date +%s`
	echo "INSERT INTO cpu_temperatures VALUES( null, datetime($timestamp, 'unixepoch'), $curr_temperature, datetime($timestamp, 'unixepoch'), datetime($timestamp, 'unixepoch') );" | sqlite3 /home/jan/prg/ruby/vogelhaus/db/development.sqlite3
fi

