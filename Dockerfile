FROM dugi/openlitespeed:1.6.5

RUN yum -y install mysql

RUN yum -y install lsphp70 \
                   lsphp70-json \
                   lsphp70-xmlrpc \
                   lsphp70-xml \
                   lsphp70-tidy \
                   lsphp70-soap \
                   lsphp70-snmp \
                   lsphp70-recode \
                   lsphp70-pspell \
                   lsphp70-process \
                   lsphp70-pgsql \
                   lsphp70-pear \
                   lsphp70-pdo \
                   lsphp70-opcache \
                   lsphp70-odbc \
                   lsphp70-mysqlnd \
                   lsphp70-mcrypt \
                   lsphp70-mbstring \
                   lsphp70-ldap \
                   lsphp70-intl \
                   lsphp70-imap \
                   lsphp70-gmp \
                   lsphp70-gd \
                   lsphp70-enchant \
                   lsphp70-dba  \
                   lsphp70-common  \
                   lsphp70-bcmath

RUN yum -y install lsphp71 \
                   lsphp71-json \
                   lsphp71-xmlrpc \
                   lsphp71-xml \
                   lsphp71-tidy \
                   lsphp71-soap \
                   lsphp71-snmp \
                   lsphp71-recode \
                   lsphp71-pspell \
                   lsphp71-process \
                   lsphp71-pgsql \
                   lsphp71-pear \
                   lsphp71-pdo \
                   lsphp71-opcache \
                   lsphp71-odbc \
                   lsphp71-mysqlnd \
                   lsphp71-mcrypt \
                   lsphp71-mbstring \
                   lsphp71-ldap \
                   lsphp71-intl \
                   lsphp71-imap \
                   lsphp71-gmp \
                   lsphp71-gd \
                   lsphp71-enchant \
                   lsphp71-dba  \
                   lsphp71-common  \
                   lsphp71-bcmath

RUN yum -y install lsphp72 \
                   lsphp72-json \
                   lsphp72-xmlrpc \
                   lsphp72-xml \
                   lsphp72-tidy \
                   lsphp72-soap \
                   lsphp72-snmp \
                   lsphp72-recode \
                   lsphp72-pspell \
                   lsphp72-process \
                   lsphp72-pgsql \
                   lsphp72-pear \
                   lsphp72-pdo \
                   lsphp72-opcache \
                   lsphp72-odbc \
                   lsphp72-mysqlnd \
                   lsphp72-mcrypt \
                   lsphp72-mbstring \
                   lsphp72-ldap \
                   lsphp72-intl \
                   lsphp72-imap \
                   lsphp72-gmp \
                   lsphp72-gd \
                   lsphp72-enchant \
                   lsphp72-dba  \
                   lsphp72-common  \
                   lsphp72-bcmath

RUN yum -y install lsphp73 \
                   lsphp73-json \
                   lsphp73-xmlrpc \
                   lsphp73-xml \
                   lsphp73-tidy \
                   lsphp73-soap \
                   lsphp73-snmp \
                   lsphp73-recode \
                   lsphp73-pspell \
                   lsphp73-process \
                   lsphp73-pgsql \
                   lsphp73-pear \
                   lsphp73-pdo \
                   lsphp73-opcache \
                   lsphp73-odbc \
                   lsphp73-mysqlnd \
                   lsphp73-mcrypt \
                   lsphp73-mbstring \
                   lsphp73-ldap \
                   lsphp73-intl \
                   lsphp73-imap \
                   lsphp73-gmp \
                   lsphp73-gd \
                   lsphp73-enchant \
                   lsphp73-dba  \
                   lsphp73-common  \
                   lsphp73-bcmath


COPY conf/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
RUN  chown lsadm:lsadm /usr/local/lsws/conf -R

EXPOSE 80 443

ENV LSPHP=73
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

WORKDIR /usr/local/lsws

CMD ["/usr/local/lsws/bin/lswsctrl","start"]
