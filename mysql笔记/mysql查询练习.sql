-- mysql查询练习


-- 学生表
-- Student
-- 学号
-- 姓名
-- 性别
-- 出生年月日
-- 所在班级
create table Student(
	sno varchar(20) primary key,
	sname varchar(20) not null,
	ssex varchar(10) not null,
	sbirthday datetime,
	class varchar(20)
);

-- 教师表
-- Teacher
-- 教师编号
-- 教师名字
-- 教师性别
-- 出生年月日
-- 职称
-- 所在部门
create table Teacher(
	tno varchar(20)	primary key,
	tname varchar(20) not null,
	tsex varchar(10) not null,
	tbirthday datetime,
	prof varchar(20) not null,
	depart varchar(20) not null
);

-- 课程表
-- Course
-- 课程号
-- 课程名称
-- 教师编号
create table Course(
	cno varchar(20) primary key,
	cname varchar(20) not null,
	tno varchar(20) not null,
	foreign key(tno) references Teacher(tno)
);


-- 成绩表
-- Score
-- 学号
-- 课程号
-- 成绩
create table Score(
	sno varchar(20) not null,
	cno varchar(20) not null,
	degree decimal,
	foreign key(sno) references Student(sno),
	foreign key(cno) references Course(cno),
	primary key(sno,cno)
);



--往数据表中添加数据
# 添加学生数据

insert into Student values('202','曾华国','男','1997-09-01','95033');
insert into Student values('204','匡明微','男','1975-10-02','95031');
insert into Student values('208','王丽放','女','1976-01-23','95033');
insert into Student values('205','李军则','男','1975-11-11','95033');
insert into Student values('207','王芳停','女','1984-11-21','95031');
insert into Student values('201','陆军句','男','1974-06-02','95031');


# 添加教师表

insert into Teacher values('911','曾是','男','1997-09-01','副教授','计算机系');
insert into Teacher values('912','曾是丹','男','1997-02-01','教授','电子工程系');	
insert into Teacher values('913','旦增尼玛','男','1997-03-05','讲师','出版系');
insert into Teacher values('914','毛不易','男','1997-05-10','助教','计算机系');


# 添加课程表
insert into Course values('3-105','计算机导论','911');
insert into Course values('3-245','计算机图形学','912');
insert into Course values('6-606','数据结构','914');
insert into Course values('3-201','新媒体技术概论','913');

# 添加成绩表
insert into Score values('101','3-105','99');
insert into Score values('101','3-245','98');
insert into Score values('101','3-201','89');
insert into Score values('103','3-105','97');
insert into Score values('103','3-245','93');
insert into Score values('103','3-201','97');
insert into Score values('105','3-105','88');
insert into Score values('107','3-105','44');
insert into Score values('108','3-105','55');
insert into Score values('109','3-105','66');	
insert into Score values('201','3-105','72');
insert into Score values('202','3-105','93');
insert into Score values('204','3-105','52');
insert into Score values('205','3-105','65');
insert into Score values('207','3-105','91');
insert into Score values('208','3-105','88');
insert into Score values('105','3-245','88');
insert into Score values('107','3-245','44');
insert into Score values('108','3-245','55');
insert into Score values('109','3-245','66');	
insert into Score values('201','3-245','72');
insert into Score values('202','3-245','93');
insert into Score values('204','3-245','52');
insert into Score values('205','3-245','65');
insert into Score values('207','3-245','91');
insert into Score values('208','3-245','88');

--查询练习?

-- 1. 查询student表里面的所有记录
-- *号表示所有字段
mysql> Select *from student;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1975-11-11 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-02 00:00:00 | 95031 |
| 105 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1997-09-01 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1984-11-21 00:00:00 | 95031 |
| 201 | 陆军句    | 男   | 1974-06-02 00:00:00 | 95031 |
| 202 | 曾华国    | 男   | 1997-09-01 00:00:00 | 95033 |
| 204 | 匡明微    | 男   | 1975-10-02 00:00:00 | 95031 |
| 205 | 李军则    | 男   | 1975-11-11 00:00:00 | 95033 |
| 207 | 王芳停    | 女   | 1984-11-21 00:00:00 | 95031 |
| 208 | 王丽放    | 女   | 1976-01-23 00:00:00 | 95033 |
+-----+-----------+------+---------------------+-------+
12 rows in set (0.00 sec)


