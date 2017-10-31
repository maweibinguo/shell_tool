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

nginx[0]="http://nginx.org/download/nginx-1.6.2.tar.gz"

nginx[1]="http://downloads.sourceforge.net/project/pcre/pcre/8.35/pcre-8.35.tar.gz"

nginx[2]="/usr/local/nginx/1.6.2/"

nginx[3]="/usr/local/src/nginx/"
