epel-yum-config:
  pkg.installed:
    - sources:
    {% if grains['osmajorrelease'] == 6 %}
      - epel-release: https://mirrors.aliyun.com/epel/epel-release-latest-6.noarch.rpm 
    {% elif grains['osmajorrelease'] == 7 %}
      - epel-release: https://mirrors.aliyun.com/epel/epel-release-latest-7.noarch.rpm
    {% endif %}
    - unless: rpm -qa |grep epel-release
