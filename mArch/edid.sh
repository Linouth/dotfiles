#!/bin/bash

if [ ! -e "/usr/lib/firmware/edid/ProLite.bin" ]; then
    sudo mkdir /usr/lib/firmware/edid
    sudo cp ~/.dotfiles/mArch/ProLite.bin /usr/lib/firmware/edid/
    echo "EDID firmware file has been installed."
    echo "Remember to set KMS for EDID. Systemd-boot format:\n---------"
    cat ~/.dotfiles/mArch/boot/arch.conf
fi
