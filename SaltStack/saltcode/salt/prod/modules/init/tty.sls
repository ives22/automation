tty-config:
  file.append:
    - name: /etc/bashrc
    - template: jinja
    - sources:
      - salt://modules/init/files/tty.tmp
