#!/bin/bash

#This script will create the graphs for resources based on the values from resources.rrd

DATE=`/bin/date "+%Y.%m.%d-%H%M%S"`
RRD_PATH="~/networkmonit/RRD/resources.rrd"
WEBPATH="/var/www/networkmonit/resources/"
cd $WEBPATH

PARAMS_ARRAY=("--" "-s e-1h" "-s e-12h" "-s e-24h" "-s e-1w" "-s e-1m" "-s e-1y")
TITLE_ARRAY=("" "Last hour" "Last 12h" "Last 24h" "Last week" "Last month" "Last year")
FILENAME_ARRAY=("a" "1h" "12h" "24h" "week" "month" "year")

for N in {0..6}
do

rrdtool graphv -J "$WEBPATH"pi-temp-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Motherboard temperature sensor (°C) ${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 100 --lower-limit 0 -r \
--vertical-label "temperature (°C)" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:PI-TEMP:AVERAGE" \
"DEF:TMIN=$RRD_PATH:PI-TEMP:MIN" \
"DEF:TMAX=$RRD_PATH:PI-TEMP:MAX" \
'AREA:T#FF00FF::STACK' \
'HRULE:80#ff8080:Critical  ' \
'LINE1:T#1598C3:Temp  ' \
'AREA:TMIN#7648EC:Temp max  ' \
'AREA:TMIN#ECD748:Temp min\l' \
'GPRINT:T:LAST:Last Temp\: %2.1lf °C\l' \
'GPRINT:TMAX:MAX:Max Temp\: %2.1lf °C\l' \
'GPRINT:TMIN:MIN:Min Temp\: %2.1lf °C'

rrdtool graphv -J "$WEBPATH"CPU-"${FILENAME_ARRAY[$N]}".png -a PNG --title="CPU utilization (.%)${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 150 --lower-limit 0 -r \
--vertical-label "CPU value %" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:CPU:AVERAGE" \
"DEF:TMIN=$RRD_PATH:CPU:MIN" \
"DEF:TMAX=$RRD_PATH:CPU:MAX" \
'HRULE:100#ff8080:Critical  ' \
'AREA:T#48C4EC::STACK' \
'LINE1:T#1598C3:CPU  ' \
'AREA:TMIN#7648EC:CPU max  ' \
'AREA:TMIN#ECD748:CPU min\l' \
'GPRINT:T:LAST:Last CPU percentage\: %2.1lf %%\l' \
'GPRINT:TMAX:MAX:Max CPU percentage\: %2.1lf %%\l' \
'GPRINT:TMIN:MIN:Min CPU percentage\: %2.1lf %%'

rrdtool graphv -J "$WEBPATH"MEM-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Memory utilization (Mb) ${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 1100 --lower-limit 0 -r \
--vertical-label "Mem value Mb" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:MEM:AVERAGE" \
"DEF:TMIN=$RRD_PATH:MEM:MIN" \
"DEF:TMAX=$RRD_PATH:MEM:MAX" \
'HRULE:925#ff8080:Critical  ' \
'AREA:T#54EC48::STACK' \
'LINE1:T#24BC14:Memory  ' \
'AREA:TMIN#7648EC:Mem max  ' \
'AREA:TMIN#ECD748:Mem min\l' \
'GPRINT:T:LAST:Last Memory value\: %2.1lf Mb\l' \
'GPRINT:TMAX:MAX:Max Memory value\: %2.1lf Mb\l' \
'GPRINT:TMIN:MIN:Min Memory value\: %2.1lf Mb'

rrdtool graphv -J "$WEBPATH"FS-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Filesystem utilization (Gb) ${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 40 --lower-limit 0 -r \
--vertical-label "Filesystem value Gb" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:FS:AVERAGE" \
"DEF:TMIN=$RRD_PATH:FS:MIN" \
"DEF:TMAX=$RRD_PATH:FS:MAX" \
'HRULE:30#ff8080:Critical  ' \
'AREA:T#EA644A::STACK' \
'LINE1:T#CC3118:Filesystem  ' \
'AREA:TMIN#7648EC:fs max  ' \
'AREA:TMIN#ECD748:fs min\l' \
'GPRINT:T:LAST:Last Filesystem value\: %2.1lf Gb\l' \
'GPRINT:TMAX:MAX:Max Filesystem value\: %2.1lf Gb\l' \
'GPRINT:TMIN:MIN:Min Filesystem value\: %2.1lf Gb'

rrdtool graphv -J "$WEBPATH"PROC-"${FILENAME_ARRAY[$N]}".png -a PNG --title="Number of running processes ${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 800 --lower-limit 0 -r \
--vertical-label "Number of running procs" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:PROC:AVERAGE" \
"DEF:TMIN=$RRD_PATH:PROC:MIN" \
"DEF:TMAX=$RRD_PATH:PROC:MAX" \
'HRULE:400#ff8080:Critical  ' \
'AREA:T#C2A465::STACK' \
'LINE1:T#340000:Processes  ' \
'AREA:TMIN#7648EC:ps max  ' \
'AREA:TMIN#ECD748:ps min\l' \
'GPRINT:T:LAST:Last number of processes\: %2.1lf \l' \
'GPRINT:TMAX:MAX:Max number of processes\: %2.1lf \l' \
'GPRINT:TMIN:MIN:Min number of processes\: %2.1lf '

rrdtool graphv -J "$WEBPATH"NETSTAT-"${FILENAME_ARRAY[$N]}".png -a PNG --title="ESTABLISHED vs LISTEN connections ${TITLE_ARRAY[$N])}" \
-h 100 -w 500 \
--alt-y-grid \
--upper-limit 70 --lower-limit 0 -r \
--vertical-label "ESTABLISHED vs LISTEN" \
"${PARAMS_ARRAY[$N]}" \
"DEF:T=$RRD_PATH:ESTB:AVERAGE" \
"DEF:M=$RRD_PATH:LSN:AVERAGE" \
"DEF:TMIN=$RRD_PATH:ESTB:MIN" \
"DEF:TMAX=$RRD_PATH:ESTB:MAX" \
"DEF:MMIN=$RRD_PATH:LSN:MIN" \
"DEF:MMAX=$RRD_PATH:LSN:MAX" \
'HRULE:30#ff8080:Critical  ' \
'AREA:T#BB9756::STACK' \
'AREA:M#829E84::STACK' \
'LINE:T#462C0A:ESTABLISHED conn  ' \
'LINE:M#18251A:LISTENING ports  ' \
'AREA:TMAX#7648EC:established max  ' \
'AREA:TMIN#ECD748:established min  ' \
'AREA:MMAX#7648EC:listening max  ' \
'AREA:MMIN#ECD748:listening min\l' \
'GPRINT:T:LAST:Last Number of ESTB conn\: %2.1lf \l' \
'GPRINT:TMAX:MAX:Max number of ESTB conn\: %2.1lf \l' \
'GPRINT:TMIN:MIN:Min number of ESTB conn\: %2.1lf \l' \
'GPRINT:M:LAST:Last Number of LSN conn\: %2.1lf \l' \
'GPRINT:MMAX:MAX:Max number of LSN conn\: %2.1lf \l' \
'GPRINT:MMIN:MIN:Min number of LSN conn\: %2.1lf \l' 
done
