#/bin/bash

####################################
# lamp安装的配置文件               #
####################################

#############
# git配置 # 
#############

# git 源码包下载地址
git[0]="https://github.com/git/git/archive/v2.4.0.tar.gz"

# redis 安装路径
git[1]="/usr/local/git/v2.4.0/"

# redis 存放地址
git[2]="/usr/local/src/git/"


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

# mysql 下载地址
mysql[0]="http://dev.mysql.com/get/Downloads/MySQL-5.7/mysql-boost-5.7.10.tar.gz"

# mysql 安装地址
mysql[1]="/usr/local/mysql/5.7/"

# mysql 源码包存放地址
mysql[2]="/usr/local/src/mysql/"

# cmake 下载地址
mysql[3]="https://cmake.org/files/v3.4/cmake-3.4.1.tar.gz"

#############
# redis配置 # 
#############

# redis 源码包下载地址
redis[0]="http://download.redis.io/releases/redis-3.2.9.tar.gz"

# redis 安装路径
redis[1]="/usr/local/redis/3.2.9/"

# redis 存放地址
redis[2]="/usr/local/src/redis/"

###################
# beanstalked配置 # 
###################

# redis 源码包下载地址
beanstalkd[0]="https://github.com/kr/beanstalkd/archive/master.zip"

# redis 存放地址
beanstalkd[1]="/usr/local/src/beanstalkd/"
