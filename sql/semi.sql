--============================================
-- 관리자계정
--============================================
-- web계정 생성
--alter session set "_oracle_script" = true; -- c##으로 시작하지 않는 일반계정생성 허용 (MAC  X)

create user semi
identified by semi
default tablespace users;

grant connect, resource to semi;

alter user semi quota unlimited on users;


-------------------------------------------
-- member
-------------------------------------------
CREATE TABLE member (
	member_id	varchar2(20)		NOT NULL,
	password	varchar2(300)		NOT NULL,
	member_name	varchar2(50)		NOT NULL,
	email	varchar2(200)		NOT NULL,
	member_role	char(1)		NOT NULL,
	phone	char(11)		NOT NULL,
	gender	char(1)		NOT NULL,
	birthday	date		NOT NULL,
	enroll_date	date	DEFAULT sysdate	NOT NULL,
    constraint pk_member_id primary key(member_id),
    constraint ck_member_role check(member_role in ('A', 'P', 'D')),
    constraint ck_member_gender check(gender in ('M', 'F')),
    constraint uq_member_email unique(email)
);

COMMENT ON COLUMN member.member_role IS 'A 관리자 P 배우 D 디렉터';
COMMENT ON COLUMN member.gender IS 'F,M';
COMMENT ON COLUMN member.birthday IS 'yyyymmdd';

-------------------------------------------
-- board
-------------------------------------------
CREATE TABLE board (
	no	number	NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	title	varchar2(100)		NOT NULL,
	content	varchar2(4000)		NOT NULL,
	read_count	number	DEFAULT 0	NOT NULL,
	reg_date	date	DEFAULT sysdate	NOT NULL,
    constraint pk_board_no PRIMARY KEY (no),
    constraint fk_board_member_id foreign key(member_id) references member(member_id) on delete set null
);

create sequence seq_board_no;

COMMENT ON COLUMN board.no IS 'seq_board_no';

-------------------------------------------
-- board_attachment
-------------------------------------------
CREATE TABLE board_attachment (
	no	number	NOT NULL,
	board_no	number		NOT NULL,
	original_filename	varchar2(255)		NOT NULL,
	renamed_filename	varchar2(255)		NOT NULL,
	reg_date	date	DEFAULT sysdate	NULL,
    constraint pk_board_attachment_no primary key (no),
    constraint fk_board_attachment_board_no foreign key(board_no) references board(no) on delete cascade
);

create sequence seq_board_attachment_no;

COMMENT ON COLUMN board_attachment.no IS 'seq_attachment_no';
COMMENT ON COLUMN board_attachment.board_no IS 'seq_board_no';

-------------------------------------------
-- board_comment
-------------------------------------------
CREATE TABLE board_comment (
	no	number	NOT NULL,
	board_no	number	NOT NULL,
	member_id	varchar2(20)	NOT NULL,
	comment_ref	number,
	reg_date	date DEFAULT sysdate,
    constraint pk_board_comment_no primary key (no),
    constraint fk_board_comment_board_no foreign key(board_no) references board(no) on delete cascade,
    constraint fk_board_comment_member_id foreign key(member_id) references member(member_id) on delete set null,
    constraint fk_board_comment_ref foreign key(comment_ref) references board_comment(no) on delete cascade
);
create sequence seq_board_comment_no;
COMMENT ON COLUMN board_comment.board_no IS 'seq_board_comment_no';

-------------------------------------------
-- actor_info
-------------------------------------------
CREATE TABLE actor_info (
	member_id	varchar2(20)		NOT NULL,
	actor_no	number	NOT NULL,
	actor_age	number	NOT NULL,
	actor_education	varchar2(50),
	actor_height	number,
	actor_weight	number,
	actor_company	varchar2(100),
	actor_speciality	varchar2(100),
	actor_sns	varchar2(100),
	actor_photo	varchar2(255),
    constraint pk_actor_member_id primary key (member_id),
    constraint fk_actor_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint uq_actor_no unique (actor_no)
);

