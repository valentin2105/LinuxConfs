#!/bin/bash

## Variables
HIPCHAT_SCRIPT=/srv/hipchat_room_message
API_KEY="APIKEY"
CHANNEL="#CHANNEL"
FROM="M/Monit"
COLOR="purple"

MONIT_HOST=$1
MONIT_SERVICE=$2
MONIT_DESCRIPTION=$3


## Vérifs pour erreurs :
declare -a error=("failed" "matches resource limit" "is not running" "unmonitor" "stopped" "unavaible")

for i in "${error[@]}"
do
try1=`echo $MONIT_DESCRIPTION |grep "$i" `
try1c=`echo $?`
if [ "$try1c" == "0" ]
 then COLOR="red"
fi 
done


## Vérifs pour success :
declare -a success=("succeeded" "monitor action done" "is running" "started")

for i in "${success[@]}"
do
try2=`echo $MONIT_DESCRIPTION |grep "$i" `
try2c=`echo $?`
if [ "$try2c" == "0" ]
 then COLOR="green"
fi 
done


## Vérifs pour informations :
declare -a info=("changed")

for i in "${info[@]}"
do
try3=`echo $MONIT_DESCRIPTION |grep "$i" `
try3c=`echo $?`
if [ "$try3c" == "0" ]
 then COLOR="yellow"
fi 
done



echo $MONIT_HOST $MONIT_SERVICE $MONIT_DESCRIPTION | \
	$HIPCHAT_SCRIPT  -t $API_KEY -r $CHANNEL -f $FROM -c $COLOR

