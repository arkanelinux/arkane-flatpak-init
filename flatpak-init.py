#!/usr/bin/env python3
import gi, os

gi.require_version('Flatpak', '1.0')
from gi.repository import Flatpak

# As recommended by Flatpak maintainers, it is best to not bash script Flatpak
# thus we are using the Flatpak API

# Write file to trigger autostart script which informs user about ongoing installation
open("/var/lib/arkane/flatpak-init.info", "w")

installation = Flatpak.Installation.new_system()
transaction = Flatpak.Transaction.new_for_installation(installation, None)
remote = "flathub"

with open('/etc/arkane/flatpak-init/flatpak.list') as flatpak_list:
    for i, ref in enumerate(flatpak_list):
        print("Adding " + ref)
        transaction.add_install(remote, ref.strip(), None)

transaction.run(None)

# Write file to inform systemd service it does not have to run again on next boot
open("/var/lib/arkane/flatpak-init.lock", "w")

# Remove info file to prevent autostart script from triggering again
os.remove("/var/lib/arkane/flatpak-init.info")
