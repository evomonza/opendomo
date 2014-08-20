#!/bin/sh
#desc:First configuration wizard
#package:odcgi
#type:local

GEOLOCFILE="/etc/opendomo/geo.conf"
TMPCFGFILE="/var/opendomo/tmp/wizFirstConfiguration.cfg"
. $TMPCFGFILE
URLVAL="http://cloud.opendomo.com/activate/index.php"
UIDFILE="/etc/opendomo/uid"

# Checking password
if test "$newpassword" != "$retype"
then
	echo "#ERR Passwords do not match"
	/usr/local/opendomo/wizFirstConfigurationStep3.sh
	exit 0
fi

# Generate UID only in the last step
MACADDRESS=`/sbin/ifconfig eth0 | grep HWaddr | cut -c 39-55 | sed -e 's/://g'` 
echo "$email `date` $MACADDRESS" | sha256sum | cut -f1 -d' ' > $UIDFILE 
uid=`cat  $UIDFILE `

# Save geolocation and configure timezone
echo "latitude='$latitude'"	    > $GEOLOCFILE
echo "longitude='$longitude'"	>> $GEOLOCFILE
echo "timezone='$timezone'"     >> $GEOLOCFILE
echo "timezoneid='$timezoneid'" | sed 's/+/ /g' >> $GEOLOCFILE
echo "city='$city'"             | sed 's/+/ /g' >> $GEOLOCFILE
echo "address='$address'"       | sed 's/+/ /g' >> $GEOLOCFILE

# Setting timezone
echo "$timezone" > /etc/timezone
LC_ALL=C LANGUAGE=C LANG=C DEBIAN_FRONTEND=noninteractive sudo dpkg-reconfigure tzdata &>/dev/null

# Saving new user data
sudo manageusers.sh mod admin "$fullname" "$email" "$newpassword" >/dev/null 2>/dev/null

# Activate
FULLURL="$URLVAL?UID=$uid&VER=$ver&MAIL=$mail"
wget -q -O /var/opendomo/tmp/activation.tmp $FULLURL 2>/dev/null

# Save system and reboot
#saveConfigReboot.sh

echo "#>System configured"
echo "list:`basename $0`"
echo "#INFO System successfully configured, ready to install plugins"
echo "actions:"
echo "	managePlugins.sh	Continue"
echo
