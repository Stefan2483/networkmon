#!/bin/bash

#This will run speedtest-cli and will print the values for PING UPLOAD and DOWNLOAD

cd ~/networkmonit/speedtest
DATE=`/bin/date "+%Y.%m.%d-%H%M%S"`
RRD_PATH="~/networkmonit/RRD/speedtest.rrd"


#Run the speedtest-cli
        OUT=`/usr/local/bin/speedtest-cli --share`
        echo "$OUT" > LOG/last_test 

#Get the values from last_test log
        PING=`cat LOG/last_test | grep -i "^Hosted by"|awk '{print $(NF-1)}'`
        UPLOAD=`cat LOG/last_test | grep -i "^Download"|awk '{print $(NF-1)}'`
        DOWNLOAD=`cat LOG/last_test | grep -i "^Upload"|awk '{print $(NF-1)}'`
        LINK=`cat LOG/last_test | grep -i "^Share results"|awk '{print $(NF)}'`

#Saves the result LINK in the website path
        echo $LINK > /var/www/networkmonit/speedtest/result

#Update rrd
	RRD_VALUE=`echo "$PING : $UPLOAD : $DOWNLOAD" | sed -e 's/ //g'`
	echo -e "$DATE - $RRD_VALUE" >> ~/networkmonit/speedtest/LOG/speedtest-values.log
	rrdtool update $RRD_PATH N:$RRD_VALUE
