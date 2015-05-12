#! /bin/bash

# Différenciation entre Shuttle Conf-Modem Local et Global


mainip=`ip addr |grep "inet 192.168.42" |awk '{print $2}'`

until test -n "$mainip"
do 
    sleep 15
    mainip=`ip addr |grep "inet 192.168.42" |awk '{print $2}'`
done



mainip=`ip addr |grep "inet 192.168.42" |awk '{print $2}'`
iface=`ip addr |grep "inet 192.168.42" |awk '{print $7}'`
iface1=`ip link |grep -v "^ " |cut -d ':' -f2 |sed 's/ //g' |egrep -v "lo|wlan" |head -n1`
iface2=`ip link |grep -v "^ " |cut -d ':' -f2 |sed 's/ //g' |egrep -v "lo|wlan" |head -n2 |tail -n1`

#On vérifie qu'il existe un "flag" dans /srv/confmodem-FLAG

#verif_confmo=`cat /srv/confmodem-FLAG`
if [ -f /srv/confmodem-FLAG ]
        then
        iface=$iface2
        ifconfig p3p1 up
        for i in 0 1 2 10 16 100; do  # On veut des IP en 192.168.0/1/2/16/100.X 
        ip=`echo $mainip |sed "s/192\.168\.42\./192.168.$i\./g"`
        ip addr add $ip dev $iface # On attribue les IP
        done
        ip2=`echo $mainip |sed "s/192\.168\.42\./10.0.0\./g"`
        ip3=`echo $mainip |sed "s/192\.168\.42\./10.1.1\./g"`
        ip addr add $ip2 dev $iface
        ip addr add $ip3 dev $iface

else            # Si les Shuttles ne sont pas concernés par Conf-Modem, on leurs donne accès à Conf-Modem Global.

for i in 0 1 2 10 16 100; do
ip=`echo $mainip |sed "s/192\.168\.42\./192.168.$i\./g"`
ip addr add $ip dev $iface
done
ip2=`echo $mainip |sed "s/192\.168\.42\./10.0.0\./g"`
ip3=`echo $mainip |sed "s/192\.168\.42\./10.1.1\./g"`
ip addr add $ip2 dev $iface
ip addr add $ip3 dev $iface
fi

