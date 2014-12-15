#! /bin/sh
### BEGIN INIT INFO
# Provides:          states
# Required-Start:    $all
# Required-Stop:
# Should-Start:
# Default-Start:     1 2 3 4 5
# Default-Stop:
# Short-Description: Change default opendomo state
# Description:       Load default state in boot process
#
### END INIT INFO
### Copyright(c) 2011 OpenDomo Services SL. Licensed under GPL v3 or later


. /lib/init/vars.sh
. /lib/lsb/init-functions

do_start () {
    STATEDIR="/etc/opendomo/states/active"
    SYSSTATUS="/var/www/data/status.json"
    echo "{\"status\":\"rebooting\"}" > $SYSSTATUS && chown admin:admin $SYSSTATUS

    # Start services in default state and create pid
    cd $STATEDIR
    for daemon in *; do
        odservice $daemon start
    done
}

case "$1" in
    start|"")
        do_start
        ;;
    restart|reload|force-reload)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
    status)
        echo "Error: argument '$1' not supported" >&2
        exit 3
        ;;
    stop)
        # No-op
        ;;
    *)
        echo "Usage: odchstates.sh [start]" >&2
        exit 3
        ;;
esac

:
