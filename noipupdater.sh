#!/bin/bash

USERNAME=username
PASSWORD=password
HOST=hostsite
DIR=$(pwd)
CIPFILE=$DIR/current_ip.noip_updater
USERAGENT="Simple bash noip updater/0.1 antoniocs@gmail.com"

if [ ! -e $CIPFILE ]
then 
	touch $CIPFILE
fi

IP=$(wget -O - -q http://www.whatismyip.org/)
CIP=$(cat $CIPFILE)

if [ "$IP" != "$CIP" ]
then			
	LOGFILE=$DIR/$(date +"%Y%m%d")_noip_updater.log		
	wget -O "$LOGFILE" -q --user-agent="$USERAGENT" https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP	
fi