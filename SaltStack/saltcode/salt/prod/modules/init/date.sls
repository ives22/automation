ntpdate-install:
  pkg.installed:
    - name: ntpdate
    - unless: rpm -qa |grep ntpdate

  cmd.run:
    - name: mv /etc/localtime /etc/localtime_bak && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && /usr/sbin/ntpdate ntp.api.bz
    - require:
      - pkg: ntpdate-install

  cron.present:
    - name: /usr/sbin/ntpdate ntp.api.bz >> /dev/null
    - user: root
    - minute: "*/15"
    - require:
      - pkg: ntpdate-install
