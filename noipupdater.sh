#!/bin/bash

# No-IP uses emails as passwords, so make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOST=hostsite
DIR=dir
CIPFILE=$DIR/current_ip
USERAGENT="Simple bash noip updater/0.2 antoniocs@gmail.com"

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

