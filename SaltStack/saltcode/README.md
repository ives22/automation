## Saltstack State code
>包含了初始化系统，常用软件安装，支持系统（`CentOS6`，`CentOS7`）
>1、所有的状态`state sls`文件都放在了`salt/prod/modules`目录下
>2、`pillar`的状态文件都放在了`pillar/prod`目录下
>3、`modules/init` 系统初始化（包含了,`yum`配置，常用的基础命令包安装，用户命令`history`审计，时间同步，内核参数优化，打开文件数优化，关闭`selinux`，终端`tty`优化，`zabbix_agent`安装配置）
>4、其他软件安装都在对应的`modules`目录下已对应软件名命名


### 环境说明
1）`Master`配置如下：`/etc/salt/master`
```
file_roots:
  base:
    - /srv/salt/base
  test:
    - /srv/salt/test
  prod:
    - /srv/salt/prod
  dev:
    - /srv/salt/dev

pillar_roots:
  base:
    - /srv/pillar/base
  prod:
    - /srv/pillar/prod
```

2）`salt`目录结构如下：
```
/srv/salt/
├── base
│   └── top.sls
├── dev
├── prod
│   └── modules
│       ├── haproxy
│       │   ├── files
│       │   │   └── haproxy.cfg
│       │   ├── install.sls
│       │   └── service.sls
│       ├── httpd
│       │   ├── files
│       │   │   ├── httpd.conf
│       │   │   └── php.ini
│       │   ├── install.sls
│       │   └── php.sls
│       ├── init
│       │   ├── date.sls
│       │   ├── env_init.sls
│       │   ├── epel.sls
│       │   ├── files
│       │   │   ├── history.tmp
│       │   │   ├── login.tmp
│       │   │   ├── tty.tmp
│       │   │   └── zabbix_agent.conf
│       │   ├── history.sls
│       │   ├── install.sls
│       │   ├── limits.sls
│       │   ├── login_mes.sls
│       │   ├── selinux.sls
│       │   ├── sysctl.sls
│       │   ├── tty.sls
│       │   └── zabbix_agent.sls
│       ├── keepalived
│       │   ├── files
│       │   │   └── keepalived.conf
│       │   ├── install.sls
│       │   └── service.sls
│       ├── lnmp
│       │   ├── files
│       │   │   ├── index.php
│       │   │   └── www.conf
│       │   └── www.sls
│       ├── mysql
│       │   ├── files
│       │   │   └── my.cnf
│       │   ├── install.sls
│       │   └── service.sls
│       ├── nginx
│       │   ├── files
│       │   │   ├── nginx-1.12.2.tar.gz
│       │   │   ├── nginx-1.16.0.tar.gz
│       │   │   ├── nginx.conf.template
│       │   │   └── nginx.service.template
│       │   ├── install.sls
│       │   └── service.sls
│       ├── php
│       │   ├── files
│       │   │   ├── php-5.6.40.tar.gz
│       │   │   ├── php-fpm.conf.template
│       │   │   ├── php-fpm.service.template
│       │   │   ├── php-fpm.template
│       │   │   └── php.ini.template
│       │   ├── install.sls
│       │   └── service.sls
│       ├── pkg
│       │   └── pkg-init.sls
│       └── user
│           └── www.sls
└── test

23 directories, 47 files
```
3）`pillar`目录结构如下：
```
/srv/pillar/
├── base
│   └── top.sls
└── prod
    └── zabbix
        └── agent.sls

3 directories, 2 files
```
## 使用说明：
> 1、将`modules`目录整体放在`salt-master`配置文件指定的`file_roots`目录下；
> 2、将`pillar`目录里面的`base`和`prod`放在配置文件指定的`pillar_roots`目录下；（建议和上面配置的`pillar`环境一致）并将`agent.sls`文件里面的`Zabbix_Server`的地址改为自己`zabbix`服务器的地址。