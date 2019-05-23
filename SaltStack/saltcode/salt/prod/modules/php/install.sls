{% set php_version = "5.6.40" %}
include:
  - modules.pkg.pkg-init

php-install:
  file.managed:
    - name: /usr/local/src/php-{{ php_version }}.tar.gz
    - source: salt://modules/php/files/php-{{ php_version }}.tar.gz
    - user: root
    - group: root
    - mode: 644

  cmd.run:
    - name: cd /usr/local/src/ && tar xf php-{{ php_version }}.tar.gz && cd php-{{ php_version }} && ./configure --prefix=/usr/local/php-{{ php_version }} --with-curl --with-freetype-dir --with-gd --with-gettext --with-iconv-dir --with-jpeg-dir --with-kerberos --with-libdir=lib64 --with-libxml-dir --with-mysql --with-mysqli --with-openssl --with-pcre-regex --with-pdo-mysql --with-dpo-sqlite --with-pear --with-png-dir --with-openssl --with-xmlrpc --with-xsl --with-zlib --enable-fpm --enable-bcmath --enable-libxml --enable-inline-optimization --enable-gd-native-ttf --enable-mbregex --enable-mbstring --enable-opcache --enable-pcntl --enable-shmop --enable-soap --enable-sockets --enable-sysvsem --enable-xml --enable-zip && make && make install && ln -s /usr/local/php-{{ php_version }} /usr/local/php
    - unless: test -d /usr/local/php-{{ php_version }} && test -L /usr/local/php
    - require:
      - file: php-install
      - pkg: pkg-install