create sequence seq_actor_info_no;

-------------------------------------------
-- portfolio
-------------------------------------------
CREATE TABLE portfolio (
	portfolio_no	number	NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	work_no	number		NOT NULL,
	period	varchar2(50),
	youtube_url	varchar2(300),
    constraint pk_portfolio_no primary key (portfolio_no),
    constraint fk_portfolio_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_portfolio_work_no foreign key(work_no) references work(work_no) on delete set null
);
create sequence seq_portfolio_no;


-------------------------------------------
-- production 제작사
-------------------------------------------
CREATE TABLE production (
	member_id	varchar2(20)	NOT NULL,
	production_name	varchar2(100)	NOT NULL,
	caster_name	varchar2(50),
	caster_phone	char(11)	NOT NULL,
	caster_email	varchar2(200),
    constraint pk_production_member_id primary key (member_id),
    constraint fk_production_member_id foreign key(member_id) references member(member_id) on delete cascade
);

-------------------------------------------
-- work
-------------------------------------------
CREATE TABLE work (
	work_no	number	NOT NULL,
	work_field	varchar2(30)		NULL,
	title	varchar2(100)		NOT NULL,
	production	varchar2(100)		NOT NULL,
	director	varchar2(30)		NOT NULL,
	description	varchar2(1000),
    constraint pk_work_no primary key (work_no)
);

create sequence seq_work_no;

-------------------------------------------
-- work_attachment
-------------------------------------------
CREATE TABLE work_attachment (
	work_attachment_no	number	NOT NULL,
	work_no	number		NOT NULL,
	original_filename	varchar2(300)		NULL,
	renamed_filename	varchar2(300)		NULL,
	reg_date	date	DEFAULT sysdate	NULL,
    constraint pk_work_attachment_no primary key (work_attachment_no),
    constraint fk_work_no foreign key(work_no) references work(work_no) on delete cascade
);
create sequence seq_work_attachment_no;

-------------------------------------------
-- announcement
-------------------------------------------
CREATE TABLE announcement (
	ann_no	number	NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	work_no	number		NOT NULL,
	ann_area	varchar(50)		NULL,
	ann_end_date	date		NOT NULL,
	ann_reg_date	date	DEFAULT sysdate	NOT NULL,
	ann_pay	number		NULL,
	ann_gender	char(1)		NULL,
	ann_age	number		NULL,
	ann_height	number		NULL,
	ann_body	varchar2(200)		NULL,
    constraint pk_ann_no primary key (ann_no),
    constraint fk_ann_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_ann_work_no foreign key(work_no) references work(work_no) on delete set null
);
create sequence seq_ann_no;

--20220603 수정
alter table announcement drop constraint fk_ann_work_no;
commit;
alter table announcement modify ann_gender char constraint ck_ann_gender check(ann_gender in('M', 'F'));
alter table announcement add ann_title varchar2(50) not null;
-------------------------------------------
-- cast  배역
-------------------------------------------
CREATE TABLE cast (
	cast_no	number 	NOT NULL,
	work_no	number		NOT NULL,
	cast_role	varchar2(30),
	cast_name	varchar2(20),
	cast_contents	varchar2(200),
    constraint pk_cast_no primary key (cast_no),
    constraint fk_cast_work_no foreign key(work_no) references work(work_no) on delete cascade
);
create sequence seq_cast_no;

-------------------------------------------
-- actor_apply  지원내역
-------------------------------------------
CREATE TABLE actor_apply (
	member_id	varchar2(20)	NOT NULL,
	ann_no	number	NOT NULL,
    constraint fk_actor_apply_member_id foreign key (member_id) references member(member_id) on delete cascade,
    constraint fk_actor_apply_ann_no foreign key(ann_no) references announcement(ann_no) on delete set null
);

