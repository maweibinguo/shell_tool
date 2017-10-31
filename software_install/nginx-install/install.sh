#/bin/bash

####################################
# 执行nginx安装                    #
####################################

# 初始化基础的依赖
function init_nginx_base_dependences()
{
    yum -y install make zlib zlib-devel gcc-c++ libtool  openssl openssl-devel
    return 1
}

# 开始编译php
function compile_nginx()
{

}

# 安装
function install_php()
{
    local nginx_url=$nginx[0] 
    local pcre_url=$nginx[1]
    local nginx_install_path=$php[2]
    local nginx_source_path=$php[3] 
    if [ $(dir_exists ${nginx_install_path}) -eq 0 ] ;then
        mkdir -p $nginx_install_path
    fi

    if [ $(dir_exists ${nginx_source_path}) -eq 0 ]; then
        mkdir -p $nginx_source_path
    fi

    if [ $(is_had_done 'php_url') -eq 0  ]; then
        download_to_target_palce "${pcre_url}" "${nginx_source_path}"
        download_to_target_palce "${nginx_url}" "${nginx_source_path}"
    fi

    local tar_source_package_name=$(echo $nginx_url|sed 's#.*/##g')
    local tar_source_package_path="${nginx_source_path}/${tar_source_package_name}"
    if [ $(is_had_done 'nginx_source_path') -eq 0 ]; then
        tar -xvzf $ -C $nginx_source_path
    fi

    local package_name=$(tar -tf ${source_package_name} |  awk -F "/" '{print $1}'|tail -n  1)
    cd $package_name
    
    if [ $(is_had_done 'init_php_base_dependences') -eq 0 ]; then
        init_php_base_dependences
    fi

    if [ $(is_had_done 'compile_php') -eq 0 ]; then
        compile_php $php_install_path
    fi
}
