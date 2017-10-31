#/bin/bash

####################################
# 字符串处理函数封装               #
####################################

# 将字符串转换为小写
function str_to_lowercase()
{
    local str=$1
    str=$(echo $str|tr '[A-Z]' '[a-z]')
    echo $str
}

# 将字符串转换为大写
function str_to_upercase()
{
    local str=$1
    str=$(echo $str|tr '[a-z]' '[A-Z]')
    echo $str
}
