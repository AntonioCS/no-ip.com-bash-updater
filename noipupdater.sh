#!/bin/bash

# No-IP uses emails as usernames, so make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOST=hostsite
LOGDIR=logdir             # best to use full absolute path
CONFIGDIR=configdir       # best to use full absolute path
LOGFILE=$LOGDIR/noip.log
STOREDIPFILE=$CONFIGDIR/current_ip
USERAGENT="Simple Bash No-IP Updater/0.4 antoniocs@gmail.com"

# create directories if not exist
mkdir -p $LOGDIR
mkdir -p $CONFIGDIR

# create file to hold current ip
if [ ! -e $STOREDIPFILE ]; then
	touch $STOREDIPFILE
fi

# get current public ip from remote server
NEWIP=$(wget -O - http://icanhazip.com/ -o /dev/null)

# verify if dnsutils (dig command) is available
if ! type "dig" > /dev/null; then
  # no dig, using fallback on file storage
  # on Debian/Ubuntu based systems, install package with: sudo apt install dnsutils
  STOREDIP=$(cat $STOREDIPFILE)
elif
  # use dig to get local dns record
  STOREDIP=$(dig $HOST | grep $HOST | tail -n 1 | cut -f 5)
fi

# compare if ip has changed from the last time (avoiding unnecessary updates on no-ip)
if [ "$NEWIP" != "$STOREDIP" ]; then
	RESULT=$(wget -O "$LOGFILE" -q --user-agent="$USERAGENT" --no-check-certificate "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST&myip=$NEWIP")

	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"
	echo $NEWIP > $STOREDIPFILE
else
	LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] No IP change"
fi

echo $LOGLINE >> $LOGFILE

exit 0
