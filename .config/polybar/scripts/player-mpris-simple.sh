#!/bin/sh

player_status=$(playerctl --player=vlc,spotify,%any status 2> /dev/null)

truncate_string() {
    local str="$1"
    local max_length=$2

    [ ${#str} -gt $max_length ] && echo "$(echo "$str" | cut -c 1-$max_length)..." || echo "$str"
}

print_info() {
    local status=$1
    local title=$(truncate_string "$(playerctl --player=vlc,spotify,%any metadata title)" 20)
    local artist=$(truncate_string "$(playerctl --player=vlc,spotify,%any metadata artist)" 20)

    echo "%{F#c3e88d}$status: $title - $artist"
}

case "$player_status" in
    "Playing") print_info "Playing" ;;
    "Paused") print_info "Paused" ;;
    *) echo "%{F#c3e88d}Playing: Silence" ;;
esac
