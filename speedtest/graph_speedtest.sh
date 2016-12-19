#!/bin/bash

#This script will create the graphs for speedtest based of the speedtest.rrd values

DATE=`/bin/date "+%Y.%m.%d-%H%M%S"`
RRD_PATH="~/networkmonit/RRD/speedtest.rrd"
WEBPATH="/var/www/networkmonit/speedtest/"
cd $WEBPATH

PARAMS_ARRAY=("--" "-s e-1h" "-s e-12h" "-s e-24h" "-s e-1w" "-s e-1m" "-s e-1y")
TITLE_ARRAY=("" "Last hour" "Last 12h" "Last 24h" "Last week" "Last month" "Last year")
FILENAME_ARRAY=("a" "1h" "12h" "24h" "week" "month" "year")

for N in {0..6}
do
rrdtool graphv -J "$WEBPATH"my-ping-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Ping ${TITLE_ARRAY[$N])}" \
--vertical-label "ms" \
--alt-y-grid \
--upper-limit 1000 --lower-limit 0 \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:MY-PING:AVERAGE" \
"DEF:TMIN=$RRD_PATH:MY-PING:MIN" \
"DEF:TMAX=$RRD_PATH:MY-PING:MAX" \
'AREA:T#48C4EC::STACK' \
'LINE1:T#1598C3:Ping                  ' \
'AREA:TMIN#7648EC:Ping max            ' \
'AREA:TMIN#ECD748:Ping min\l' \
'GPRINT:T:LAST:Last Ping\: %2.1lf ms\l' \
'GPRINT:TMAX:MAX:Max Ping\: %2.1lf ms\l' \
'GPRINT:TMIN:MIN:Min Ping\: %2.1lf ms'

rrdtool graphv -J "$WEBPATH"my-downlink-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Downlink speed ${TITLE_ARRAY[$N])}" \
--vertical-label "Mbit/s" \
--alt-y-grid \
--upper-limit 4 --lower-limit 0 \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:MY-DOWNLINK:AVERAGE" \
"DEF:TMIN=$RRD_PATH:MY-DOWNLINK:MIN" \
"DEF:TMAX=$RRD_PATH:MY-DOWNLINK:MAX" \
'AREA:T#54EC48::STACK' \
'LINE1:T#24BC14:Downlink              ' \
'AREA:TMIN#7648EC:Down max              ' \
'AREA:TMIN#ECD748:Down min\l' \
'GPRINT:T:LAST:Last downlink\: %2.1lf Mbit/s\l' \
'GPRINT:TMAX:MAX:Max downlink\: %2.1lf Mbit/s\l' \
'GPRINT:TMIN:MIN:Min downlink\: %2.1lf Mbit/s'

rrdtool graphv -J "$WEBPATH"my-uplink-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Uplink speed ${TITLE_ARRAY[$N])}" \
--vertical-label "Mbit/s" \
--alt-y-grid \
--upper-limit 6 --lower-limit 0 \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:MY-UPLINK:AVERAGE" \
"DEF:TMIN=$RRD_PATH:MY-UPLINK:MIN" \
"DEF:TMAX=$RRD_PATH:MY-UPLINK:MAX" \
'AREA:T#EA644A::STACK' \
'LINE1:T#CC3118:Uplink                 ' \
'AREA:TMIN#7648EC:Up max               ' \
'AREA:TMIN#ECD748:Up min\l' \
'GPRINT:T:LAST:Last uplink\: %2.1lf Mbit/s\l' \
'GPRINT:TMAX:MAX:Max uplink\: %2.1lf Mbit/s\l' \
'GPRINT:TMIN:MIN:Min uplink\: %2.1lf Mbit/s' 

done
