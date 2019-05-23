history-config:
  file.append:
    - name: /etc/bashrc
    - template: jinja
    - sources:
      - salt://modules/init/files/history.tmp
