#!/bin/bash

_LSPHP=${LSPHP:-73}
if [ -f "/usr/local/lsws/lsphp${_LSPHP}/bin/lsphp" ]; then
    ln -sf /usr/local/lsws/lsphp${_LSPHP}/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp
    echo "lsphp   switch to version: ${_LSPHP}"
fi
if [ -f "/usr/local/lsws/lsphp${_LSPHP}/bin/php" ]; then
    ln -sf /usr/local/lsws/lsphp${_LSPHP}/bin/php /usr/bin/php
    echo "php-cli switch to version: ${_LSPHP}"
fi

echo "$LSADMIN_USERNAME:$(php /usr/local/lsws/admin/misc/htpasswd.php $LSADMIN_PASSWORD)" > /usr/local/lsws/admin/conf/htpasswd
unset LSADMIN_USERNAME LSADMIN_PASSWORD

if [ "$AUTOCONFIG" -eq 1 ]; then
    source /autoconfig.sh
fi 

"$@"

trap "exit" INT
while true; do

    status=$(/usr/local/lsws/bin/lswsctrl status)
    if [ "$status" != "$(cat lswsctrl.status 2>/dev/null)" ]; then
            echo $status | tee lswsctrl.status
    fi

    if ! grep 'litespeed is running with PID *' <<< $status > /dev/null ; then
        break
    fi

    sleep 60
done


