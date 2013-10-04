#!/bin/bash
#########################################################################################
# Created by: JoshinGeneral                                                             #
# Date: 10/03/2013                                                                      #
# Version: 1.0                                                                          #
# Description:                                                                          #
# This is a simple script that helps you install the uptimeChecker into cron. The last  #
# part needs to be done by the user. Short answer: Humans are fat and need to exercise  #
# some.                                                                                 #
#########################################################################################
path=(`pwd`)

#Reminder about preqs and get how how many minutes to wait before running the check
echo "Preq: sudo apt-get install mailutils"
echo "Please enter the frequency in minutes you want the script to run:"
read min

#Simply get the host that you want to check
#Note: run the script again to check multiple hosts
echo "Please enter the IP/host you want to monitor"
read host

#Sometime we all need space
echo ""
echo ""

#Build what needs to be put into cron
echo "Output:"
echo "*/$min * * * *  /bin/bash $path/uptime.sh $host"
echo ""

#Tell the user what to do and where to put all the things
echo  "Copy the the previous line, when you hit enter we will ask for sudo and open crontab."
echo "Simply select the editor you wish to use and paste the \"Output:\" line at the bottom."

#Pause so they can read it
read -p "$*"

#Open crontab for entry
crontab -e
