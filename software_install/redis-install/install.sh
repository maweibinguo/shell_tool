#/bin/bash

####################################
# 执行redis安装                      #
####################################

# 初始化基础的依赖
function init_redis_base_dependences()
{
    yum -y install gcc gcc-c++ make
}

# 开始编译redis
function compile_redis()
{
    local source_package_path=$1
    local redis_install_path=$2
    cd $source_package_path
    
    make && make PREFIX=${redis_install_path} install

    if [ $? -gt 0 ]; then
       show_error "compile redis failed" 
       exit 1
    fi

    return 1
}

# 配置redis
function config_redis()
{
    local source_package_path=$1
    local redis_install_path=$2
    cd $source_package_path
    mkdir -p '/etc/redis' && cp ./redis.conf /etc/redis/6379.conf
    cp ./utils/redis_init_script /etc/init.d/redisd
    ln -s ${redis_install_path}/bin/redis-cli /usr/local/bin/redis-cli
    ln -s ${redis_install_path}/bin/redis-server /usr/local/bin/redis-server

    # 启动redis为守护进程
    sed -i "s/daemonize *no/#daemonize no\ndaemonize yes/g" `grep '^daemonize *no' -rl /etc/redis/6379.conf`
}

# 安装
function install_redis()
{
    local redis_url=${redis[0]}
    local redis_install_path=${redis[1]}
    local redis_source_path=${redis[2]}

    if [ $(dir_exists ${redis_install_path}) -eq 0 ] ;then
        mkdir -p $redis_install_path
    fi

    if [ $(dir_exists ${redis_source_path}) -eq 0 ]; then
        mkdir -p $redis_source_path
    fi

    if [ $(is_had_done 'redis_url') -eq 0  ]; then
        download_to_target_palce "${redis_url}" "${redis_source_path}" || rollback 'redis_url'
    fi

    # 解压文件
    cd ${redis_source_path}
    local tar_source_package_name=$(echo $redis_url|sed 's#.*/##g')
    if [ $(is_had_done 'redis_source_package_path') -eq 0 ]; then
        decompress_file ${tar_source_package_name} || rollback 'redis_source_package_path'
    fi

    # 初始化依赖
    if [ $(is_had_done 'redis_init_base_dependences') -eq 0 ]; then
       init_redis_base_dependences || rollback 'redis_init_base_dependences' 
    fi

    # 编译安装
    local package_name_redis=$(tar -tf ${tar_source_package_name} |  awk -F "/" '{print $1}'|tail -n  1)
    if [ $(is_had_done 'redis_compile') -eq 0 ]; then
        compile_redis ${redis_source_path}${package_name_redis} ${redis_install_path} || rollback 'redis_compile'
    fi

    # 配置redis
    if [ $(is_had_done 'redis_config') -eq 0 ]; then
        config_redis ${redis_source_path}${package_name_redis} ${redis_install_path} || rollback 'redis_config'
    fi
}
