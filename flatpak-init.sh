#!/usr/bin/env bash

if [[ -f "/var/lib/arkane/flatpak-init.info" ]];
then
	notify-send -a "flatpak-init" -i /usr/share/pixmaps/arkane-logo.png -u critical -w \
		"Installation of core flatpak applications is ongoing" \
		"The installation of core applications is still ongoing, please allow some time for the process to complete" &

	while [[ ! -f /var/lib/arkane/flatpak-init.lock ]]
	do 
		sleep 2
	done

	notify-send -a "flatpak-init" -i /usr/share/pixmaps/arkanelinux-logo.png -u normal -w \
		"Installation of core flatpak applications has finished" \
		"The installation of core applications has just finished, all core applications have now been installed"	

	exit 0
else
	echo "/var/lib/arkane/flatpak-init.info does not exist, assuming no ongoing installation"
	
	exit 0
fi
