#!/bin/bash

#Marcus Dean Adams (marcusdean.adams@protonmail.com)

#Helps unban people who have run afoul of Fail2Ban

if [ "$EUID" -ne 0 ]
	then echo ""
	echo "Please run as root."
	echo ""
	exit
fi

echo "Which jail?"
echo ""
echo "1) SSH"
echo "2) Nextcloud"
echo "3) Apache"
echo ""
echo "Enter 1, 2 or 3:"
read var

if [ "$var" = 1 ]
	then jail=$"sshd"
fi

if [ "$var" = 2 ]
	then jail=$"nextcloud"
fi

if [ "$var" = 3 ]
	then jail=$"apache-auth"
fi

if [ "$var" != 1 ] && [ "$var" != 2 ] && [ "$var" != 3 ]
	then echo ""
	echo "No valid input detected, exiting..."
	sleep 2
	echo ""
	exit
fi

fail2ban-client status $jail

echo ""
echo "Would you like to un-ban somebody from this jail?"
echo "Y or N"
read uban
if [ "$uban" = "y" ] || [ "$uban" = "Y" ]
	then echo ""
	echo "Enter the IP you wish to un-ban:"
	read ip
	echo ""
	fail2ban-client set $jail unbanip $ip
	sleep 2
	echo ""
	echo "Re-printing jail status..."
	echo ""
	sleep 1
	fail2ban-client status $jail
fi

echo ""
echo "Exiting..."
sleep 1
echo ""
exit
