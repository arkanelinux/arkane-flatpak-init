#!/usr/bin/env bash

if [[ -f "/var/lib/arkane/flatpak-installation" ]];
then
	notify-send -a "flatpak-init" -u normal -w \
		"Installation of core flatpak applications is ongoing" \
		"The installation of core applications is still ongoing, please allow some time for the process to complete"	
else
	echo "/var/lib/arkane/flatpak-installing does not exist, assuming no ongoing installation"
fi

exit 0
