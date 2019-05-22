#引入php安装的sls
include:
  - modules.php.install

#php-ini配置文件配置
php-ini:
  file.managed:
    - name: /usr/local/php/etc/php.ini
    - source: salt://modules/php/files/php.ini.template
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-install
  cmd.run:
    - name: ln -s /usr/local/php/etc/php.ini /etc/php.ini
    - unless: test -L /etc/php.ini
    - require:
      - file: php-ini

#php-fpm配置文件配置
php-fpm:
  file.managed:
    - name: /usr/local/php/etc/php-fpm.conf
    - source: salt://modules/php/files/php-fpm.conf.template
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-install
  cmd.run:
    - name: ln -s /usr/local/php/etc/php-fpm.conf /etc/php-fpm.conf
    - unless: test -L /etc/php-fpm.conf
    - require:
      - file: php-fpm

#加入system启动
php-systemd:
  file.managed:
    - name: /usr/lib/systemd/system/php-fpm.service
    - source: salt://modules/php/files/php-fpm.service.template
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-install

#加入/etc/init.d/启动
php-init:
  file.managed:
    - name: /etc/init.d/php-fpm
    - source: salt://modules/php/files/php-fpm.template
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: php-install

#启动php-fpm
php-service:
  service.running:
    - name: php-fpm
    - enable: True
    - require:
      - file: php-systemd
    - watch:
      - file: php-fpm
      - file: php-ini
