#/bin/bash

####################################
# 执行php安装                      #
####################################

# 初始化基础的依赖
function init_php_base_dependences()
{
   yum -y install gcc gcc-c++ autoconf libjpeg libjpeg-devel libpng libpng-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glibc glibc-devel glib2 glib2-devel bzip2 bzip2-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel openldap openldap-devel nss_ldap openldap-clients openldap-servers gd gd2 gd-devel gd2-devel perl-CPAN pcre-devel gmp-devel epel-release libmcrypt-devel readline-devel libxslt-devel
    return 1
}

# 开始编译php
function compile_php()
{
    local source_package_path=$1
    local php_install_path=$2
    cd $source_package_path
    ./configure \
    --prefix="${php_install_path}" \
    --with-config-file-path="${php_install_path}/etc" \
    --with-config-file-scan-dir="${php_install_path}/etc/conf.d" \
    --with-fpm-user=deployer \
    --with-fpm-group=deployer \
    --enable-fpm \
    --enable-soap \
    --with-openssl \
    --with-mcrypt \
    --with-pcre-regex \
    --with-sqlite3 \
    --with-zlib \
    --enable-bcmath \
    --with-iconv \
    --with-bz2 \
    --enable-calendar \
    --with-curl \
    --with-cdb \
    --enable-dom \
    --enable-exif \
    --enable-fileinfo \
    --enable-filter \
    --with-pcre-dir \
    --enable-ftp \
    --with-gd \
    --with-openssl-dir \
    --with-jpeg-dir \
    --with-png-dir \
    --with-freetype-dir \
    --with-gettext \
    --with-gmp \
    --with-mhash \
    --enable-json \
    --enable-mbstring \
    --disable-mbregex \
    --disable-mbregex-backtrack \
    --with-libmbfl \
    --with-onig \
    --enable-pdo \
    --with-pdo-mysql \
    --with-zlib-dir \
    --with-pdo-sqlite \
    --with-readline \
    --enable-session \
    --enable-shmop \
    --enable-simplexml \
    --enable-sockets \
    --enable-sysvmsg \
    --enable-sysvsem \
    --enable-sysvshm \
    --enable-wddx \
    --with-libxml-dir \
    --with-xsl \
    --enable-zip \
    --enable-mysqlnd-compression-support \
    --with-pear \
    --with-mysqli
    
    if [ $? -gt 0 ]; then
       show_error "compile php failed" 
       exit 1
    fi
    make && make install
    return 1
}

# 安装
function install_php()
{
    local php_url=${php[0]}
    local php_install_path=${php[1]}
    local php_source_path=${php[2]}
    local php_package_name=${php[3]}
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
