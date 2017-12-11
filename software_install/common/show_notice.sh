#/bin/bash

####################################
#   错误处理函数封装               #
####################################

# 展示错误
function show_error()
{
    error_message=$1
    echo "========================== [ error] ===================================="
    echo 
    echo $error_message
    echo 
    echo "========================== [ error] ===================================="
}

function is_had_done()
{
   local step_name=$1 
   local service_name=`echo ${step_name}|awk -F _ '{print $1}'`
   local step_dir="/tmp/${service_name}/"

   if [ $(dir_exists "${step_dir}") -eq 0 ]; then
	mkdir -p ${step_dir}
   fi

   local full_step=${step_dir}${step_name}
   if [ $(file_exists "${full_step}") -eq 1 ]; then
        echo 1
   else
        touch ${step_name}
        echo 0
   fi
}

function show_title()
{
    title_message=$1
    echo "========================== [ title ] ===================================="
    echo 
    echo $title_message
    echo 
    echo "========================== [ title ] ===================================="
}
