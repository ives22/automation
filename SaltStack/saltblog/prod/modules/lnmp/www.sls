#引入nginx、php、mysql的安装
include:
  - modules.nginx.service
  - modules.php.service
  - modules.mysql.service

#虚拟主机web站点目录创建
web-www:
  file.directory:
    - name: /opt/www
    - user: www
    - group: www
    - mode: 755

#虚拟主机配置文件配置
web-www-conf:
  file.managed:
    - name: /usr/local/nginx/conf/conf.d/www.conf
    - source: salt://modules/lnmp/files/www.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: web-www
    - watch_in:
      - service: nginx-service
    - template: jinja
    - defaults:
      PORT: 80
      IPADDR: {{ grains['fqdn_ip4'][0] }}

#phpinfo测试文件准备
web-index:
  file.managed:
    - name: /opt/www/index.php
    - source: salt://modules/lnmp/files/index.php
    - user: www
    - group: www
    - mode: 644
