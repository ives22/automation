/usr/sbin/ntpdate ntp.api.bz && /sbin/hwclock -w:
  cron.present:
    - identifier: 时间同步
    - comment: yanjieli 
    - user: root
    - minute: '*/15'

/usr/bin/chattr +i /etc/passwd /etc/shadow /etc/group /etc/gshadow:
  cron.present:
    - identifier: 文件权限控制
    - comment: yanjieli
    - user: root
    - minute: 0
    - hour: '*/1'
