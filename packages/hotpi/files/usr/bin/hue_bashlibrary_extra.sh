#!/bin/bash.real

# import my hue bash library
source hue_bashlibrary.sh

function set_brightness() {
    LEVEL=$1
    if [[ $LEVEL -gt 254 ]]; then
        LEVEL=254
    fi
    
    if [[ $LEVEL -lt 0 ]]; then
        LEVEL=0
    fi

    hue_is_on $2

    # Turn on light if brightness > 0
    if [ $LEVEL -gt 0 ]; then
        if [ "$result_hue_is_on" == 0 ]; then
            hue_onoff "on" $2
        fi
    fi

    hue_setstate_brightness $LEVEL $2

    # Turn off light if brightness = 0
    if [ $LEVEL -eq 0 ]; then
        if [ "$result_hue_is_on" == 1 ]; then
            hue_onoff "off" $2
        fi
    fi

    # Save brightness level to a file    
    echo "$LEVEL" > "/tmp/hue_light$2-brightness.dat"
}

# Gets the current light brightness from a file if it exists
function get_brightness() {
    if [ -f "/tmp/hue_light$1-brightness.dat" ]; then
        result_hue_get_brightness=`cat "/tmp/hue_light$1-brightness.dat"` 
    else
        hue_get_brightness $1
        
      	if [ "$result_hue_get_brightness" == '' ]; then
      	    echo "-------------------------------------"
      	    echo "ERROR getting brightness for light $1"
      	    echo "-------------------------------------"
      	    exit 1
      	fi
    fi
}

function change_brightness() {
    LEVEL=-1

    get_brightness $2

    # Calculate the new brightness level
    NEWLEVEL=$[LEVEL + $1]

    set_brightness $NEWLEVEL $2
}

function toggle_state() {
    STATE=-1

    hue_is_on $1

    # Toggle state
    if [ "$result_hue_is_on" == 1 ]; then
        STATE=0
    else
        STATE=1
    fi

    if [ $STATE == 0 ]; then
        hue_onoff "off" $1
    else
        hue_onoff "on" $1
    fi

    hue_is_on $1
}
