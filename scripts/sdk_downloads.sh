#!/bin/sh

# Variables
SCRIPTSDIR="scripts"
. $SCRIPTSDIR/sdk_variables.sh

# Creating emply folders, git don't work with emply folders
mkdir -p $TMPDIR
mkdir -p $MOUNTDIR
mkdir -p $IMAGEDIR
mkdir -p $EXPORTDIR

mkdir -p $SRCDIR/odcommon/usr/lib
mkdir -p $SRCDIR/odhal/bin
mkdir -p $SRCDIR/odhal/usr/bin
mkdir -p $SRCDIR/odhal/var/opendomo

# Download initrd
if ! test -f $INITRDIMG; then
	cd $TMPDIR
	wget $INITRDURL
fi
