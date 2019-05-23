include:
  - modules.httpd.php 
apache-install:
  pkg.installed:
    - pkgs:
      - httpd
      - httpd-tools
    
apache-config:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://modules/httpd/files/httpd.conf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: apache-install   #表示上面apache-install执行成功，才能执行apache-config
    - template: jinja
    - defaults:
      PORT: 8000
    - watch_in:
      - service: apache-service

apache-service:
  service.running:
    - name: httpd
    - enable: True

