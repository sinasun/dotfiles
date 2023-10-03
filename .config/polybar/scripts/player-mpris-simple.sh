#!/bin/sh

player_status=$(playerctl status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "%{B#04171F}Playing: $(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo "%{B#04171F}Stopped: $(playerctl metadata artist) - $(playerctl metadata title)"
else
    echo "%{B#04171F}Playing: Silence"
fi
