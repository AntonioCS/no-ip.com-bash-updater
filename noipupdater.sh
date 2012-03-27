#!/bin/bash

# No-IP uses emails as passwords, so make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOST=hostsite
LOGFILE=logdir/noip.log
CIPFILE=dir/current_ip
USERAGENT="Simple Bash No-IP Updater/0.3 antoniocs@gmail.com"

if [ ! -e $CIPFILE ]
then 
	touch $CIPFILE
fi

IP=$(wget -O - -q http://www.whatismyip.org/)
CIP=$(cat $CIPFILE)

if [ "$IP" != "$CIP" ]
then
	RESULT=$(wget -O "$LOGFILE" -q --user-agent="$USERAGENT" --no-check-certificate "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$IP")

	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"
	echo $IP > $CIPFILE
else
	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] No IP change"
fi

echo $LOGLINE >> $LOGFILE

exit 0

