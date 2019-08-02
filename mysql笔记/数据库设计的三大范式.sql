-- 1.第一范式
--1NF

--数据表中的所有字段都是不可分割的原子值?

create table student2(
	id int primary key,
	name varchar(20),
	address varchar(30)
); 

insert into student2 values(1,'张三','中国上海杨浦1100');
insert into student2 values(2,'王五','中国上海杨浦516');	
insert into student2 values(3,'李四','中国上海杨浦580');

-- 字段值还可以继续拆分的,就不满足第一范式
mysql> select *from student2;
+----+--------+------------------------+
| id | name   | address                |
+----+--------+------------------------+
|  1 | 张三   | 中国上海杨浦1100       |
|  2 | 王五   | 中国上海杨浦516        |
|  3 | 李四   | 中国上海杨浦580        |
+----+--------+------------------------+
3 rows in set (0.00 sec) 



create table student3(
	id int primary key,
	name varchar(20),
	country varchar(30),
	privence varchar(30),
	city varchar(30),
	details  varchar(30)
);

insert into student3 values(1,'张三','中国','上海','杨浦','1100');
insert into student3 values(2,'王五','中国','上海','杨浦','516');	
insert into student2 values(3,'李四','中国','上海','杨浦','580');



mysql> select *from student3;
+----+--------+---------+----------+--------+---------+
| id | name   | country | privence | city   | details |
+----+--------+---------+----------+--------+---------+
|  1 | 张三   | 中国    | 上海     | 杨浦   | 1100    |
|  2 | 王五   | 中国    | 上海     | 杨浦   | 516     |
|  3 | 李四   | 中国    | 上海     | 杨浦   | 580     |
+----+--------+---------+----------+--------+---------+
3 rows in set (0.00 sec)

--范式,设计的越详细,对于某些实际操作可能更好,但是不一定都是好处.

address->> country | privence | city | details





-- 第二范式

--必须满足第一范式的前提下,第二范式要求,除主键外的每一列都必须完全依赖于主键
--如果要出现不完全依赖,只可能发送在联合主键的情况下


--订单表
country table myorder(
	product_id int,
	customer_id int,
	product_name varchar(20),
	customer_name varchar(20),
	primary key(product_id,customer_id)
);
-- 问题?
-- 除主键以外的其他列,只依赖与主键的部分字段
-- 拆表

create table myorder(
	order_id int primary key,
	product_id  int,
	customer_id int
);

create table product(
	id int primary key,
	name varchar(20)
);


create table customer(
	id int primary key,
	name varchar(20)
);

-- 分成三个表之后,就满足了第二范式设计.


--3第三范式
--必须先满足第二范式,除开主键列的其他列之间不能有穿衣依赖关系.

create table myorder(
	order_id int primary key,
	product_id  int,
	customer_id int
	customer_phone varchar(15)
);
-- 将customer_phone 放到customer的表格里去

create table customer(
	id int primary key,
	name varchar(20)
	phone varchar(15)
);








































































