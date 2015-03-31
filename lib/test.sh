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

echo "$compare_temperature"
echo "$prev_temperature"
echo "$(($compare_temperature - $prev_temperature))"

if [ $(($compare_temperature - $prev_temperature)) -gt 1  ] || [ $(($prev_temperature - $compare_temperature )) -gt 1  ]
then
	echo "Abweichung um 2 Grad."
fi

