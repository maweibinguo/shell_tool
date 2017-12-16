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
error_tool=${root_dir}'/common/show_notice.sh'
php_install=${root_dir}'/php-install/install.sh'
nginx_install=${root_dir}'/nginx-install/install.sh'
mysql_install=${root_dir}'/mysql-install/install.sh'

# 加载文件
source $config_file_path 
source $file_tool 
source $network_tool 
source $string_tool
source $error_tool
source $php_install
source $nginx_install
source $mysql_install

function install()
{
    local software_name=$1
    software_name=$(str_to_lowercase ${software_name})
    case $software_name in
        mysql)
            show_title " start to install mysql "
            install_mysql
            show_title " install mysql over "
            ;;
        php)
            show_title " start to install php "
            install_php
            show_title " install php over "
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
            ;;
        supervisord)
            show_title " start to install nginx "
            install_supervisord
            show_title " install nginx over "
            ;;
        *)
            echo 
            echo "Your Choice Is Wrong, Plase Rerun Install.sh"
            echo 
            exit 1
            ;;
     esac

}

read -p "Please choice your software name (mysql | php | nginx | redis | supervisord ) : " softwarename

install $softwarename
