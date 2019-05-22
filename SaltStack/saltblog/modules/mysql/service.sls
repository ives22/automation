#引入mysql安装的sls
include:
  - modules.mysql.install

#my.cnf配置文件
mariadb-config:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://modules/mysql/files/my.cnf
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: mariadb-install

#启动mariadb
mariadb-service:
  service.running:
    - name: mariadb
    - enable: True
    - watch:
      - file: mariadb-config
    - require:
      - pkg: mariadb-install
      - file: mariadb-config
