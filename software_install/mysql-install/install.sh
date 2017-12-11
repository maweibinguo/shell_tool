#/bin/bash

####################################
# 执行php安装                      #
####################################

# 初始化基础的依赖
function init_mysql_base_dependences()
{
    yum -y install make gcc-c++ cmake bison-devel  ncurses-devel gcc  autoconf automake zlib* fiex* libxml* libmcrypt* libtool-ltdl-devel*
    return 1
}

# 开始编译mysql
function compile_mysql()
{
    local source_path=$1
    local install_path=${2}
    cd ${source_path}
   cmake \
    -DCMAKE_INSTALL_PREFIX=${install_path} \
    -DMYSQL_UNIX_ADDR=${install_path}mysql.sock \
    -DDEFAULT_CHARSET=utf8mb4 \
    -DDEFAULT_COLLATION=utf8mb4_general_ci \
    -DWITH_INNOBASE_STORAGE_ENGINE=1 \
    -DWITH_ARCHIVE_STORAGE_ENGINE=1 \
    -DWITH_BLACKHOLE_STORAGE_ENGINE=1 \
    -DMYSQL_DATADIR=${install_path}data \
    -DMYSQL_TCP_PORT=3306 \
    -DWITH_BOOST=boost \
    -DENABLE_DOWNLOADS=1

    make && make install
}

# 开始编译cmake
function compile_cmake()
{
    local source_path=${1}
    cd $source_path
    ./bootstrap
    make && make install
    return 1
}

# 对mysql进行配置
function config_mysql()
{
    local source_path=$1
    local install_path=${2}

    # 账户
    groupadd mysql
    useradd -r -g mysql mysql

    #改变权限
    chown -R mysql:mysql ${install_path}

    # 初始化账号
    ${install_path}/bin/mysqld --initialize --user=mysql

    #设置配置
    cp -r ${source_path}/support-files/my-default.cnf /etc/my.cnf
    cp -r ${source_path}/support-files/mysql.server /etc/init.d/mysqld

    # service 管理的软连接
    ln -s ${install_path} /usr/local/mysql
}

# 安装
function install_mysql()
{
    local mysql_url=${mysql[0]}
    local mysql_install_path=${mysql[1]}
    local mysql_source_path=${mysql[2]}
    local cmake_url=${mysql[3]}
    if [ $(dir_exists ${mysql_install_path}) -eq 0 ] ;then
        mkdir -p $mysql_install_path
    fi

    if [ $(dir_exists ${mysql_source_path}) -eq 0 ]; then
        mkdir -p $mysql_source_path
    fi

    if [ $(is_had_done 'mysql_cmake_url') -eq 0  ]; then
        download_to_target_palce "${cmake_url}" "${mysql_source_path}"
    fi
    if [ $(is_had_done 'mysql_url') -eq 0  ]; then
        download_to_target_palce "${mysql_url}" "${mysql_source_path}"
    fi

    cd ${mysql_source_path}
    local tar_source_package_name_mysql=$(echo ${mysql_url}|sed 's#.*/##g')
    local tar_source_package_name_cmake=$(echo ${cmake_url}|sed 's#.*/##g')
    if [ $(is_had_done 'mysql_source_path') -eq 0 ]; then
        decompress_file $tar_source_package_name_mysql
    fi

    if [ $(is_had_done 'mysql_cmake_source_path') -eq 0 ]; then
        decompress_file $tar_source_package_name_cmake
    fi

    if [ $(is_had_done 'mysql_init_base_dependences') -eq 0 ]; then
        init_mysql_base_dependences
    fi

    local package_name_mysql=$(tar -tf ${tar_source_package_name_mysql} |  awk -F "/" '{print $1}'|tail -n  1)
    local package_name_cmake=$(tar -tf ${tar_source_package_name_cmake} |  awk -F "/" '{print $1}'|tail -n  1)
    if [ $(is_had_done 'mysql_compile_cmake') -eq 0 ]; then
        compile_cmake ${mysql_source_path}${package_name_cmake}
    fi

    if [ $(is_had_done 'mysql_compile') -eq 0 ]; then
        compile_mysql ${mysql_source_path}${package_name_mysql} ${mysql_install_path}
    fi

    if [ $(is_had_done 'mysql_config') -eq 0 ]; then
        config_mysql ${mysql_source_path}${package_name_mysql} ${mysql_install_path}
    fi
}
