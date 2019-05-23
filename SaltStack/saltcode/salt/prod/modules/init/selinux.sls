#关闭selinux
disable-selinux:
  cmd.run:
    - name: sed -i 's/^SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
    - unless: grep "SELINUX=disabled" /etc/selinux/config
