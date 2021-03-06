#!/bin/sh
#desc:Translates the given string

TEXT="$1"

if test -z "$TEXT"; then
	# No se especificó ningún texto. Salir
	exit 0
fi

# Nota: el sistema solamente permite 1 variable
if test `echo $TEXT | grep '\[' | wc -l` != 0; then
	# Hay una variable!
	VAR=`echo $TEXT | cut -f2 -d[ | cut -f1 -d]`
	PRETEXT=`echo $TEXT | cut -f1 -d[`
	POSTEXT=`echo $TEXT | cut -f2 -d]`
	TEXT=`echo $PRETEXT "%s" $POSTEXT`
	#echo "VAR: $VAR"
	#echo "TEXT: $TEXT"
fi


if test -f /etc/opendomo/lang; then
	LANG=`cat /etc/opendomo/i18n/lang`
	KEYFILE="/var/opendomo/i18n/key"
	LANGFILE="/var/opendomo/i18n/$LANG"
	ID=`grep ":$TEXT" $KEYFILE | head -n1 | cut -f1 -d:`
	if test -z "$ID"; then
		# No se encontró el texto en el KEYFILE
		echo $TEXT
		exit 2
	else
		TRANS=`grep "^$ID:" $LANGFILE | head -n1 | cut -f2- -d: | sed 's/%s/[]/'` 
		#echo "TRANS: $TRANS"
		if test -z "$TRANS"; then
			# No se encontró el ID en el LANGFILE
			echo $TEXT
			exit 3
		else
			# Si se encontró una variable, reemplazarla!
			if test -z "$VAR"; then
				echo $TRANS	
			else
				#FIXME Si la variable contiene cualquier texto a escapar, falla
				PRETRANS=`echo $TRANS | cut -f1 -d[`
				POSTRANS=`echo $TRANS | cut -f2 -d]`
				echo $PRETRANS $VAR $POSTRANS
			fi
			exit 0
		fi
	fi
else
	# No hay ningún idioma configurado (¡ERROR!)
	#TODO Disparar un evento de error: esta situación no debe ser posible
	echo $TEXT
	exit 1
fi
