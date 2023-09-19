#!/bin/bash

function run {
  if ! pgrep $1 ;
  then
    $@&
  fi
}

#Find out your monitor name with xrandr or arandr (save and you get this line)
#xrandr --output VGA-1 --primary --mode 1360x768 --pos 0x0 --rotate normal
#xrandr --output DP2 --primary --mode 1920x1080 --rate 60.00 --output LVDS1 --off &
#xrandr --output LVDS1 --mode 1366x768 --output DP3 --mode 1920x1080 --right-of LVDS1
#xrandr --output HDMI2 --mode 1920x1080 --pos 1920x0 --rotate normal --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off
#autorandr horizontal

#change your keyboard if you need it
setxkbmap -layout us

# Define a keybinding to toggle between English and Persian layouts
bspc config key_bindings.desktop \
    {alt,Super + space} \
    {bsp-layout:toggle}

# Define a rule for applications to set Persian layout
bspc rule -a '.*' state=borderless border=off

# Set the Persian layout as an option
setxkbmap -option "grp:alt_shift_toggle" -layout "us,ir"


#Some ways to set your wallpaper besides variety or nitrogen
feh --no-fehbg --bg-scale $HOME/.config/bspwm/wall.jpg &
#wallpaper for other Arch based systems
#feh --bg-fill /usr/share/archlinux-tweak-tool/data/wallpaper/wallpaper.png &
#feh --randomize --bg-fill ~/Dropbox/Apps/Desktoppr/*

#conky -c $HOME/.config/bspwm/system-overview &
#run variety &
#run nm-applet &
#run pamac-tray &

numlockx on &
ulauncher &
#blueberry-tray &
killall -q picom
	# Wait until closing picom #
	while pgrep -u $UID -x picom >/dev/null;
		
		do
			
			sleep 1

	done

picom --config $HOME/.config/picom/picom.conf &
#run volumeicon &
#nitrogen --restore &
#run caffeine &
#run vivaldi-stable &
#run firefox &
#run thunar &
#run dropbox &
#run insync start &
#run discord &
#run spotify &
#run atom &

# Change touchpad scroll direction
xinput --set-prop 13 'libinput Natural Scrolling Enabled' 1
