#/bin/bash

####################################
#   网络处理函数封装               #
####################################

# 校验网络
function check_network()
{
    lose_rate=$(ping -c www.baidu.com | awk '/packet loss/print $6' | sed -e 's/%//')
    if [ $lose_rate -ne 0 ]; then
        echo "The Network Is Wrong"
        exit 1
    fi
}

# 下载文件
function download_to_target_palce()
{
    download_url=$1
    hold_dir=$2
    wget -c -P $hold_dir  $download_url
}
