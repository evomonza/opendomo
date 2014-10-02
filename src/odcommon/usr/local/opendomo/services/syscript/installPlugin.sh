#!/bin/sh
#desc:Install plugin
#type:local
#package:odcommon

# Copyright(c) 2014 OpenDomo Services SL. Licensed under GPL v3 or later

REPOFILE="/var/opendomo/apt/repository.lst"
PLUGINSDIR="/var/opendomo/apt/plugins"
QUEUEFILE="/var/opendomo/apt/queue"

if test -z "$1"; then
    echo "#ERRO You must specify the plugin ID"
    exit 2
else
	cd $PLUGINSDIR
	for plugin in $@
	do
		# Sending deps to queue and download file
		DOWNURL=`grep $plugin $REPOFILE  | tail -n1 | cut -f2 -d";"`
		PLUGDEPS=`grep $plugin $REPOFILE | tail -n1 | cut -f4 -d";"`
		if ! test -z "$DOWNURL"
		then
			echo -n " $PLUGDEPS " >> $QUEUEFILE
			echo "#INFO Plugin [$plugin] sent to install"
			/usr/local/bin/download.sh $DOWNURL
		fi
	done

    
    /usr/local/opendomo/managePlugins.sh
fi
echo
