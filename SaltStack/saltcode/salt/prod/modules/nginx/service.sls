#引入nginx安装sls
include:
  - modules.nginx.install

#添加systemctl
nginx-init:
  file.managed:
    - name: /usr/lib/systemd/system/nginx.service
    - source: salt://modules/nginx/files/nginx.service.template
    - user: root
    - group: root
    - mode: 755
    - unless: test -f /usr/lib/systemd/system/nginx.service
  cmd.run:
    - name: systemctl daemon-reload
    - require:
      - file: nginx-init

#配置文件
/usr/local/nginx/conf/nginx.conf:
  file.managed:
    - source: salt://modules/nginx/files/nginx.conf.template
    - user: root
    - group: root
    - mode: 644

#启动nginx
nginx-service:
  file.directory:
    - name: /usr/local/nginx/conf/conf.d
    - user: root
    - group: root
    - mode: 755
    - require:
      - cmd: nginx-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-init
    - watch:
      - file: /usr/local/nginx/conf/nginx.conf
      - file: nginx-service