-- 2.查询student表中的所有记录的sname ssex class列
mysql> select sname,ssex,class from student;
+-----------+------+-------+
| sname     | ssex | class |
+-----------+------+-------+
| 李军      | 男   | 95033 |
| 陆军      | 男   | 95031 |
| 匡明      | 男   | 95031 |
| 王丽      | 女   | 95033 |
| 曾华      | 男   | 95033 |
| 王芳      | 女   | 95031 |
| 陆军句    | 男   | 95031 |
| 曾华国    | 男   | 95033 |
| 匡明微    | 男   | 95031 |
| 李军则    | 男   | 95033 |
| 王芳停    | 女   | 95031 |
| 王丽放    | 女   | 95033 |
+-----------+------+-------+
12 rows in set (0.00 sec)

-- 3.查询教师所有的单位及不重复的depart列

mysql> select depart from Teacher;
+-----------------+
| depart          |
+-----------------+
| 计算机系        |
| 电子工程系      |
| 出版系          |
| 计算机系        |
+-----------------+
4 rows in set (0.00 sec)
 
-- distinct 去重
mysql> Select distinct depart from Teacher;
+-----------------+
| depart          |
+-----------------+
| 计算机系        |
| 电子工程系      |
| 出版系          |
+-----------------+
3 rows in set (0.00 sec)


-- 4.查询score成绩在60到80之间的的所有记录
-- 查询区间 between...and....

mysql> Select *from score where degree between 60 and 80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 109 | 3-105 |     66 |
| 109 | 3-245 |     66 |
| 201 | 3-105 |     72 |
| 201 | 3-245 |     72 |
| 205 | 3-105 |     65 |
| 205 | 3-245 |     65 |
+-----+-------+--------+
6 rows in set (0.00 sec)

-- 直接使用运算符比较
mysql> Select *from score where degree>60 and degree<80;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 109 | 3-105 |     66 |
| 109 | 3-245 |     66 |
| 201 | 3-105 |     72 |
| 201 | 3-245 |     72 |
| 205 | 3-105 |     65 |
| 205 | 3-245 |     65 |
+-----+-------+--------+
6 rows in set (0.00 sec)

-- 5.查询score 表中成绩为85 ,86 或88;


mysql> Select *from score where degree in(85,86,88);
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 105 | 3-105 |     88 |
| 105 | 3-245 |     88 |
| 208 | 3-105 |     88 |
| 208 | 3-245 |     88 |
+-----+-------+--------+
4 rows in set (0.00 sec)


-- 6. 查询student表中"95031"班或性别为女的同学的记录

Select *from student where class='95031' or ssex='女';
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 103 | 陆军      | 男   | 1974-06-02 00:00:00 | 95031 |
| 105 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 109 | 王芳      | 女   | 1984-11-21 00:00:00 | 95031 |
| 201 | 陆军句    | 男   | 1974-06-02 00:00:00 | 95031 |
| 204 | 匡明微    | 男   | 1975-10-02 00:00:00 | 95031 |
| 207 | 王芳停    | 女   | 1984-11-21 00:00:00 | 95031 |
| 208 | 王丽放    | 女   | 1976-01-23 00:00:00 | 95033 |
+-----+-----------+------+---------------------+-------+


-- 7.以class降序查询student表中的所有记录
-- 升序,降序
降序desc 升序asc
Select *from Student order by class asc;
默认为升序

Select *from Student order by class desc;
mysql> Select *from Student order by class desc;
+-----+-----------+------+---------------------+-------+
| sno | sname     | ssex | sbirthday           | class |
+-----+-----------+------+---------------------+-------+
| 101 | 李军      | 男   | 1975-11-11 00:00:00 | 95033 |
| 107 | 王丽      | 女   | 1976-01-23 00:00:00 | 95033 |
| 108 | 曾华      | 男   | 1997-09-01 00:00:00 | 95033 |
| 202 | 曾华国    | 男   | 1997-09-01 00:00:00 | 95033 |
| 205 | 李军则    | 男   | 1975-11-11 00:00:00 | 95033 |
| 208 | 王丽放    | 女   | 1976-01-23 00:00:00 | 95033 |
| 103 | 陆军      | 男   | 1974-06-02 00:00:00 | 95031 |
| 105 | 匡明      | 男   | 1975-10-02 00:00:00 | 95031 |
| 109 | 王芳      | 女   | 1984-11-21 00:00:00 | 95031 |
| 201 | 陆军句    | 男   | 1974-06-02 00:00:00 | 95031 |
| 204 | 匡明微    | 男   | 1975-10-02 00:00:00 | 95031 |
| 207 | 王芳停    | 女   | 1984-11-21 00:00:00 | 95031 |
+-----+-----------+------+---------------------+-------+

