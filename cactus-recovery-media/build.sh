#!/bin/bash

rootdir="src/rootfs"
loopfile="src/rootfs.loop"
output="rootfs.squashfs"

log() {
    echo "[CACTUS]" $1
}

# Cactus Root Filesystem Package Generator
clearOldRoot() {
    if [ -d $rootdir ]; then
        log "Clearing old root directory";
        rm -rf $rootdir
    fi
    
    if [ -f $loopfile ]; then
        log "Removing old loop filesystem";
        rm -f $loopfile
    fi
    
    if [ -f $output ]; then
        log "Removing old root filesystem SquashFS";
        rm -f $output
    fi
}

createRoot() {
    log "Creating root filesystem";
    fallocate -l 4G $loopfile
    mkfs.ext4 $loopfile
    
    log "Mounting root filesystem"
    mkdir -p $rootdir
    mount $loopfile $rootdir
}

installPackages() {
    log "Installing requested packages to root directory"
    
    if pacstrap -C pacman.conf -c $rootdir $(<pkglist); then
        log "Installed packages"
    else
        log "Couldn't install packages!"
        finalise;
        exit;
    fi
    
    #Copy pacman.conf over to the new root
    cp pacman.conf $rootdir/etc/pacman.conf
}

customise() {
    log "Running customisation script"
    cp ./customise.sh $rootdir/customise.sh
    arch-chroot $rootdir /customise.sh
    rm $rootdir/customise.sh
}

squash() {
    log "Squashing final root filesystem"
    mksquashfs $rootdir $output
}

finalise() {
    log "Unmounting root file system"
    umount $rootdir
}

# Ensure that we are running as root
if [ "$EUID" -ne 0 ]; then
    log "This script must be run as root"
    exit
fi

clearOldRoot;
createRoot;
installPackages;
customise;
squash;
finalise;

log "SquashFS generation complete. Now you can use makepkg to build the recovery image package."