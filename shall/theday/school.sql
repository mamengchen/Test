create TABLE `student`(
    `s_id` varchar(20),
    `s_name` varchar(20) not null default '',
    `s_birth` varchar(20) not null default '',
    `s_sex` varchar(10) not null default '',
    primary key(`s_id`)
);

create TABLE `course`(
    `c_id` varchar(20),
    `c_name` varchar(20) not null default '',
    `t_id` varchar(20) not null,
    primary key(`c_id`)
);

create TABLE `teacher`(
    `t_id` varchar(20),
    `t_name` varchar(20) not null default '',
    primary key(`t_id`)
);

create TABLE `score`(
    `s_id` varchar(20),
    `c_id` varchar(20),
    `s_score` INT(3),
    primary key(`s_id`,`c_id`)
);


insert into student values('1001','zhaolei','1990-1001-1001','male');
insert into student values('1002','lihang','1990-12-21','male');
insert into student values('1003','yanwen','1990-1005-20','male');
insert into student values('1004','honglei','1990-1006-1006','male');
insert into student values('1005','ligang','1991-12-1001','fmale');
insert into student values('1006','zhousheng','1992-1003-1001','fmale');
insert into student values('1007','wangjun','1989-1007-1001','fmale');
insert into student values('1008','zhoufei','1990-1001-20','fmale');


insert into course values('1001','chinese','1002');
insert into course values('1002','math','1001');
insert into course values('1003','english','1003');


insert into teacher values('1001','aidisheng');
insert into teacher values('1002','aiyinsitan');
insert into teacher values('1003','qiansanqiang');

insert into score values('1001','1001',80);
insert into score values('1001','1002',90);
insert into score values('1001','1003',99);
insert into score values('1002','1001',70);
insert into score values('1002','1002',60);
insert into score values('1002','1003',80);
insert into score values('1003','1001',80);
insert into score values('1003','1002',80);
insert into score values('1003','1003',80);
insert into score values('1004','1001',50);
insert into score values('1004','1002',30);
insert into score values('1004','1003',20);
insert into score values('1005','1001',76);
insert into score values('1005','1002',87);
insert into score values('1006','1001',31);
insert into score values('1006','1003',34);
insert into score values('1007','1002',89);
insert into score values('1007','1003',98);
