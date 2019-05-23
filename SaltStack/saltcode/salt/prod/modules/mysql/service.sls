#引入mysql安装的sls
include:
  - modules.mysql.install

#my.cnf配置文件
mysql-config:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://modules/mysql/files/my.cnf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mysql-install
    - template: jinja
    - defaults:
      {% if grains['osmajorrelease'] == 6 %}
      PID_FILE: mysqld
      {% elif grains['osmajorrelease'] == 7 %}
      PID_FILE: mariadb
      {% endif %}

#启动mysql
mysql-service:
  service.running:
    {% if grains['osmajorrelease'] == 6 %}
    - name: mysqld
    {% elif grains['osmajorrelease'] == 7 %}
    - name: mariadb
    {% endif %}
    - enable: True
    - watch:
      - file: mysql-config
    - require:
      - pkg: mysql-install
      - file: mysql-config
