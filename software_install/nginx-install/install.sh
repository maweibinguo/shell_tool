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

# 开始编译pcre
function compile_pcre()
{
    local compile_path=$1
    cd ${compile_path}
    ./configure
    make && make install
}

# 开始编译nginx
function compile_nginx()
{
    local compile_path=$1
    local pcre_path=$2
    local nginx_install_path=$php[2]
    cd ${compile_path}
    ./configure --prefix=${nginx_install_path} --with-http_stub_status_module --with-http_ssl_module --with-pcre=${pcre_path}
    make && make install
}

# 安装
function install_nginx()
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

    if [ $(is_had_done 'pcre_url') -eq 0  ]; then
        download_to_target_palce "${pcre_url}" "${nginx_source_path}"
    fi
    if [ $(is_had_done 'nginx_url') -eq 0  ]; then
        download_to_target_palce "${nginx_url}" "${nginx_source_path}"
    fi

    cd ${nginx_source_path}
    local tar_source_package_name_nginx=$(echo $nginx_url|sed 's#.*/##g')
    local tar_source_package_name_pcre=$(echo $nginx_url|sed 's#.*/##g')
    if [ $(is_had_done 'nginx_source_path') -eq 0 ]; then
        decompress_file $tar_source_package_name_nginx
    fi

    if [ $(is_had_done 'pcre_source_path') -eq 0 ]; then
        decompress_file $tar_source_package_name_pcre
    fi

    local package_name_nginx=$(tar -tf ${tar_source_package_name_nginx} |  awk -F "/" '{print $1}'|tail -n  1)
    local package_name_pcre=$(tar -tf ${tar_source_package_name_pcre} |  awk -F "/" '{print $1}'|tail -n  1)
    cd $package_name_pcre
    if [ $(is_had_done 'compile_pcre') -eq 0 ]; then
        compile_pcre $nginx_source_path${package_name_pcre}
    fi

    if [ $(is_had_done 'init_nginx_base_dependences') -eq 0 ]; then
        init_nginx_base_dependences
    fi

    if [ $(is_had_done 'compile_nginx') -eq 0 ]; then
        compile_nginx ${nginx_install_path}${package_name_nginx} ${nginx_install_path}${package_name_pcre}
    fi
}
