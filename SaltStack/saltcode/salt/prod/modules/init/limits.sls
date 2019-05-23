/etc/security/limits.conf:
  file.append:
    - text:
      - '* soft nofile 30000'
      - '* hard nofile 40000' 
