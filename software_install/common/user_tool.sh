#!/bin/bash

####################################
#   用户处理函数封装               #
####################################

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
        touch ${full_step}
        echo 0
   fi
}

function rollback()
{
   local step_name=$1 
   local service_name=`echo ${step_name}|awk -F _ '{print $1}'`
   local step_dir="/tmp/${service_name}/"

   local full_step=${step_dir}${step_name}
   if [ $(file_exists "${full_step}") -eq 1 ]; then
       rm -rf $full_step
   fi
}

function mydos2unix()
{
    if ! `type dos2unix &> /dev/null`; then
        show_title "the dos2unix command is not finded, are you want to install the command? Please entire your choice [ y/n]"
        read answer
        local answer=$(str_to_lowercase $answer)
        case $answer in
            Y|y)
                yum install -y  dos2unix
                ;;
            N|n)
                show_title 'exit success'
                exit
                ;;
            *)
                show_error'your choice is wrong, please enter [y/n]'
                exit
                ;;
        esac
    fi
    $? || show_error "yum install dos2unix failed"

    local file=$1
    if [ -f $file ]; then
        dos2unix $file
    elif [ -d $file ]; then
        for file_name in `find ${file} -type f`; do
            echo $file_name
            dos2unix "${file_name}"
        done
    else
        show_error "${file} is not avaliable a file a directory"
    fi
}
