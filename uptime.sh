#/bin/bash
#########################################################################################
# Created by: JoshinGeneral                                                             #
# Date: 10/03/2013                                                                      #
# Version: 1.0                                                                          #
# Description:                                                                          #
# This script is in the theme of the matrix, change at will.                            #
# Description this script is meant to be run on a cloud VPS to                          #
# help you know if your home server/internet is up or down,                             #
# it will email you if it goes down.                                                    #
#                                                                                       #
# 1. Just make sure ping on your router is able to respond to WAN requests.             #
# 2. Run: sudo apt-get install mailutils                                                #
# 3. Change email                                                                       #
# 4. Run ./install.sh for instructions on how to put into cron                          #
#########################################################################################

#Varibles
host=$1
running=`ps -ef | grep uptime.sh | grep -v grep | wc -l`
status=`fping $host | grep -o unreachable`
email="YOUREMAILGOESHERE@MAILSERVER.COM"

#Check if we already have a script waiting for server to come back online
if [[ $running -gt 2 ]];
then
 echo "$running";
 echo "";
 echo "We are already working on this, gonna exit now with grace";
 exit 0
fi

#Check if the server is up
if [[ $status == "unreachable" ]];
then
 echo "Apoc we have a problem.";
 echo "Apoc we have a problem" | mail -s "Server Alert: Down" $email

 #We have established it is down, so now we need to check to see when it comes back up
 #(current check is sleep X seconds)
 i=0
 while [ $i -lt 1 ];
        do
        status=`fping $host | grep -o unreachable`
        if [[ $status != "unreachable" ]]; then
                 echo "Apoc, scratch that we are back.";
                 echo "Apoc we are back in the world of real." | mail -s "Server Alert: Up" $email
        let i=1
        fi
        #Change this to change the time the loop iterates it's check
        sleep 10;
  done
fi
