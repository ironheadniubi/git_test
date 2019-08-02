--主键约束

它能够唯一确定一张表中的一条记录.也就是通过给某个字段添加约束.
就可以使得该字段不重复且不为空
mysql> create table user(
    -> id int primary key,
    -> name varchar(20)
    -> );
Query OK, 0 rows affected (0.00 sec)

mysql> describe user;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)


mysql> insert user values(1,'Cto');
Query OK, 1 row affected (0.00 sec)

mysql> insert user values(1,'Cto');
ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'

mysql> insert user values(2,'Cto');
Query OK, 1 row affected (0.00 sec)

mysql> select *from user;
+----+------+
| id | name |
+----+------+
|  1 | Cto  |
|  2 | Cto  |
+----+------+
2 rows in set (0.00 sec)

mysql> insert user values(NULL,'Cto');
ERROR 1048 (23000): Column 'id' cannot be null

-------------------------------------------------

create table user2(
	id int,
	name varchar(20),
	password varchar(20),
	primary key(id,name)
);
-- 联合主键,只要主键值加起来不冲突就可以插入进去,联合主键任何一个字段都不能为空.
imysql> insert into user2 values(1,'张三','123');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user2 values(1,'张三','123');
ERROR 1062 (23000): Duplicate entry '1-张三' for key 'PRIMARY'

mysql> insert into user2 values(2,'张三','123');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user2 values(1,'李四','123');
Query OK, 1 row affected (0.00 sec)



--自增约束
create table user3(
	id int primary key auto_increment,
	name varchar(20)
);

mysql> insert into user3 (name) values('zhangsan');
Query OK, 1 row affected (0.00 sec)


mysql> insert into user3 (name) values('zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> select *from user3;
+----+----------+
| id | name     |
+----+----------+
|  1 | zhangsan |
|  2 | zhangsan |
+----+----------+
2 rows in set (0.00 sec)

--如果我们创建表的时候,忘记创建主键约束,怎么办?

 create table user4(
	id int,
	name varchar(20)
);
-- 修改表结构,添加主键
mysql> alter table user4 add primary key(id);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user4;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)


--如何删除使用drop


mysql> alter table user4 drop primary key;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

-- 使用modify 修改字段,添加约束

 mysql> alter table user4 modify id int primary key;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user4; 
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)



--外键约束
--设计到两个表:父表,子表
--主表,副表


-- 班级

create table classes(
	id int primary key,
	name varchar(20)
);

-- 学生表
create table students(
	id int primary key,
	name varchar(20),
	class_id int,
	foreign key(class_id) references classes(id) 
);

mysql> desc classes;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | NO   | PRI | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)

mysql> desc students;
+----------+-------------+------+-----+---------+-------+
| Field    | Type        | Null | Key | Default | Extra |
+----------+-------------+------+-----+---------+-------+
| id       | int(11)     | NO   | PRI | NULL    |       |
| name     | varchar(20) | YES  |     | NULL    |       |
| class_id | int(11)     | YES  | MUL | NULL    |       |
+----------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)


--插入数据
insert into students values(1001,'zhangsan',1);
insert into students values(1002,'zhangsan',2);
insert into students values(1003,'zhangsan',3);
insert into students values(1004,'zhangsan',4);
insert into students values(1005,'lisi',5);

mysql> insert into students values(1005,'lisi',5);
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))
mysql>


delete from classes where id=4;

mysql> delete from classes where id=4;
ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`test`.`students`, CONSTRAINT `students_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`))

--主表classes 中没有的数据值,在副表中,是不可以使用的.
--主表中的记录被副表引用,是不可以不删除的.




insert into classes values(1,'一班');
insert into classes values(2,'二班');
insert into classes values(3,'三班');
insert into classes values(4,'四班');


mysql> select *from classes;
+----+--------+
| id | name   |
+----+--------+
|  1 | 一班   |
|  2 | 二班   |
|  3 | 三班   |
|  4 | 四班   |
+----+--------+
4 rows in set (0.00 sec)

