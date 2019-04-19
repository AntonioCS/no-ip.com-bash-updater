#!/bin/bash

# No-IP uses emails as usernames, so make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOST=hostsite
LOGDIR=logdir             # best to use full absolute path (because of crontab integration)
CONFIGDIR=configdir       # best to use full absolute path (because of crontab integration)
LOGFILE=$LOGDIR/noip.log
USERAGENT="Simple Bash No-IP Updater/0.4 antoniocs@gmail.com"

# create directories if not exist
mkdir -p $LOGDIR
mkdir -p $CONFIGDIR

RESULT=$(wget -O "-" --user-agent="$USERAGENT" --no-check-certificate "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST")
LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"

echo $LOGLINE >> $LOGFILE

exit 0
