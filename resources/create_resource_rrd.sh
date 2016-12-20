#!/bin/bash

# Create the RRD for all resources results.
# It should only be run once when you are creating the RRD file for the first time.

PATH_RRD="~/networkmonit/RRD/resources.rrd"

rrdtool create ~/networkmonit/RRD/resources.rrd -b 1477308840 -s 300 DS:PI-TEMP:GAUGE:600:0:100 DS:CPU:GAUGE:600:0:200 DS:MEM:GAUGE:600:0:1000 DS:FS:GAUGE:600:0:100 DS:PROC:GAUGE:600:0:1500 DS:ESTB:GAUGE:600:0:200 DS:LSN:GAUGE:600:0:200 RRA:LAST:0:60:8785 RRA:MIN:0:60:8785 RRA:MAX:0:60:8785 RRA:AVERAGE:0:1:8785

