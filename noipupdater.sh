#!/bin/bash

# No-IP uses emails as usernames, so make sure that you encode the @ as %40
USERNAME=username
PASSWORD=password
HOST=hostsite
LOGDIR=logdir             # best to use full absolute path (because of crontab integration)
CONFIGDIR=configdir       # best to use full absolute path (because of crontab integration)
LOGFILE=$LOGDIR/noip.log
USERAGENT="Simple Bash No-IP Updater/0.4 antoniocs@gmail.com"

function cmd_exists() {
    command -v "$1" > /dev/null 2>&1
}

function http_get() {
    if cmd_exists curl; then
        curl -s --user-agent "$USERAGENT" "$1"
    elif cmd_exists wget; then
        wget -q -O - --user-agent="$USERAGENT" "$1"
    else
        echo -n "No http tool found. Install curl or wget." >&2
        exit 1
    fi
}

# create directories if not exist
mkdir -p $LOGDIR
mkdir -p $CONFIGDIR

RESULT=$(http_get "https://$USERNAME:$PASSWORD@dynupdate.no-ip.com/nic/update?hostname=$HOST")
LOGLINE="[$(date +"%Y-%m-%d %H:%M:%S")] $RESULT"

echo $LOGLINE >> $LOGFILE

exit 0
