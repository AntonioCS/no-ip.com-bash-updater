#!/bin/bash

USERNAME=username
PASSWORD=password
HOST=hostsite
LOGFILE=logdir/noip.log
STOREDIPFILE=configdir/current_ip
USERAGENT="Simple Bash No-IP Updater/0.4 antoniocs@gmail.com"

if [ ! -e $STOREDIPFILE ]; then
	touch $STOREDIPFILE
fi

NEWIP=$(wget -O- http://icanhazip.com/ -o /dev/null)
STOREDIP=$(cat $STOREDIPFILE)

if [ "$NEWIP" != "$STOREDIP" ]; then
	RESULT=$(wget -qO- --user-agent="$USERAGENT" --user="$USERNAME" --password="$PASSWORD" "https://dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP")

	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] IP changed to $NEWIP, result='$RESULT'"
	echo $NEWIP > $STOREDIPFILE
else
	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] No IP change"
fi

echo $LOGLINE >> $LOGFILE

exit 0