-------------------------------------------
-- wishlist_actor & wishlist_ann
-------------------------------------------
CREATE TABLE wishlist_actor (
	member_id	varchar2(20)		NOT NULL,
	actor_no	number	NOT NULL,
    constraint fk_wishlist_actor_member_id foreign key (member_id) references member(member_id) on delete cascade,
    constraint fk_wishlist_actor_no foreign key (actor_no) references actor_info(actor_no) on delete cascade
);


CREATE TABLE wishlist_ann (
	member_id	varchar2(20) NOT NULL,
	ann_no	number	NOT	NULL,
    constraint fk_wishlist_ann_member_id foreign key (member_id) references member(member_id) on delete cascade,
    constraint fk_wishlist_ann_no foreign key (ann_no) references announcement(ann_no) on delete cascade
);


-------------------------------------------
-- report 신고
-------------------------------------------
CREATE TABLE report (
	no	number	NOT NULL,
	member_id	varchar2(20),
	ann_no	number,
	actor_no	number,
	board_no	number,
	comment_no	number,
	report_content	varchar2(100)		NOT NULL,
	report_date	Date	DEFAULT sysdate	NOT NULL,
	report_status	varchar2(30)	DEFAULT 'U'	NOT NULL,
    constraint pk_report_no primary key (no), 
    constraint fk_report_member_id foreign key (member_id) references member(member_id) on delete set null,
    constraint ck_report_status check(report_status in ('U', 'I', 'E'))
);
create sequence seq_report_no;

COMMENT ON COLUMN report.report_status IS '처리상태 U undo I ing E end';




------------------------------------------------
-- member sample insert
-- id pwd name email memberRole phone gender birthday enroll_date
------------------------------------------------
insert into member values ('director', '1234', '디렉터', 'director@naver.com', 'D', '01015971597', 'M', to_date('19900909','yyyymmdd'), default);


------------------------------------------------
-- production sample insert
-- 
------------------------------------------------
insert into production values ('director', 'testProduction', '디렉터', '01015971597', 'director@naver.com');


------------------------------------------------
-- ann 찾기 sample insert
-- ann: no, id, work_no, area(null), end_date, reg_date default, pay(n), gender(n), age(n), height(n), body(n)
------------------------------------------------
insert into announcement values (
    seq_ann_no.nextval, 'director', seq_work_no.nextval, '서울시 강남구',
    to_date('20220606','yyyymmdd'), default, 1000000, 'F', 25, 165, '마름', '테스트제목'
);
insert into announcement values (
    seq_ann_no.nextval, 'director', seq_work_no.nextval, '서울시 서초구',
    to_date('20220620','yyyymmdd'), default, 1200000, 'F', 20, 170, '보통', '테스트제목2'
);
insert into announcement values (
    seq_ann_no.nextval, 'director', 21, '서울시 서초구',
    to_date('20220604','yyyymmdd'), default, 1200000, 'F', 20, 170, '보통', '테스트제목2'
);

------------------------------------------------
-- work sample insert
------------------------------------------------
insert into work values (
    seq_work_no.nextval, '영화', '테스트영화제목', 'testProduction', '디렉터', '뭐 어떤 말을 써야되나'
);
delete from work where work_no = 3;
insert into work values (
    4, '영화', '테스트영화제목2', 'testProduction', '디렉터', '뭐 어떤 말을 써야되나2'
);


------------------------------------------------
-- work_attachment sample insert
------------------------------------------------
insert into work_attachment values(
    SEQ_WORK_ATTACHMENT_NO.nextval, 4, 'test2.jpg', '20220603_12345.jpg',default
);
commit;





-------------------------------------
--테이블 정보보기
-------------------------------------
select * from member;
select * from board;
select * from board_attachment;
select * from board_comment;
select * from actor_info;
select * from portfolio;
select * from production;
select * from work;
select * from work_attachment;
select * from announcement;
select * from cast;
select * from actor_apply;
select * from wishlist_actor;
select * from wishlist_ann;
select * from report;















