login-sh:
  file.managed:
    - name: /usr/local/bin/login.sh
    - source: salt://modules/init/files/login.tmp
    - user: root
    - group: root
    - mode: 755

login-config:
  file.append:
    - name: /etc/profile
    - text:
      - '#Login message prompt'
      - /usr/local/bin/login.sh
    - require:
      - file: login-sh