-- 8.以cno升序,degree降序查询score表中的所有记录

mysql> Select *from score order by cno asc,degree desc;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     99 |
| 103 | 3-105 |     97 |
| 202 | 3-105 |     93 |
| 207 | 3-105 |     91 |
| 105 | 3-105 |     88 |
| 208 | 3-105 |     88 |
| 201 | 3-105 |     72 |
| 109 | 3-105 |     66 |
| 205 | 3-105 |     65 |
| 108 | 3-105 |     55 |
| 204 | 3-105 |     52 |
| 107 | 3-105 |     44 |
| 103 | 3-201 |     97 |
| 101 | 3-201 |     89 |
| 101 | 3-245 |     98 |
| 103 | 3-245 |     93 |
| 202 | 3-245 |     93 |
| 207 | 3-245 |     91 |
| 105 | 3-245 |     88 |
| 208 | 3-245 |     88 |
| 201 | 3-245 |     72 |
| 109 | 3-245 |     66 |
| 205 | 3-245 |     65 |
| 108 | 3-245 |     55 |
| 204 | 3-245 |     52 |
| 107 | 3-245 |     44 |
+-----+-------+--------+
26 rows in set (0.00 sec)


-- 9.查询95031班的人数 

mysql> select count(*) from student where class='95031';
+----------+
| count(*) |
+----------+
|        6 |
+----------+
1 row in set (0.00 sec)
-- 10. 查询score表中最高分的学生学号和课程号

mysql> Select sno,cno from score where degree=(Select max(degree) from score);
+-----+-------+
| sno | cno   |
+-----+-------+
| 101 | 3-105 |
+-----+-------+
1 row in set (0.00 sec)
-- 找到最高分
select max(degree) from score;

-- 找最高分的sno 和 cno

select sno,cno from score where degree=(select max(degree) from score;)


-- 排序的做法
-- limit 第一个数字表示从多少开始,第二个数字表示查多少.
mysql> select sno,cno from score order by degree desc limit 0,1;
+-----+-------+
| sno | cno   |
+-----+-------+
| 101 | 3-105 |
+-----+-------+
1 row in set (0.01 sec)

mysql> select sno,cno from score order by degree desc limit 0,2;
+-----+-------+
| sno | cno   |
+-----+-------+
| 101 | 3-105 |
| 101 | 3-245 |
+-----+-------+
2 rows in set (0.00 sec)

-- 查询每门课的平均成绩

mysql> select *from course;
+-------+-----------------------+-----+
| cno   | cname                 | tno |
+-------+-----------------------+-----+
| 3-105 | 计算机导论            | 911 |
| 3-201 | 新媒体技术概论        | 913 |
| 3-245 | 计算机图形学          | 912 |
| 6-606 | 数据结构              | 914 |
+-------+-----------------------+-----+
4 rows in set (0.00 sec)


--avg()
-- 查询单科的成绩
mysql> select avg(degree) from score where cno='3-105';
+-------------+
| avg(degree) |
+-------------+
|     75.8333 |
+-------------+
1 row in set (0.00 sec)


-- 写在一个sql语句中

mysql> select cno,avg(degree) from score group by cno;
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     75.8333 |
| 3-201 |     93.0000 |
| 3-245 |     75.4167 |
+-------+-------------+
3 rows in set (0.00 sec)


-- 12.查询score表中至少有两名学生选修并以3开头的课程的平均分数


mysql> select cno ,avg(degree) from score group by cno having count(cno)>=2 and cno like '3%';
+-------+-------------+
| cno   | avg(degree) |
+-------+-------------+
| 3-105 |     75.8333 |
| 3-201 |     93.0000 |
| 3-245 |     75.4167 |
+-------+-------------+
3 rows in set (0.00 sec)

-- 查询分数大于70,小于90的sno列

