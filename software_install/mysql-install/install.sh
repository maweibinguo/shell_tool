#/bin/bash

####################################
# 执行php安装                      #
####################################

# 初始化基础的依赖
function init_php_base_dependences()
{
    yum install -y gcc gcc-c++ ncurses-devel perl
    return 1
}

# 开始编译php
function compile_php()
{
}

# 安装
function install_php()
{
    local php_url=${php[0]}
    local php_install_path=${php[1]}
    local php_source_path=${php[2]}
    local php_package_name=`echo ${php[3]}|sed 's|http://at2.php.net/get/\(.*\)/from/this.mirror|\1|'`

    if [ $(dir_exists ${php_install_path}) -eq 0 ] ;then
        mkdir -p $php_install_path
    fi

    if [ $(dir_exists ${php_source_path}) -eq 0 ]; then
        mkdir -p $php_source_path
    fi

    if [ $(is_had_done 'php_url') -eq 0  ]; then
        download_to_target_palce "${php_url}" "${php_source_path}"
    fi

    cd ${php_source_path}
    # 解压文件
    local tar_source_package_name=$(echo $php_url|sed 's#.*/##g')
    if [ $(is_had_done 'php_source_package_path') -eq 0 ]; then
        mv ${tar_source_package_name} ${php_package_name}
        tar -jxvf $php_package_name
    fi

    # 初始化依赖
    local source_package_name=$(get_tar_top_dir ${php_package_name})
    if [ $(is_had_done 'init_php_base_dependences') -eq 0 ]; then
        init_php_base_dependences
    fi

    # 编译安装
    local source_package_path="${php_source_path}${source_package_name}"
    if [ $(is_had_done 'compile_php') -eq 0 ]; then
        compile_php "${source_package_path}" "${php_install_path}"
    fi
}
