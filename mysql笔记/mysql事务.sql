 mysql中,事务其实是一个最小的不可分割的工作单元,事务能够保证一个业务的完整性

 比如我们的银行转账:

 	a -> -100
 	update user set money=money-100 where name='a';

 	b -> +100
 	update user set money=money+100 where name='b';

-- 实际的程序中,如果只有一条语句执行成功,而另一条没有执行成功?
-- 出现数据前后不一致


-- 多条sql 语句,可能会有同时成功的要求,要么就同时失败

-- mysql 中如何控制事务?

1.mysql 默认是开启事务的(自动提交)

mysql> select @@autocommit;
+--------------+
| @@autocommit |
+--------------+
|            1 |
+--------------+
1 row in set (0.00 sec)
 	

-- 默认事务开启的作用是什么
-- 当我们执行一个sql语句的时候,效果马上体现出来,且不能回滚

mysql> create database bank;
Query OK, 1 row affected (0.00 sec)d


mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)


-- 事务回滚,撤销sql语句执行效果
rollback;

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)


不可以回滚


-- 设置 mysql 自动提交为false
set autocommit=0;

-- 关闭了mysql的自动提交

insert into user values(2,'b',1000);

-- 回滚效果
mysql> insert into user values(2,'b',1000);
Query OK, 1 row affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
+----+------+-------+
1 row in set (0.00 sec)



-- 不回滚效果

mysql> insert into user values(2,'b',1000);
Query OK, 1 row affected (0.00 sec)

--手动提交数据,事务的持久性

mysql> commit;
Query OK, 0 rows affected (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)


-- 自动提交 ? @@autocommit=1

-- 手动提交  commit

-- 事务回滚 rollback;


-- 如果说这个时候转账:

update user set money=money-100 where name='a';
update user set money=money+100 where name='b';



mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |  1000 |
|  2 | b    |  1000 |
+----+------+-------+
2 rows in set (0.00 sec)

-- 事务给我们提供了一个回退的机会



set autocommit=1;
设置为自动提交


-- 开启自动提交后如何回滚

begin;
-- 或者
start transaction
都可以帮我们手动开启事务



mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   900 |
|  2 | b    |  1100 |
+----+------+-------+
2 rows in set (0.00 sec)

--rollback无效果


begin;
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';




mysql> begin;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)

-- rollback有效果

start transaction;
update user set money=money-100 where name='a';
update user set money=money+100 where name='b';


mysql> start transaction;
Query OK, 0 rows affected (0.00 sec)

mysql> update user set money=money-100 where name='a';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> update user set money=money+100 where name='b';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   700 |
|  2 | b    |  1300 |
+----+------+-------+
2 rows in set (0.00 sec)

mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+------+-------+
| id | name | money |
+----+------+-------+
|  1 | a    |   800 |
|  2 | b    |  1200 |
+----+------+-------+
2 rows in set (0.00 sec)


--有效果rollback


-- commit 之后rollback没有效果

事务的四大特征
ACID
A 原则性: 事务是最小的单位,不可以在分割
C 一致性: 事务要求,同一事务中的sql语句,必须保证同时成功或者同时失败
I 隔离性: 事务1 和 事务2 之间具有隔离性
D 持久性: 事务一旦结束就不可以返回

事务开启: 
	1. 修改默认提交为0 set autocommit=0;
	2. begin; 开启
	3. start transaction;
 
事务手动提交:
	commit;

事务手动回滚:
	rollback;

-- 事务的隔离性

1. read uncommiter; 读未提交的
2. read commited; 读已经提交的
3. repeatable read;	可以重复读
4. serializable; 串行化


1 read uncommitted
如果有事务a,和事务b
a 事务对数据进行操作,在操作过程中,事务没有被提交,但是b可以看见a 的操作结果


insert into user values(3,'小名','1000');
insert into user values(4,'淘宝店','1000');	

mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.00 sec)

-- 如何查看数据库的隔离级别

mysql 8.0:
-- 系统级别
select @@global.transaction_isolation;
-- 会话级别
select @@transaction_isolation;
mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)

mysql 5.x:
-- 系统级别
select @@global.tx_isolation;
-- 会话级别
select @@tx_isolation;


-- 如何修改隔离级别?


set global transaction isolation level read uncommitted;



mysql> set global transaction isolation level read uncommitted;
Query OK, 0 rows affected (0.00 sec)

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-UNCOMMITTED               |
+--------------------------------+
1 row in set (0.00 sec)





