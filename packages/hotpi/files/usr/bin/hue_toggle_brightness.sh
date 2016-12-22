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
levels=("50 100 150 254")

# PROGRAM FUNCTIONS
# -----------------------------------------------------------------------------------------

function usage {
	# cmdname is defined in the library
	echo "Usage: $cmdname [link | unlink | discover | config]"
	echo "Or:    $cmdname light levels"
	echo "light -   Light to change or \"s\" for currently selected light"
	echo "levels -   Amounts to change light brightness to."
	echo "           e.g. \"0 35 70 140 254\"  where 0 = off and 254 = max"
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
levels=("$2")
BRIGHTNESS=0
TIMEDELAY=5         # Timeout between uses

if [ $light == "s" ]; then
    if [ -f "/tmp/hue_selected_light.dat" ]; then
        light=`cat "/tmp/hue_selected_light.dat"`
    else
        light=1
    fi
fi

if [ -f "/tmp/hue_toggle_brightness_$light.dat" ]; then
    # Get the first number
    time=`cat "/tmp/hue_toggle_brightness_$light.dat" | { read first second ; echo $first ; }`
else
    time=`date +%s`
    time=$[time + TIMEDELAY + 1] # force timeout
fi

# Save new timeout
NOWTIME=`date +%s`
TIMEOUT=$[NOWTIME + TIMEDELAY]
echo "$TIMEOUT" > "/tmp/hue_toggle_brightness_$light.dat"

echo "Time: '$time'"

# if timout expired since last use switch it on or off.
if [ "$time" -lt $NOWTIME ]; then
    hue_is_on $light

    # If the light is off use lowest brightness
    if [ "$result_hue_is_on" == 0 ]; then
        get_brightness $light
        MINBRIGHTNESS=`echo "$levels" | { read first second ; echo $first ; }`

        BRIGHTNESS=$[result_hue_get_brightness]
        if [ "$BRIGHTNESS" -lt "$MINBRIGHTNESS" ]; then 
            set_brightness $MINBRIGHTNESS $light
        else
            hue_onoff "on" $light
        fi
    else
        hue_onoff "off" $light
    fi
else
    hue_is_on $light

    # If the light is off use lowest brightness
    if [ "$result_hue_is_on" == 0 ]; then
        get_brightness $light
        MINBRIGHTNESS=`echo "$levels" | { read first second ; echo $first ; }`
        set_brightness $MINBRIGHTNESS $light
    else
        get_brightness $light

        BRIGHTNESS=$[result_hue_get_brightness]

        # Get the new brightness level        
        NEWBRIGHTNESS=0

        for i in $levels 
        do
            if [ "$BRIGHTNESS" -lt $i ]; then 
                NEWBRIGHTNESS=$i
                break
            fi
        done

        set_brightness $NEWBRIGHTNESS $light
    fi
fi

exit 0