mysql> select *from students;
+------+----------+----------+
| id   | name     | class_id |
+------+----------+----------+
| 1001 | zhangsan |        1 |
| 1002 | zhangsan |        2 |
| 1003 | zhangsan |        3 |
| 1004 | zhangsan |        4 |
+------+----------+----------+
4 rows in set (0.00 sec)


--唯一约束
--约束修饰的字段的值不可以重复

create table user5(
	id int,
	name varchar(20)
);

mysql> alter table user5 add unique(name);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user5;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)


mysql> insert into user5 values(1,'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user5 values(1,'zhangsan');
ERROR 1062 (23000): Duplicate entry 'zhangsan' for key 'name'

mysql> insert into user5 values(1,'lisi');
Query OK, 1 row affected (0.00 sec)


create table user6(
	id int,
	name varchar(20),
	unique(name)
);

create table user7(
	id int,
	name varchar(20) unique
);

create table user8(
	id int,
	name varchar(20),
	unique(id,name)
);
-- 两个键在一起不重复就行
mysql> insert into user8 values(1,'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user8 values(2,'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> insert into user8 values(1,'lisi');
Query OK, 1 row affected (0.00 sec)



--如何删除唯一约束?
alter table user7 drop index name;


mysql> alter table user7 drop index name;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)

-- 通过modify添加

alter table user7 modify name varchar(20) unique;


mysql> alter table user7 modify name varchar(20) unique;
Query OK, 0 rows affected (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 0

mysql> desc user7;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  | UNI | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)


-- 总结:

-- 1建表的时候就添加约束
-- 2可以使用alter...add....
-- 3 alter....modify....


-- 4 删除 alter...drop....





--非空约束
--修饰的字段不能为空NULL


create table user9(
	id int,
	name varchar(20) not null
);



mysql> create table user9(
    -> id int,
    -> name varchar(20) not null
    -> );
Query OK, 0 rows affected (0.00 sec)

mysql> desc user9;

+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | NO   |     | NULL    |       |
+-------+-------------+------+-----+---------+-------+
2 rows in set (0.01 sec)


insert into user9 (id) values(1);

mysql> insert into user9 (id) values(1);

ERROR 1364 (HY000): dont have a default value.

insert into user9 values(1,'zhangsan');

mysql> insert into user9 values(1,'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> select *from user9;

+------+----------+
| id   | name     |
+------+----------+
|    1 | zhangsan |
+------+----------+
1 row in set (0.00 sec)


insert into user9 (name) values('lisi');

mysql> insert into user9 (name) values('lisi');
Query OK, 1 row affected (0.00 sec)

mysql> select *from user9;
+------+----------+
| id   | name     |
+------+----------+
|    1 | zhangsan |
| NULL | lisi     |
+------+----------+
2 rows in set (0.00 sec)



--默认约束
--当我们插入字段值的时候,如果没有传值,就使用默认值


create table user10(
	id int,
	name varchar(20),
	age int default 10
);

mysql> create table user10(
    -> id int,
    -> name varchar(20),
    -> age int default 10
    -> );
Query OK, 0 rows affected (0.00 sec)

mysql> desc user10;
+-------+-------------+------+-----+---------+-------+
| Field | Type        | Null | Key | Default | Extra |
+-------+-------------+------+-----+---------+-------+
| id    | int(11)     | YES  |     | NULL    |       |
| name  | varchar(20) | YES  |     | NULL    |       |
| age   | int(11)     | YES  |     | 10      |       |
+-------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

-------
insert user10(id,name) values(1,'zhangsan'); 

mysql> insert user10(id,name) values(1,'zhangsan');
Query OK, 1 row affected (0.00 sec)

mysql> select *from user10;
+------+----------+------+
| id   | name     | age  |
+------+----------+------+
|    1 | zhangsan |   10 |
+------+----------+------+
1 row in set (0.00 sec)
------



insert user10 values(1,'zhangsan',20); 


mysql> insert user10 values(1,'zhangsan',20);
Query OK, 1 row affected (0.00 sec)

mysql> select *from user10;
+------+----------+------+
| id   | name     | age  |
+------+----------+------+
|    1 | zhangsan |   10 |
|    1 | zhangsan |   20 |
+------+----------+------+
2 rows in set (0.00 sec)






