#!/bin/sh

player_status=$(playerctl --player=vlc,spotify,%any status 2> /dev/null)

if [ "$player_status" = "Playing" ]; then
    echo "%{B#04171F}Playing: $(playerctl --player=vlc,spotify,%any metadata artist) - $(playerctl --player=vlc,spotify,%any metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo "%{B#04171F}Stopped: $(playerctl --player=vlc,spotify,%any metadata artist) - $(playerctl --player=vlc,spotify,%any metadata title)"
else
    echo "%{B#04171F}Playing: Silence"
fi
