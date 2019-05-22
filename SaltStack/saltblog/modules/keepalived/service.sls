#引入keepalived安装的sls
include:
  - modules.keepalived.install

#keepalived配置文件
keepalived-config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://modules/keepalived/files/keepalived.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: keepalived-install
    - template: jinja
    - defaults:
{% if grains['fqdn'] == "salt-minion01" %}
      ROUTER_ID: saltstack01
      STATE: MASTER
      PRIORITY: 150
{% elif grains['fqdn'] == "salt-minion02" %}
      ROUTER_ID: saltstack02
      STATE: BACKUP
      PRIORITY: 100
{% endif %}

#启动keepalived
keepalived-service:
  service.running:
    - name: keepalived
    - enable: True
    - require:
      - pkg: keepalived-install
      - file: keepalived-config
    - watch:
      - file: keepalived-config
