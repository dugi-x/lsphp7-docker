#!/bin/bash

chmod 711 /home
for d in /home/*; do

    if [[ -d $d ]]; then

        _UID=$(stat -c "%u" $d)
        _GID=$(stat -c "%g" $d)
        _VHOST=$(basename $d)
        adduser $_VHOST -u $_UID -M -d $d -N
        getent group $_GID > /dev/null || groupadd $_VHOST -g $_GID
        usermod -g $_GID $_VHOST

        chmod 711 $d
        mkdir -p $d/public_html
        chown $_UID:$_GID -R $d/public_html
        find $d/public_html -type d -exec chmod 755 {} +
        find $d/public_html -type f -exec chmod 644 {} +

        mkdir -p $d/logs
        chown $_UID:nobody $d/logs
        chmod -R 750 $d/logs

        mkdir -p $d/cert
        chown $_UID:nobody $d/cert
        chmod -R 750 $d/cert

        #export $(grep -v '^#' "${d}.env" | xargs -0) 

        mkdir -p /usr/local/lsws/conf/vhosts/$_VHOST
        touch /usr/local/lsws/conf/vhosts/$_VHOST/vhost.conf
        chmod 600 /usr/local/lsws/conf/vhosts/$_VHOST/vhost.conf
        echo "
docRoot                   \$VH_ROOT/public_html
vhDomain                  \$VH_NAME
vhAliases                 www.\$VH_NAME
adminEmails               admin@$_VHOST
enableGzip                1
enableIpGeo               1

index  {
  useServer               0
  indexFiles              index.php, index.html
}

errorlog \$VH_ROOT/logs/\$VH_NAME.error_log {
  useServer               0
  logLevel                ERROR
  rollingSize             10M
}

accesslog \$VH_ROOT/logs/\$VH_NAME.access_log {
  useServer               0
  logFormat               \"%v %h %l %u %t \"%r\" %>s %b\"
  logHeaders              5
  rollingSize             10M
  keepDays                10  compressArchive         1
}

scripthandler  {
  add                     lsapi:$_VHOST php
}

extprocessor $_VHOST {
  type                    lsapi
  address                 UDS://tmp/lshttpd/$_VHOST.sock
  maxConns                10
  env                     LSAPI_CHILDREN=10
  initTimeout             600
  retryTimeout            0
  persistConn             1
  pcKeepAliveTimeout      1
  respBuffer              0
  autoStart               1
  path                    /usr/local/lsws/lsphp$LSPHP/bin/lsphp
  extUser                 $_VHOST
  extGroup                $_VHOST
  memSoftLimit            2047M
  memHardLimit            2047M
  procSoftLimit           400
  procHardLimit           500
}

phpIniOverride  {
	 php_admin_value open_basedir \"/tmp:\$DOC_ROOT\"
}

rewrite  {
  enable                  1
  autoLoadHtaccess        1
}

vhssl  {
  keyFile                 \$VH_ROOT/cert/privkey.pem
  certFile                \$VH_ROOT/cert/fullchain.pem
  certChain               1
  sslProtocol             30
}" >> /usr/local/lsws/conf/vhosts/$_VHOST/vhost.conf


        echo "
virtualHost $_VHOST {
    vhRoot                  /home/\$VH_NAME
    configFile              \$SERVER_ROOT/conf/vhosts/\$VH_NAME/vhost.conf
    allowSymbolLink          1
    enableScript             1
    restrained               1
}" >> /usr/local/lsws/conf/httpd_config.conf
        
        sed -i "s|.*map.*Example.*|  map                     $_VHOST $_VHOST,www.$_VHOST\n  map                     Example *|g" /usr/local/lsws/conf/httpd_config.conf
    fi

done
chown lsadm:lsadm -R /usr/local/lsws/conf
