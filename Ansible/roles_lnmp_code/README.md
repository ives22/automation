## roles实战lnmp环境部署

> 源码安装`nginx`、源码安装`php`、`yum`安装`MySQL`，支持系统`centos6.x`及`centos7.x` 。具体使用方法[参考博客](https://buji595.github.io/2019/06/05/Ansible%E9%A1%B9%E7%9B%AE%E5%AE%9E%E6%88%98lnmp/#more)



### 整体结构查看

```
[root@ansible roles]# tree 
.
├── hostlist
├── init_pkg.yml
├── lnmp.yml
├── mysql
│   ├── files
│   ├── handlers
│   │   └── main.yml
│   ├── tasks
│   │   ├── config.yml
│   │   ├── install.yml
│   │   ├── main.yml
│   │   └── service.yml
│   ├── templates
│   │   ├── my.cnf6.j2
│   │   └── my.cnf7.j2
│   └── vars
├── mysql_roles.yml
├── nginx
│   ├── files
│   │   ├── nginx-1.12.2.tar.gz
│   │   └── nginx-1.16.0.tar.gz
│   ├── handlers
│   │   └── main.yml
│   ├── tasks
│   │   ├── config.yml
│   │   ├── copypkg.yml
│   │   ├── group.yml
│   │   ├── install.yml
│   │   ├── main.yml
│   │   ├── service.yml
│   │   └── user.yml
│   ├── templates
│   │   ├── nginx.conf.j2
│   │   ├── nginx_init.j2
│   │   └── nginx.service.j2
│   └── vars
│       └── main.yml
├── nginx_roles.yml
├── php
│   ├── files
│   │   └── php-5.6.40.tar.gz
│   ├── handlers
│   │   └── main.yml
│   ├── tasks
│   │   ├── config.yml
│   │   ├── copypkg.yml
│   │   ├── group.yml
│   │   ├── install.yml
│   │   ├── main.yml
│   │   ├── service.yml
│   │   └── user.yml
│   ├── templates
│   │   ├── php-fpm.conf.j2
│   │   ├── php-fpm.init.j2
│   │   ├── php-fpm.service.j2
│   │   └── php.ini.j2
│   └── vars
│       └── main.yml
├── php_roles.yml
└── vhost.conf.j2

18 directories, 42 files

```



