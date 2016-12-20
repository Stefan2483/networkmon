#!/bin/bash

# This will update the resources RRD

DATE=`/bin/date "+%Y.%m.%d %H.%M.%S"`
RRD_PATH="~/networkmonit/RRD/resources.rrd"

#Retreive the resources data

RRD_VALUE=`echo $(/opt/vc/bin/vcgencmd measure_temp | sed -e "s/temp=\(.*\)'C/\1/") $(echo :) $(cat <(grep 'cpu ' /proc/stat) <(sleep 1 && grep 'cpu ' /proc/stat) | awk -v RS="" '{print ($13-$2+$15-$4)*100/($13-$2+$15-$4+$16-$5) }') $(echo :) $(free -m | grep Mem | awk '{ print $3 }' | sed -e 's/ //g') $(echo :) $(df -h | grep "/dev/root" | awk '{ print $3 }' | sed -e 's/G//g' | sed -e 's/ //g') $(echo :) $(ps -ef | wc -l) $(echo :) $(netstat -natup | grep ESTABLISHED | wc -l) $(echo :) $(netstat -natup | grep LISTEN | wc -l) | sed -e 's/ //g'`

#Update rrd

echo -e "$DATE:$RRD_VALUE">>~/networkmonit/resources/LOG/resources-values.log
rrdtool update $RRD_PATH N:$RRD_VALUE

sleep 2

#Run the script to create graphs 
./graph_resource_rrd.sh
