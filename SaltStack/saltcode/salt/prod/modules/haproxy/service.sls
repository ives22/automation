#引入haproxy安装的sls
include:
  - modules.haproxy.install

#配置文件
haproxy-config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://modules/haproxy/files/haproxy.cfg
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: haproxy-install

#启动haproxy
haproxy-service:
  service.running:
    - name: haproxy
    - enable: True
    - require:
      - pkg: haproxy-install
      - file: haproxy-config
    - watch:
      - file: haproxy-config
