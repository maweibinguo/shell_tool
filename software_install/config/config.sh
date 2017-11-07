#/bin/bash

####################################
# lamp安装的配置文件               #
####################################

############
# php配置 # 
############

#获取源代码的地址
php[0]="http://at2.php.net/get/php-7.1.11.tar.bz2/from/this/mirror"

#php安装路径
php[1]="/usr/local/php/7.1.11/"

#php源代码保存路径
php[2]="/usr/local/src/php/"

#php安装包名称
php[3]="php-7.1.11.tar.bz2"

#############
# nginx配置 # 
#############

#http://nginx.org/download/ ngix源码包获取地址
nginx[0]="http://nginx.org/download/nginx-1.6.2.tar.gz"

# nginx 安装地址
nginx[1]="/usr/local/nginx/1.6.2/"

# nginx 源码包存放地址
nginx[2]="/usr/local/src/nginx/"

# pcre 包下载地址
nginx[3]="http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz"

#############
# mysql配置 # 
#############