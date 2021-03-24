/*1.Please run it from here*/
drop table jg_comment;
drop table jg_board;
drop table jg_member;
drop table jg_book;
drop table jg_department;
drop table jg_major;

drop sequence seq_board;
drop sequence seq_comment;
/*2.to here first.*/

/*3.Then run from here*/
select * from jg_member;
select * from jg_board;
select * from jg_book;
select * from jg_department;
select * from jg_major;
select * from jg_comment order by ref desc, position asc;

create table jg_major (
m_code          varchar(100)     primary key,
m_name          varchar(100)    not null
);

create table jg_department (
dept_code       varchar2(100)   primary key,
dept_name       VARCHAR2(100)   not null,
m_code          varchar2(100),
constraint fk_department_major foreign key (m_code) references jg_major(m_code)
);

create table jg_book (
bk_code	        VARCHAR2(100)	primary key,
bk_title        VARCHAR2(100)	not null,
dept_code       varchar2(100),
constraint fk_book_department foreign key (dept_code) references jg_department(dept_code)
);

create table jg_member (
mb_id	        number          primary key,
mb_name         VARCHAR2(200)	not null,
dept_code       varchar2(100)   not null,
mb_pw           VARCHAR2(200)   not null,
constraint fk_member_department foreign key (dept_code) references jg_department(dept_code)
);

create table jg_board (
br_num	        number          default 0   primary key,
mb_id           number          not null,
br_title        VARCHAR2(100)	not null,
bk_code         VARCHAR2(100),
br_content      varchar2(2000),
br_price        number,
sale_purchase   VARCHAR2(1),
purchase_done   VARCHAR2(1)     default 'X',
hit             number          default 0,
write_date      date            not null,
upFile          varchar2(100),
dept_code       varchar2(100),
constraint fk_board_member foreign key (mb_id) references jg_member(mb_id) on delete cascade,
constraint fk_board_book foreign key (bk_code) references jg_book(bk_code),
constraint fk_board_department foreign key (dept_code) references jg_department(dept_code)
);


create table jg_comment (
br_num	        number          not null,
cm_no           number          default 0   primary key,
mb_id           number          not null,
cm_content      varchar2(1000)  not null,
write_date      date            not null,
secret          varchar2(1)     default 'X',
ref             number          not null,
position        number          default 0,
constraint fk_comment_board foreign key (br_num) references jg_board(br_num) on delete cascade,
constraint fk_comment_member foreign key (mb_id) references jg_member(mb_id) on delete cascade
);

create sequence seq_board
increment by 1
start with 1;

create sequence seq_comment
increment by 1
start with 1;

insert into jg_major
values ('m01', 'College of Business');
insert into jg_major
values ('m02', 'College of Humanities');
insert into jg_major
values ('m03', 'College of Science');

insert into jg_department
values ('d01', 'business department','m01');
insert into jg_department
values ('d02', 'department of economics','m01');
insert into jg_department
values ('d03', 'department of International Trade','m01');
insert into jg_department
values ('d04', 'literary information','m02');
insert into jg_department
values ('d05', 'Central Asian Studies','m02');
insert into jg_department
values ('d06', 'computer engineering','m03');
insert into jg_department
values ('d07', 'electronics','m03');

insert into jg_book
values ('b01', 'smart business science','d01');
insert into jg_book
values ('b02', 'global commerce management','d01');
insert into jg_book
values ('b03', 'employment relationship','d01');
insert into jg_book
values ('b04', 'market-oriented business marketing strategy 3rd ed.','d01');
insert into jg_book
values ('b05', 'Management Accounting','d01');

insert into jg_book
values ('b06', 'Management Strategy and Business Economics','d02');
insert into jg_book
values ('b07', 'Global Economic Common Sense Dictionary','d02');
insert into jg_book
values ('b08', 'our country_s financial markets','d02');
insert into jg_book
values ('b09', 'finance','d02');
insert into jg_book
values ('b10', 'Easy to Know Securities Economy for Investors','d02');

insert into jg_book
values ('b11', 'core international economics 3','d03');
insert into jg_book
values ('b12', 'case-centered management academy theory','d03');
insert into jg_book
values ('b13', 'understanding how to enter overseas markets','d03');
insert into jg_book
values ('b14', 'revised electronic trade','d03');
insert into jg_book
values ('b15', 'International Trade Policy','d03');

insert into jg_book
values ('b16', 'IT CookBook','d04');
insert into jg_book
values ('b17', 'expression and retrieval of information in the digital age','d04');
insert into jg_book
values ('b18', 'Marcia Zeng and Jin Qin. (2016). Metadata. 2nd Edition','d04');
insert into jg_book
values ('b19', '6th Edition of the Data Listing Act','d04');
insert into jg_book
values ('b20', 'the theory of library management','d04');

insert into jg_book
values ('b21', 'Atlas Central Eurasian History','d05');
insert into jg_book
values ('b22', 'everything at the beginning of Russian','d05');
insert into jg_book
values ('b23', 'Karamazov_s brothers','d05');
insert into jg_book
values ('b24', 'beginning kazak','d05');
insert into jg_book
values ('b25', 'the way to Russia','d05');

insert into jg_book
values ('b26', 'Information Security Introduction', 'd06');
insert into jg_book
values ('b27', 'basic statistics in hand using Excel', 'd06');
insert into jg_book
values ('b28', 'learning of programming using alice', 'd06');
insert into jg_book
values ('b29', 'software engineering with open source software', 'd06');
insert into jg_book
values ('b30', 'data communication and networking', 'd06');

insert into jg_book
values ('b31', 'CDMA mobile communication engineering', 'd07');
insert into jg_book
values ('b32', 'RF and ultra-high frequency engineering', 'd07');
insert into jg_book
values ('b33', 'Analog and Digital Communication Theory', 'd07');
insert into jg_book
values ('b34', 'Basic Electrical and Electronic Engineering Experiment', 'd07');
insert into jg_book
values ('b35', 'Sensor Engineering for Semiconductor and Display Engineering', 'd07');

commit;