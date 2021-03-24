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
values ('b01', '����Ʈ �濵����','d01');
insert into jg_book
values ('b02', '�۷ι���ŷ�����','d01');
insert into jg_book
values ('b03', '�������','d01');
insert into jg_book
values ('b04', '���������� ����Ͻ� ������ ���� 3rd ed.','d01');
insert into jg_book
values ('b05', '����ȸ��','d01');

insert into jg_book
values ('b06', '�濵������ �濵������','d02');
insert into jg_book
values ('b07', '�۷ι�������Ļ���','d02');
insert into jg_book
values ('b08', '�츮������ ��������','d02');
insert into jg_book
values ('b09', '������','d02');
insert into jg_book
values ('b10', '���ڰ��� ���� �˱� ���� ���ǰ�����','d02');

insert into jg_book
values ('b11', '�ٽ� ���������� 3��','d03');
insert into jg_book
values ('b12', '����߽ɰ濵�п���','d03');
insert into jg_book
values ('b13', '�ؿܽ����������� ����','d03');
insert into jg_book
values ('b14', '������ ���ڹ���','d03');
insert into jg_book
values ('b15', '���������å��','d03');

insert into jg_book
values ('b16', 'IT CookBook','d04');
insert into jg_book
values ('b17', '�����нô��� ����ǥ���� �˻�','d04');
insert into jg_book
values ('b18', 'Marcia Zeng and Jin Qin. (2016). Metadata. 2nd Edition','d04');
insert into jg_book
values ('b19', '�ڷ��Ϲ� ��6��','d04');
insert into jg_book
values ('b20', '�弭������','d04');

insert into jg_book
values ('b21', '��Ʋ�� �߾�����þƻ�','d05');
insert into jg_book
values ('b22', '���þƾ��� ù������ ����','d05');
insert into jg_book
values ('b23', 'ī���������� ������','d05');
insert into jg_book
values ('b24', '�ʱ�ī�۾�','d05');
insert into jg_book
values ('b25', '���þƷ� ���� ��','d05');

insert into jg_book
values ('b26', '�������Ȱ���','d06');
insert into jg_book
values ('b27', '������ �̿��� ����ڷ�弮 �տ� ������ ���������','d06');
insert into jg_book
values ('b28', '�ٸ����� �̿��� ���α׷����� �н�','d06');
insert into jg_book
values ('b29', '���� �ҽ� ����Ʈ����� �ǽ��ϴ� ����Ʈ���� ����','d06');
insert into jg_book
values ('b30', '��������Ű� ��Ʈ��ŷ','d06');

insert into jg_book
values ('b31', 'CDMA �̵���Ű���','d07');
insert into jg_book
values ('b32', 'RF �� �ʰ����İ���','d07');
insert into jg_book
values ('b33', '�Ƴ��α� �� ������ ����̷�','d07');
insert into jg_book
values ('b34', '�����������ڰ��н���','d07');
insert into jg_book
values ('b35', '�ݵ�ü�� ���÷��̰����� ���� ��������','d07');

commit;