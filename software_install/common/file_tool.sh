#/bin/bash

####################################
#   文件处理函数封装               #
####################################

# 文件是否存在
function file_exists()
{
    local file_name=$1
    if [ -f "${file_name}" ]; then
        echo 1
    else
        echo 0
    fi
}

# 文件夹是否存在
function dir_exists()
{
    local dir_name=$1
    if [ -d $dir_name ]; then
        echo 1
    else
        echo 0
    fi
}

# 获取压缩文件的顶级目录
function get_tar_top_dir()
{
    tar_name=$1
    local package_name=$(tar -tf ${tar_name} |  awk -F "/" '{print $1}'|tail -n  1)
    echo $package_name
}
