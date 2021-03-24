/*1.여기서부터*/
drop table jg_comment;
drop table jg_board;
drop table jg_member;
drop table jg_book;
drop table jg_department;
drop table jg_major;

drop sequence seq_board;
drop sequence seq_comment;
/*2.여기까지 먼저 실행해주세요*/

/*3.그 다음 여기서부터 드래그 후 실행 시켜주세요*/
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
values ('m01', '경영대학');
insert into jg_major
values ('m02', '인문대학');
insert into jg_major
values ('m03', '이과대학');

insert into jg_department
values ('d01', '경영학과','m01');
insert into jg_department
values ('d02', '경제학과','m01');
insert into jg_department
values ('d03', '국제통상학과','m01');
insert into jg_department
values ('d04', '문헌정보학과','m02');
insert into jg_department
values ('d05', '중앙아시아학과','m02');
insert into jg_department
values ('d06', '컴퓨터공학과','m03');
insert into jg_department
values ('d07', '전자공학과','m03');

insert into jg_book
values ('b01', '스마트 경영과학','d01');
insert into jg_book
values ('b02', '글로벌상거래관리','d01');
insert into jg_book
values ('b03', '고용관계론','d01');
insert into jg_book
values ('b04', '시장지향적 비즈니스 마케팅 전략 3rd ed.','d01');
insert into jg_book
values ('b05', '관리회계','d01');

insert into jg_book
values ('b06', '경영전략과 경영경제학','d02');
insert into jg_book
values ('b07', '글로벌경제상식사전','d02');
insert into jg_book
values ('b08', '우리나라의 금융시장','d02');
insert into jg_book
values ('b09', '재정학','d02');
insert into jg_book
values ('b10', '투자가를 위한 알기 쉬운 증권경제론','d02');

insert into jg_book
values ('b11', '핵심 국제경제학 3판','d03');
insert into jg_book
values ('b12', '사례중심경영학원론','d03');
insert into jg_book
values ('b13', '해외시장진출방식의 이해','d03');
insert into jg_book
values ('b14', '개정판 전자무역','d03');
insert into jg_book
values ('b15', '국제통상정책론','d03');

insert into jg_book
values ('b16', 'IT CookBook','d04');
insert into jg_book
values ('b17', '디지털시대의 정보표현과 검색','d04');
insert into jg_book
values ('b18', 'Marcia Zeng and Jin Qin. (2016). Metadata. 2nd Edition','d04');
insert into jg_book
values ('b19', '자료목록법 제6판','d04');
insert into jg_book
values ('b20', '장서관리론','d04');

insert into jg_book
values ('b21', '아틀라스 중앙유라시아사','d05');
insert into jg_book
values ('b22', '러시아어의 첫걸음의 모든것','d05');
insert into jg_book
values ('b23', '카라마조프가의 형제들','d05');
insert into jg_book
values ('b24', '초급카작어','d05');
insert into jg_book
values ('b25', '러시아로 가는 길','d05');

insert into jg_book
values ('b26', '정보보안개론','d06');
insert into jg_book
values ('b27', '엑셀을 이용한 통계자료뷴석 손에 잡히는 기초통계학','d06');
insert into jg_book
values ('b28', '앨리스를 이용한 프로그래밍의 학습','d06');
insert into jg_book
values ('b29', '오픈 소스 소프트웨어로 실습하는 소프트웨어 공학','d06');
insert into jg_book
values ('b30', '데이터통신과 네트워킹','d06');

insert into jg_book
values ('b31', 'CDMA 이동통신공학','d07');
insert into jg_book
values ('b32', 'RF 및 초고주파공학','d07');
insert into jg_book
values ('b33', '아날로그 및 디지털 통신이론','d07');
insert into jg_book
values ('b34', '기초전기전자공학실험','d07');
insert into jg_book
values ('b35', '반도체와 디스플레이공학을 위한 센서공학','d07');

commit;