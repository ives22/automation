php-install:
  pkg.installed:
    - pkgs:
      - php
      - php-mysql
      - php-pdo
      - php-cli
    - reqiure_in:
      - file: php-config

php-config:
  file.managed:
    - name: /etc/php.ini
    - source: salt://modules/httpd/files/php.ini
    - user: root
    - group: root
    - mode: 644

