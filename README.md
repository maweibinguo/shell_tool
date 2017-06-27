# shell脚本工具箱

###工具箱简介
基于自己工作中和学习中的一些经历，将使用到的shell脚本进行一个总结。目标是逐渐完善成为一个开箱即用的shell工具集合

#### 1、发现指定目录下的死链接 <a href="https://github.com/maweibinguo/shell_tool/blob/master/broken_link.sh">broken_link.sh</a>
[ 功能说明 ] 

发现指定目录下的死链接，并将该死连接记录到当前运行脚本的dead_link.log文件中

[ 具体用法 ] 

./broken_link.sh dir1 dir2 dir3 ... , 这里的目录链接需要时绝对链接。

[ 举例说明 ]

./broken_link.sh /usr/local /var/data