-- 转账:小名在淘宝点买鞋子:800 块钱
小名 -> 成都 ATM
淘宝店 -> 广州 ATM

start transaction;
update user set money=money-800 where name='小名';
update user set money=money+800 where name='淘宝店';


mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名       |   200 |
|  4 | 淘宝店     |  1800 |
+----+-----------+-------+
4 rows in set (0.00 sec)

-- 给淘宝店打电话去查账
-- 发货
-- 晚上请女朋友吃好吃的
-- 1800
-- 小名做了rollback;
mysql> rollback;
Query OK, 0 rows affected (0.00 sec)

mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.00 sec)
-- 结账的时候钱不够

update user set money=money+1800 where name='淘宝店';


-- 如果两个不同的地方,都在进行操作,如果事务a开启之后,他的数据可以被其他事务读取到
-- 这样就会出现(脏读)
-- 脏读: 一个事务读到了另外一个事务没有提交的数据
-- 实际开发过程中,不允许脏读



--  read committed ; 读已经提交的

set global transaction isolation level read committed;

select @@global.transaction_isolation;

mysql> select @@global.transaction_isolation;
  
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| READ-COMMITTED                 |
+--------------------------------+
1 row in set (0.00 sec)


小张: 银行的会计

start transaction;
select * from user;
mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
+----+-----------+-------+
4 rows in set (0.00 sec)

小张出去上厕所.. 抽烟



小王:
start transaction;
insert into user values(5,'c',100);
commit;
mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
+----+-----------+-------+
5 rows in set (0.00 sec)






-- 小张回来 算平均数

select avg(money) from user;
mysql> select avg(money) from user;
+------------+
| avg(money) |
+------------+
|   820.0000 |
+------------+
1 row in set (0.00 sec)


-- money 的平均值变少

-- 虽然我能读到另外一个事务提交的数据,但是出现问题
-- 读取同一个表的数据,发现前后数据不一致
-- 不可重复读的现象: read commited


-- repeatable read; 可以重复读

set global transaction isolation level repeatable read;

select @@global.transaction_isolation;

mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| REPEATABLE-READ                |
+--------------------------------+
1 row in set (0.00 sec)


-- 在repeatable read隔离级别下会出现什么问题

select *from user;

mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
+----+-----------+-------+
5 rows in set (0.00 sec)

-- 张全蛋 -> 成都
start transaction;





--王尼玛 -> 北京
start transaction;

-- 张全蛋 -> 成都
insert into user values(7,'f',1000);
commit;

-- 王尼玛

select *from user;

mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
+----+-----------+-------+
6 rows in set (0.00 sec)



insert into user values(7,'f',1000);
mysql> insert into user values(7,'f',1000);
ERROR 1062 (23000): Duplicate entry '7' for key 'PRIMARY'


-- 这种现象就叫做幻读!!

-- 事务a和事务b 同时操作一张表,事务a提交的数据,也不能被事务b读到




-- serializable; 串行化

set global transaction isolation level serializable;
select @@global.transaction_isolation;


mysql> select @@global.transaction_isolation;
+--------------------------------+
| @@global.transaction_isolation |
+--------------------------------+
| SERIALIZABLE                   |
+--------------------------------+
1 row in set (0.00 sec)




--张全蛋 -> 成都

start transaction;

insert into user values('8','赵铁柱','10000');

commit;

select *from user;


+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
|  7 | f         |  1000 |
|  8 | 赵铁柱    | 10000 |
+----+-----------+-------+
8 rows in set (0.00 sec)


-- 王尼玛 -> 北京

start transaction;


select *from user;

mysql> select *from user;
+----+-----------+-------+
| id | name      | money |
+----+-----------+-------+
|  1 | a         |   700 |
|  2 | b         |  1300 |
|  3 | 小名      |  1000 |
|  4 | 淘宝店    |  1000 |
|  5 | c         |   100 |
|  6 | d         |  1000 |
|  7 | f         |  1000 |
|  8 | 赵铁柱    | 10000 |
+----+-----------+-------+
8 rows in set (0.00 sec)

-- 当user 表被另外一个事务操作的时候,其他事务里面的写操作,是不可以进行的.
-- 进入排队状态(串行化),直到王尼玛那边事务结束之后,张全蛋的这个写入操作才可以执行
-- 在没有等待超时的情况下


-- 串行化问题是,性能特差!!!!

-- 性能排行

READ-UNCOMMITTED > READ-COMMITTED > REPEATABLE-READ > SERIALIZABLE


-- 隔离级别越高,性能越差


-- mysql 默认隔离级别是 REPEATABLE-READ





























































