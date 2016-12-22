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


# CONFIGURATION
# -----------------------------------------------------------------------------------------

# Mind the gap: do not change the names of these variables, the bash_library needs those...

ip='Philips-hue'								# IP of hue bridge
devicetype='raspberry'						# Link with bridge: type of device
username='huelibrary'						# Link with bridge: username / app name
loglevel=1									# 0 all logging off, # 1 gossip, # 2 verbose, # 3 errors


# Variables of this scripts
light='1'								    # Define the master light to get current state from
lights='1'  								# Define the lights you want to use, e.g. '3' or '3 4' or '3 4 7 9'


# PROGRAM FUNCTIONS
# -----------------------------------------------------------------------------------------

function usage {
	# cmdname is defined in the library
	echo "Usage: $cmdname lights"
	echo "lights    -   Lights to change, master light first e.g \"1 2 3\""
	echo "Note: The master light is used to get light on/off state."
	echo "      When in the the third state only the master light is on."
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
	    echo		# force new line
	    exit
	elif [[ $1 == "unlink" ]]
	then
		bridge_unlink
	    echo		# force new line
	    exit
	elif [[ $1 == "config" ]]
	then	
		bridge_config
	    echo		# force new line
	    exit
	elif [[ $1 == "discover" ]]
	then
		bridge_discover
	elif  [[ $1 == "-h" || $1 == "--help" ]]
	then
		usage	
	    echo		# force new line
	    exit
	fi
else 
	if (( $# < 1 ))
	then
		# more than one argument, show usage
		usage
		echo
		exit
	fi
fi 

# Toggles the state of the first light
function toggle_state() {
    hue_is_on $1

    if [ "$result_hue_is_on" == 0 ]; then
        hue_onoff "on" $1
    else
        hue_onoff "off" $1
    fi
}

# Toggles the step to 0 if the master light is off or 1 if it is on
function toggle_step() {
    hue_is_on $1

    if [ "$result_hue_is_on" == 0 ]; then
        step=1
    else
        step=0
    fi
}

TIMEDELAY=5         # Timeout between uses

lights=$1

if [ -f "/tmp/hue_toggle_state.dat" ]; then
    # Get the first number
    time=`cat "/tmp/hue_toggle_state.dat" | { read first second ; echo $first ; }`
    # Get the second number
    step=`cat "/tmp/hue_toggle_state.dat" | { read first second ; echo $second ; }`
else
    time=`date +%s`
    time=$[time + TIMEDELAY + 1] # force timeout
    step=0
fi

echo "Time: '$time'"
echo "Read Step: '$step'"

# Reset step if timout expired since last use
NOWTIME=`date +%s`
if [ "$time" -lt $NOWTIME ]; then
    step=0
else
    # Update to next step
    step=$[step + 1]
    if [ $step -gt 2 ]; then
        step=0
    fi
fi

# For step 0 check if the first light is on or off and set the step value accordingly
if [ $step -eq 0 ]; then
    toggle_step $lights
fi

echo "Timeout: $time"
echo "Nowtime: $NOWTIME"
echo "Step: $step"


case $step in
[0]*)
    # 0: Turn off all the lights
    if [ "$step" -eq 0 ]; then
        hue_onoff "off" $lights
    fi
    ;;
[1]*)
    # 1: Turn on all the lights
    if [ $step -eq 1 ]; then
        hue_onoff "on" $lights
    fi
    ;;
*)
    # 2: Turn off all lights except the first
    if [ $step -eq 2 ]; then
        hue_onoff "off" $lights
        toggle_state $lights
    fi
    ;;
esac

# Save current step and new timeout
NOWTIME=`date +%s`
TIMEOUT=$[NOWTIME + TIMEDELAY]
echo "$TIMEOUT $step" > /tmp/hue_toggle_state.dat



