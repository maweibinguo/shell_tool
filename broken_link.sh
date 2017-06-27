#!/bin/bash
# 寻找制定目录下的死链接,并将路径保存到当前目录下的./dead_link.log文件中
log_file="`pwd`/dead_link.log"

function linkchk()
{
	for element in $1/*; do
		if [ -h "$element" -a ! -e "$element" ] ; then
			echo $element &>> "$log_file"
		elif [ -d "$element" ] ; then
			linkchk "$element"
		fi
	done
}

function startFindLink()
{
	for dir in $@ ; do
		if [ ! -d $dir ] ; then
			echo "${dir} is not a directory"
			echo "Usage: $0 dir1 dir2 ..."
		else
			linkchk $dir $save_file
		fi
	done;
}
startFindLink $@
