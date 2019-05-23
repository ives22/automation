{% if grains['osmajorrelease'] == 6 %}
mysql-epel-config:
  pkg.installed:
    - sources:
      - mysql57-release: http://repo.mysql.com//mysql57-community-release-el6-8.noarch.rpm
    - unless: rpm -aq |grep mysql-community
  cmd.run:
    - name: yum-config-manager --enable mysql56-community && yum-config-manager --disable mysql57-community
    - unless: yum repolist  |grep mysql56-community
    - require:
      - pkg: mysql-epel-config

mysql-install:
  pkg.installed:
    - pkgs:
      - mysql-community-server
    - unless: rpm -aq |grep mysql-community-server

{% elif grains['osmajorrelease'] == 7 %}
mysql-install:
  pkg.installed:
    - pkgs:
      - mariadb-server
      - mariadb
{% endif %}