mysql> select sno,degree from score where degree>70 and degree<90;
+-----+--------+
| sno | degree |
+-----+--------+
| 101 |     89 |
| 105 |     88 |
| 105 |     88 |
| 201 |     72 |
| 201 |     72 |
| 208 |     88 |
| 208 |     88 |
+-----+--------+
7 rows in set (0.00 sec)

mysql> select sno,degree from score where degree between 70 and 90;
+-----+--------+
| sno | degree |
+-----+--------+
| 101 |     89 |
| 105 |     88 |
| 105 |     88 |
| 201 |     72 |
| 201 |     72 |
| 208 |     88 |
| 208 |     88 |
+-----+--------+
7 rows in set (0.00 sec)

-- 多表查询
-- 查询所有学生的sname,cno 和degree列

mysql> select sno,sname from student;
+-----+-----------+
| sno | sname     |
+-----+-----------+
| 101 | 李军      |
| 103 | 陆军      |
| 105 | 匡明      |
| 107 | 王丽      |
| 108 | 曾华      |
| 109 | 王芳      |
| 201 | 陆军句    |
| 202 | 曾华国    |
| 204 | 匡明微    |
| 205 | 李军则    |
| 207 | 王芳停    |
| 208 | 王丽放    |
+-----+-----------+
12 rows in set (0.00 sec)


mysql> select sno,cno,degree from score;
+-----+-------+--------+
| sno | cno   | degree |
+-----+-------+--------+
| 101 | 3-105 |     99 |
| 101 | 3-201 |     89 |
| 101 | 3-245 |     98 |
| 103 | 3-105 |     97 |
| 103 | 3-201 |     97 |
| 103 | 3-245 |     93 |
| 105 | 3-105 |     88 |
| 105 | 3-245 |     88 |
| 107 | 3-105 |     44 |
| 107 | 3-245 |     44 |
| 108 | 3-105 |     55 |
| 108 | 3-245 |     55 |
| 109 | 3-105 |     66 |
| 109 | 3-245 |     66 |
| 201 | 3-105 |     72 |
| 201 | 3-245 |     72 |
| 202 | 3-105 |     93 |
| 202 | 3-245 |     93 |
| 204 | 3-105 |     52 |
| 204 | 3-245 |     52 |
| 205 | 3-105 |     65 |
| 205 | 3-245 |     65 |
| 207 | 3-105 |     91 |
| 207 | 3-245 |     91 |
| 208 | 3-105 |     88 |
| 208 | 3-245 |     88 |
+-----+-------+--------+
26 rows in set (0.00 sec)


mysql> select sname,cno,degree from student,score where student.sno=score.sno;
+-----------+-------+--------+
| sname     | cno   | degree |
+-----------+-------+--------+
| 李军      | 3-105 |     99 |
| 李军      | 3-201 |     89 |
| 李军      | 3-245 |     98 |
| 陆军      | 3-105 |     97 |
| 陆军      | 3-201 |     97 |
| 陆军      | 3-245 |     93 |
| 匡明      | 3-105 |     88 |
| 匡明      | 3-245 |     88 |
| 王丽      | 3-105 |     44 |
| 王丽      | 3-245 |     44 |
| 曾华      | 3-105 |     55 |
| 曾华      | 3-245 |     55 |
| 王芳      | 3-105 |     66 |
| 王芳      | 3-245 |     66 |
| 陆军句    | 3-105 |     72 |
| 陆军句    | 3-245 |     72 |
| 曾华国    | 3-105 |     93 |
| 曾华国    | 3-245 |     93 |
| 匡明微    | 3-105 |     52 |
| 匡明微    | 3-245 |     52 |
| 李军则    | 3-105 |     65 |
| 李军则    | 3-245 |     65 |
| 王芳停    | 3-105 |     91 |
| 王芳停    | 3-245 |     91 |
| 王丽放    | 3-105 |     88 |
| 王丽放    | 3-245 |     88 |
+-----------+-------+--------+
26 rows in set (0.00 sec)


-- 15.查询所有学生的sno,cname和degree列
mysql> select cno,cname from course;
+-------+-----------------------+
| cno   | cname                 |
+-------+-----------------------+
| 3-105 | 计算机导论            |
| 3-201 | 新媒体技术概论        |
| 3-245 | 计算机图形学          |
| 6-606 | 数据结构              |
+-------+-----------------------+
4 rows in set (0.00 sec)

