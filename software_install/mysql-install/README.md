# mysql 服务安装说明

如果没有在找到/root/.mysql_secret登录密码可以按照下面的步骤操作

### 首先修改MySQL授权登录方式---（跳过授权验证方式启动MySQL,记得先关闭mysql服务）：
mysqld_safe --skip-grant-tables &

### 这时登录MySQL不再需要验证
[root@test ~]# mysql

### 成功登录MySQL后：
mysql> use mysql;

mysql> update user set authentication_string=password('设置为你的密码') where user='root';

mysql> flush privileges;

mysql> exit

此时退出重新登录即可
