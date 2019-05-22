#部署lnmp及haproxy+keepalived
prod:
  "salt-minion0[3-4]":
    - modules.lnmp.www

  "salt-minion0[1-2]":
    - modules.haproxy.service
    - modules.keepalived.service

#单实例操作说明：
prod:
  "salt-minion04":
    - modules.nginx.service	#单独安装nginx时
    - modules.mysql.service     #单独安装mysql时
    - modules.php.service       #单独安装php时
    - modules.keepalived.service  #单独安装keepalived时
    - modules.haproxy.service   #单独安装haproxy时

  "salt-minion03":
    - modules.lnmp.www     #单独部署lnmp环境时
