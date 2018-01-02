#/bin/bash

####################################
# 执行git安装                      #
####################################

# 初始化基础的依赖
function init_git_base_dependences()
{
    yum -y install zlib-devel curl-devel openssl-devel perl cpio expat-devel gettext-devel openssl zlib autoconf tk perl-ExtUtils-MakeMaker
}

# 开始编译git
function compile_git()
{
    local source_package_path=$1
    local git_install_path=$2
    cd $source_package_path
    
    autoconf
    ./configure --prefix=${git_install_path}
    make && make install

    if [ $? -gt 0 ]; then
       show_error "compile git failed" 
       exit 1
    fi

    return 1
}

# 配置git
function config_git()
{
    local source_package_path=$1
    local git_install_path=$2

    # 创建软连接
    ln -s ${git_install_path}/bin/git /usr/local/bin/git
}

# 安装
function install_git()
{
    local git_url=${git[0]}
    local git_install_path=${git[1]}
    local git_source_path=${git[2]}

    if [ $(dir_exists ${git_install_path}) -eq 0 ] ;then
        mkdir -p $git_install_path
    fi

    if [ $(dir_exists ${git_source_path}) -eq 0 ]; then
        mkdir -p $git_source_path
    fi

    if [ $(is_had_done 'git_url') -eq 0  ]; then
        download_to_target_palce "${git_url}" "${git_source_path}"
    fi

    # 解压文件
    cd ${git_source_path}
    local tar_source_package_name=$(echo $git_url|sed 's#.*/##g')
    if [ $(is_had_done 'git_source_package_path') -eq 0 ]; then
        decompress_file ${tar_source_package_name}
    fi

    # 初始化依赖
    if [ $(is_had_done 'git_init_base_dependences') -eq 0 ]; then
       init_git_base_dependences 
    fi

    # 编译安装
    local package_name_git=$(tar -tf ${tar_source_package_name} |  awk -F "/" '{print $1}'|tail -n  1)
    if [ $(is_had_done 'git_compile') -eq 0 ]; then
        compile_git ${git_source_path}${package_name_git} ${git_install_path}
    fi

    # 配置git
    if [ $(is_had_done 'git_config') -eq 0 ]; then
        config_git ${git_source_path}${package_name_git} ${git_install_path}
    fi
}
