{% set nginx_version = "1.16.0"%}
include:
  - modules.pkg.pkg-init
  - modules.user.www

nginx-install:
  file.managed:
    - name: /usr/local/src/nginx-{{ nginx_version }}.tar.gz
    - source: salt://modules/nginx/files/nginx-{{ nginx_version }}.tar.gz
    - user: root
    - group: root
    - mode: 644

  cmd.run:
    - name: cd /usr/local/src/ && tar xf nginx-{{ nginx_version }}.tar.gz && cd nginx-{{ nginx_version }} && ./configure --prefix=/usr/local/nginx-{{ nginx_version }} --user=root --group=root --with-http_ssl_module --with-stream --with-http_stub_status_module --with-file-aio --with-http_gzip_static_module && make && make install && ln -s /usr/local/nginx-{{ nginx_version }} /usr/local/nginx
    - unless: test -d /usr/local/nginx-{{ nginx_version }} && test -L /usr/local/nginx
    - require:
      - file: nginx-install
      - pkg: pkg-install
