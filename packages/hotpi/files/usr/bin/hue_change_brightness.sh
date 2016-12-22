#!/bin/bash.real

# Demo for Hue BashLibrary (hue_bashlibrary.sh)
# Written 2013 by Markus Proske, released under GNU GENERAL PUBLIC LICENSE v2, see LICENSE 
# Google+: https://plus.google.com/+MarkusProske
# Github: https://github.com/markusproske/hue_bashlibrary
# -----------------------------------------------------------------------------------------


# Note: this library relies on curl to be installed on your system.
# Type which curl or curl --help in your Terminal to see if it is installed
# If not, install with sudo apt-get install curl 


# import my hue bash library
source hue_bashlibrary.sh
# import extra hue bash library
source hue_bashlibrary_extra.sh


# CONFIGURATION
# -----------------------------------------------------------------------------------------

# Mind the gap: do not change the names of these variables, the bash_library needs those...

ip='Philips-hue'								# IP of hue bridge
devicetype='raspberry'						# Link with bridge: type of device
username='huelibrary'						# Link with bridge: username / app name
loglevel=1									# 0 all logging off, # 1 gossip, # 2 verbose, # 3 errors


# Variables of this scripts
light='1'								# Define the lights you want to use, e.g. '3' or '3 4' or '3 4 7 9'


# PROGRAM FUNCTIONS
# -----------------------------------------------------------------------------------------

function usage {
	# cmdname is defined in the library
	echo "Usage: $cmdname [link | unlink | discover | config]"
	echo "Or:    $cmdname light delta"
	echo "light -   Light to change or \"s\" for currently selected light"
	echo "delta -   Amount to change light brightness by."
}



# MAIN
# -----------------------------------------------------------------------------------------

# store name of command for usage and log
# cmdname is defined in the library
cmdname=`basename "$0"`


# very simple argument processing
if [[ $# == 1 ]]
	then 
	# valid number of arguments
	if [[ $1 == "link" ]]
	then
		bridge_link
	elif [[ $1 == "unlink" ]]
	then
		bridge_unlink
	elif [[ $1 == "config" ]]
	then	
		bridge_config
	elif [[ $1 == "discover" ]]
	then
		bridge_discover
	else
		usage	
	fi
	
	echo		# force new line
	exit
else 
	if (( $# > 2 )) || (( $# < 1 ))
	then
		# more than one argument, show usage
		usage
		echo
		exit
	fi
fi 

# no arguments

light=$1
delta=$2

if [ $light == "s" ]; then
    if [ -f "/tmp/hue_selected_light.dat" ]; then
        light=`cat "/tmp/hue_selected_light.dat"`
    else
        light=1
    fi
fi

change_brightness $delta $light

