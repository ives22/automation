#配置yum仓库
zabbix-epel:
  pkg.installed:
    {% if grains['osmajorrelease'] == 6 %}
    - sources:
      - zabbix-release: https://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-release-4.0-1.el6.noarch.rpm 
    {% elif grains['osmajorrelease'] == 7 %}
    - sources:
      - zabbix-release: https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
    {% endif %}
    - unless: rpm -aq |grep zabbix-release

#安装zabbix_agent
zabbix-agent-install:
  pkg.installed:
    - name: zabbix-agent
    - require:
      - pkg: zabbix-epel
    - unless: rpm -aq |grep zabbix-agent

#配置zabbix_agent
zabbix-agent-config:
  file.managed:
    - name: /etc/zabbix/zabbix_agentd.conf
    - source: salt://modules/init/files/zabbix_agent.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      Hostname: {{ grains['fqdn'] }}
      Server: {{ pillar['zabbix-agent']['Zabbix_Server'] }}
    - require:
      - pkg: zabbix-agent-install
#配置/etc/zabbix/zabbix_agentd.d/
zabbix_agentd:
  file.directory:
    - name: /etc/zabbix/zabbix_agentd.d
    - watch_in:
      - service: zabbix-agent-service
    - require:
      - file: zabbix-agent-config
      - pkg: zabbix-agent-install

#启动zabbix_agent
zabbix-agent-service:
  service.running:
    - name: zabbix-agent
    - enable: True
    - require:
      - file: zabbix-agent-config
      - pkg: zabbix-agent-install
    - watch:
      - file: zabbix-agent-config

