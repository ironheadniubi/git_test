-- mysql 学习笔记

-- 关系型数据库

-- 一、如何使用终端操作数据库
-- 1.如何登陆数据库服务器？
mysql -u root -pzxc123zxc

-- 2.如何查询数据库服务器中所有的数据库
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| test               |
+--------------------+
5 rows in set (0.00 sec)



-- 3.如何选中某个数据库进行操作
 mysql> use test;
Database changed


-- SQL 语句中的查询

mysql> select * from test_increment;
+----+-----------+
| ID | TEST_NAME |
+----+-----------+
|  1 | FRED      |
|  2 | JOE       |
|  3 | MIKE      |
|  4 | TED       |
+----+-----------+
4 rows in set (0.00 sec)



mysql> select * from test_increment where id=1;
+----+-----------+
| ID | TEST_NAME |
+----+-----------+
|  1 | FRED      |
+----+-----------+
1 row in set (0.00 sec)


--如何退出数据库服务器？

mysql> exit;
Bye


-- 如何在数据库服务器中创建我们的数据库？


mysql> CREATE Database sushe;
Query OK, 1 row affected (0.01 sec)

mysql> use sushe;
Database changed


--如何查看某个数据库中的所有数据表？
mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| EMPLOYEE_TBL   |
| TEST_INCREMENT |
+----------------+
2 rows in set (0.00 sec)

-- 如何创建一个数据表？
mysql> CREATE TABLE pet(
    -> name VARCHAR(20),
    -> owner VARCHAR(20),
    -> species VARCHAR(20),
    -> sex CHAR(1),
    -> birth DATE,
    -> death DATE);
Query OK, 0 rows affected (0.01 sec)

-- 查看数据表是否创建成功
mysql> show tables;
+----------------+
| Tables_in_test |
+----------------+
| EMPLOYEE_TBL   |
| pet            |
| TEST_INCREMENT |
+----------------+
3 rows in set (0.00 sec)


--查看创建好的数据表的结构

mysql> describe pet;
+---------+-------------+------+-----+---------+-------+
| Field   | Type        | Null | Key | Default | Extra |
+---------+-------------+------+-----+---------+-------+
| name    | varchar(20) | YES  |     | NULL    |       |
| owner   | varchar(20) | YES  |     | NULL    |       |
| species | varchar(20) | YES  |     | NULL    |       |
| sex     | char(1)     | YES  |     | NULL    |       |
| birth   | date        | YES  |     | NULL    |       |
| death   | date        | YES  |     | NULL    |       |
+---------+-------------+------+-----+---------+-------+
6 rows in set (0.00 sec)

-- 如何查看数据表中的记录？
mysql> select *from pet;
Empty set (0.00 sec)

-- 如何往数据表中添加数据记录？
mysql> insert into pet
    -> values('puffball','diane','hamster','f','1998-11-11',NULL);
Query OK, 1 row affected (0.00 sec)

--再一次查询？
mysql> select *from pet;
+----------+-------+---------+------+------------+-------+
| name     | owner | species | sex  | birth      | death |
+----------+-------+---------+------+------------+-------+
| puffball | diane | hamster | f    | 1998-11-11 | NULL  |
+----------+-------+---------+------+------------+-------+
1 row in set (0.00 sec)

 --再一次插入
mysql> insert into pet
    -> values('旺财','周星驰','狗','公','1998-11-11',NULL);
Query OK, 1 row affected (0.00 sec)


--再一次查询
mysql> select *from pet;
+----------+-----------+---------+------+------------+-------+
| name     | owner     | species | sex  | birth      | death |
+----------+-----------+---------+------+------------+-------+
| puffball | diane     | hamster | f    | 1998-11-11 | NULL  |
| 旺财     | 周星驰    | 狗      | 公   | 1998-11-11 | NULL  |
+----------+-----------+---------+------+------------+-------+
2 rows in set (0.00 sec)


-- mysql 常用数据类型有那些?

--MySQL支持多种类型，大致可以分为三类：
mysql> create table testtype(
    -> number TINYINT
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql> INSERT INTO TESTTYPE VALUES (127);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO TESTTYPE VALUES (128);
ERROR 1264 (22003): Out of range value for column 'number' at row 1

--数值、

TINYINT		1 字节	(-128，127)	(0，255)	小整数值
SMALLINT	2 字节	(-32 768，32 767)	(0，65 535)	大整数值
MEDIUMINT	3 字节	(-8 388 608，8 388 607)	(0，16 777 215)	大整数值
INT或INTEGER	4 字节	(-2 147 483 648，2 147 483 647)	(0，4 294 967 295)	大整数值
BIGINT		8 字节	(-9,223,372,036,854,775,808，9 223 372 036 854 775 807)	(0，18 446 744 073 709 551 615)	极大整数值
FLOAT		4 字节	(-3.402 823 466 E+38，-1.175 494 351 E-38)，0，(1.175 494 351 E-38，3.402 823 466 351 E+38)	0，(1.175 494 351 E-38，3.402 823 466 E+38)	单精度
浮点数值
DOUB LE		8 字节	(-1.797 693 134 862 315 7 E+308，-2.225 073 858 507 201 4 E-308)，0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)	0，(2.225 073 858 507 201 4 E-308，1.797 693 134 862 315 7 E+308)	双精度
浮点数值
DECIMAL	对DECIMAL(M,D) ，如果M>D，为M+2否则为D+2	依赖于M和D的值	依赖于M和D的值	小数值

--日期/时间
DATE		3	1000-01-01/9999-12-31	YYYY-MM-DD	日期值
TIME		3	'-838:59:59'/'838:59:59'	HH:MM:SS	时间值或持续时间
YEAR		1	1901/2155	YYYY	年份值
DATETIME	8	1000-01-01 00:00:00/9999-12-31 23:59:59	YYYY-MM-DD HH:MM:SS	混合日期和时间值
TIMESTAMP	4	
1970-01-01 00:00:00/2038
结束时间是第 2147483647 秒，北京时间 2038-1-19 11:14:07，格林尼治时间 2038年1月19日 凌晨 03:14:07
--字符串(字符)类型。
 
CHAR		0-255字节			定长字符串
VARCHAR		0-65535 字节			变长字符串
TINYBLOB	0-255字节			不超过 255 个字符的二进制字符串
TINYTEXT	0-255字节			短文本字符串
BLOB		0-65 535字节			二进制形式的长文本数据
TEXT		0-65 535字节			长文本数据
MEDIUMBLOB	0-16 777 215字节		二进制形式的中等长度文本数据
MEDIUMTEXT	0-16 777 215字节		中等长度文本数据
LONGBLOB	0-4 294 967 295字节	二进制形式的极大文本数据
LONGTEXT	0-4 294 967 295字节	极大文本数据

-- 数据类型如何选择?
日期 选择按照格式!
数值和字符串按照大小!



--如何删除数据?

mysql> delete from pet where name='旺财';
Query OK, 1 row affected (0.00 sec)

--如何修改数据?

mysql> update pet set name="Cto" where owner='Ssl';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

--总结:数据记录常见操作?

--增加
insert
--删除
delete
--修改
update
--查询
select






















-- 二、如何使用可视化工具操作数据库

-- 三、如何在编程语言中操作数据库





































