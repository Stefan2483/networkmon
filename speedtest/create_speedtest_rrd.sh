#!/bin/bash

# Create the RRD for all speedtest results.
# It should only be run once when you are creating the RRD file for the first time.

DATE=`/bin/date "+%Y.%m.%d-%H%M%S"`

RRD_PATH="~/networkmonit/RRD/speedtest.rrd"

rrdtool create ~/networkmonit/RRD/speedtest.rrd -b 1477308840 -s 300 DS:MY-PING:GAUGE:600:0:6000 DS:MY-DOWNLINK:GAUGE:600:0:3000 DS:MY-UPLINK:GAUGE:600:0:3000 RRA:MIN:0:60:8785 RRA:MAX:0:60:8785 RRA:AVERAGE:0:1:8785
