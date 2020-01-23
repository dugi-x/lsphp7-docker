#!/bin/bash

_LSPHP=${LSPHP:-73}
if [ -f "/usr/local/lsws/lsphp${_LSPHP}/bin/lsphp" ]; then
    ln -sf /usr/local/lsws/lsphp${_LSPHP}/bin/lsphp /usr/local/lsws/fcgi-bin/lsphp
    echo "lsphp  version set to: ${_LSPHP}"
fi
if [ -f "/usr/local/lsws/lsphp${_LSPHP}/bin/php" ]; then
    ln -sf /usr/local/lsws/lsphp${_LSPHP}/bin/php /usr/bin/php
    echo "cliphp version set to: ${_LSPHP}"
fi

exec "$@"