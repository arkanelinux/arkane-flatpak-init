#!/usr/bin/env bash
#

# Do not yet do anything as long as the service has not yet started
while [[ ! -f /var/lib/arkane/flatpak-init.lock ]] && [[ ! -f /var/lib/arkane/flatpak-init.info ]]; do
	sleep 5

	if [[ -z $has_notified ]]; then
		# Notify user about internet requirement
		notify-send -a 'flatpak-init' -i /usr/share/pixmaps/arkanelinux-logo.png -u critical -w \
			'Installation of core Flatpak apps' \
			'Once a network connection has been established the installation of core applications will begin' &

		has_notified=1
	fi
done

# If info file exists we are running the service
if [[ -f '/var/lib/arkane/flatpak-init.info' ]]; then

	# Notify user about ongoing installation
	notify-send -a 'flatpak-init' -i /usr/share/pixmaps/arkanelinux-logo.png -u critical -w \
		'Installation of core Flatpak apps is ongoing' \
		'The installation of core applications is still ongoing, please allow some time for the process to complete' &

	# Wait untill install finished
	while [[ ! -f /var/lib/arkane/flatpak-init.lock ]]; do
		sleep 5
	done

	# Notify user install finished
	notify-send -a 'flatpak-init' -i /usr/share/pixmaps/arkanelinux-logo.png -u normal -w \
		'Installation of core Flatpak apps finished' \
		'The installation of core applications has just finished, all core applications have now been installed'


fi

exit 0
