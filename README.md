# shell_tool
积累一些常见的shell脚本工具

1、发现指定目录下的死链接 <a href="https://github.com/maweibinguo/shell_tool/blob/master/broken_link.sh">broken_link.sh</a>

[ 功能说明 ] 

发现指定目录下的死链接，并将该死连接记录到当前运行脚本的dead_link.log文件中

[ 具体用法 ] 

./broken_link.sh dir1 dir2 dir3 ... , 这里的目录链接需要时绝对链接。

[ 举例说明 ]

./broken_link.sh /usr/local /var/data
