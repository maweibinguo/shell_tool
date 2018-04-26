#/bin/bash

####################################
# 执行php安装                      #
####################################

# 定义依赖的基础文件
root_dir=`pwd`
config_file_path=${root_dir}'/config/config.sh'
file_tool=${root_dir}'/common/file_tool.sh'
network_tool=${root_dir}'/common/network_tool.sh'
string_tool=${root_dir}'/common/string_tool.sh'
user_tool=${root_dir}'/common/user_tool.sh'
error_tool=${root_dir}'/common/show_notice.sh'
php_install=${root_dir}'/php-install/install.sh'
nginx_install=${root_dir}'/nginx-install/install.sh'
mysql_install=${root_dir}'/mysql-install/install.sh'
redis_install=${root_dir}'/redis-install/install.sh'
beanstalkd_install=${root_dir}'/beanstalkd-install/install.sh'

# 加载文件
source $config_file_path 
source $file_tool 
source $network_tool 
source $string_tool
source $user_tool
source $error_tool
source $php_install
source $nginx_install
source $mysql_install
source $redis_install
source $beanstalkd_install

function install()
{
    local software_name=$1
    software_name=$(str_to_lowercase ${software_name})
    case $software_name in
        mysql)
            show_title " start to install mysql "
            install_mysql
            show_title " install mysql over "
            show_title " now you can execute 'service mysqld start' command to start redis "
            ;;
        php)
            show_title " start to install php "
            install_php
            show_title " install php over "
            show_title " now you can execute 'service php-fpmd start' command to start php-fpm "

            ;;
        nginx)
            show_title " start to install nginx "
            install_nginx
            show_title " install nginx over "
            ;;
        redis)
            show_title " start to install redis "
            install_redis
            show_title " install redis over "
            show_title " now you can execute 'service redisd start' command to start redis "
            ;;
        supervisord)
    	    show_title "Program is Develeping , Please Waiter"
    	    exit 1
            ;;
        beanstalkd)
            show_title " start to install beanstalkd "
            install_beanstalkd
            show_title " install beanstalkd over "
            show_title " now you can execute 'service beanstalkd start' command to start redis "
            ;;
        *)
            echo 
            echo "Your Choice Is Wrong, Plase Rerun Install.sh"
            echo 
            exit 1
            ;;
     esac

}

read -p "Please choice your software name (mysql | php | nginx | redis | supervisord | beanstalkd) : " softwarename

install $softwarename