mysql> select cno,sno,degree from score;
+-------+-----+--------+
| cno   | sno | degree |
+-------+-----+--------+
| 3-105 | 101 |     99 |
| 3-201 | 101 |     89 |
| 3-245 | 101 |     98 |
| 3-105 | 103 |     97 |
| 3-201 | 103 |     97 |
| 3-245 | 103 |     93 |
| 3-105 | 105 |     88 |
| 3-245 | 105 |     88 |
| 3-105 | 107 |     44 |
| 3-245 | 107 |     44 |
| 3-105 | 108 |     55 |
| 3-245 | 108 |     55 |
| 3-105 | 109 |     66 |
| 3-245 | 109 |     66 |
| 3-105 | 201 |     72 |
| 3-245 | 201 |     72 |
| 3-105 | 202 |     93 |
| 3-245 | 202 |     93 |
| 3-105 | 204 |     52 |
| 3-245 | 204 |     52 |
| 3-105 | 205 |     65 |
| 3-245 | 205 |     65 |
| 3-105 | 207 |     91 |
| 3-245 | 207 |     91 |
| 3-105 | 208 |     88 |
| 3-245 | 208 |     88 |
+-------+-----+--------+
26 rows in set (0.00 sec)


mysql> select sno,cname,degree from course,score where course.cno = score.cno;
+-----+-----------------------+--------+
| sno | cname                 | degree |
+-----+-----------------------+--------+
| 101 | 计算机导论            |     99 |
| 103 | 计算机导论            |     97 |
| 105 | 计算机导论            |     88 |
| 107 | 计算机导论            |     44 |
| 108 | 计算机导论            |     55 |
| 109 | 计算机导论            |     66 |
| 201 | 计算机导论            |     72 |
| 202 | 计算机导论            |     93 |
| 204 | 计算机导论            |     52 |
| 205 | 计算机导论            |     65 |
| 207 | 计算机导论            |     91 |
| 208 | 计算机导论            |     88 |
| 101 | 新媒体技术概论        |     89 |
| 103 | 新媒体技术概论        |     97 |
| 101 | 计算机图形学          |     98 |
| 103 | 计算机图形学          |     93 |
| 105 | 计算机图形学          |     88 |
| 107 | 计算机图形学          |     44 |
| 108 | 计算机图形学          |     55 |
| 109 | 计算机图形学          |     66 |
| 201 | 计算机图形学          |     72 |
| 202 | 计算机图形学          |     93 |
| 204 | 计算机图形学          |     52 |
| 205 | 计算机图形学          |     65 |
| 207 | 计算机图形学          |     91 |
| 208 | 计算机图形学          |     88 |
+-----+-----------------------+--------+
26 rows in set (0.00 sec)


-- 16 查询所有学生的sname,cname,degree

--sname -> student
--cname -> coures
--degree ->score


mysql> select sname,cname,degree from student,course,score
    -> where student.sno=score.sno and course.cno=score.cno;
+-----------+-----------------------+--------+
| sname     | cname                 | degree |
+-----------+-----------------------+--------+
| 李军      | 计算机导论            |     99 |
| 陆军      | 计算机导论            |     97 |
| 匡明      | 计算机导论            |     88 |
| 王丽      | 计算机导论            |     44 |
| 曾华      | 计算机导论            |     55 |
| 王芳      | 计算机导论            |     66 |
| 陆军句    | 计算机导论            |     72 |
| 曾华国    | 计算机导论            |     93 |
| 匡明微    | 计算机导论            |     52 |
| 李军则    | 计算机导论            |     65 |
| 王芳停    | 计算机导论            |     91 |
| 王丽放    | 计算机导论            |     88 |
| 李军      | 新媒体技术概论        |     89 |
| 陆军      | 新媒体技术概论        |     97 |
| 李军      | 计算机图形学          |     98 |
| 陆军      | 计算机图形学          |     93 |
| 匡明      | 计算机图形学          |     88 |
| 王丽      | 计算机图形学          |     44 |
| 曾华      | 计算机图形学          |     55 |
| 王芳      | 计算机图形学          |     66 |
| 陆军句    | 计算机图形学          |     72 |
| 曾华国    | 计算机图形学          |     93 |
| 匡明微    | 计算机图形学          |     52 |
| 李军则    | 计算机图形学          |     65 |
| 王芳停    | 计算机图形学          |     91 |
| 王丽放    | 计算机图形学          |     88 |
+-----------+-----------------------+--------+


-- 17.查询''




