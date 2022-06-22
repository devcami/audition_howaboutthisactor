--============================================
-- 관리자계정
--============================================
-- web계정 생성
--alter session set "_oracle_script" = true; -- c##으로 시작하지 않는 일반계정생성 허용

create user "5zizoyeyo"
identified by "5zizodkssuD!"
default tablespace users;

grant connect, resource, create view to "5zizoyeyo";

alter user "5zizoyeyo" quota unlimited on users;



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
select * from member where member_id = '2291074519Kakao' and phone = '01052037675';
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


-- portfolio & announcement에 insert되기 전에 work, work_attachment, cast가 먼저 insert되어야 한다
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
alter table cast modify cast_contents varchar2(1000);



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

alter table production add is_phone_open char(1) default 'N' not null;
alter table production add is_email_open char(1) default 'N' not null;


-------------------------------------------
-- announcement
-------------------------------------------
CREATE TABLE announcement (
	ann_no	number	NOT NULL,
	member_id	varchar2(20)		NOT NULL,
	work_no	number		NOT NULL,
    ann_title varchar2(200) not null,
	ann_area	varchar2(50)		NULL,
	ann_end_date	date		NOT NULL,
	ann_reg_date	date	DEFAULT sysdate	NOT NULL,
	ann_pay	varchar2(100)		NULL,
	ann_gender	varchar2(10)		NULL,
	ann_age	varchar2(50)		NULL,
	ann_height	varchar2(50)		NULL,
	ann_body	varchar2(200)		NULL,
    constraint pk_ann_no primary key (ann_no),
    constraint fk_ann_member_id foreign key(member_id) references member(member_id) on delete cascade,
    constraint fk_announcement_work_no foreign key(work_no) references work(work_no) on delete set null,
    constraint ck_ann_gender check(ann_gender in('남', '여', '무관'))
);
create sequence seq_ann_no;

alter table announcement add ann_nop number not null;
alter table announcement add is_close char(1) default 'N' not null;
alter table announcement add has_TO char(1) default 'N' not null;
alter table announcement modify has_TO char(1) default 'N' null;
alter table announcement drop constraint ck_ann_gender;
commit;

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

alter table report modify report_content varchar2(1000);
commit;



------------------------------------------------
-- member sample insert
-- id pwd name email memberRole phone gender birthday enroll_date
------------------------------------------------
insert into member values ('director', '1234', '디렉터샘플', 'director@naver.com', 'D', '01015971597', 'M', to_date('19900909','yyyymmdd'), default);
insert into member values ('actor', '1234', '배우샘플', 'actor@naver.com', 'P', '01019291929', 'F', to_date('19990202','yyyymmdd'), default);
insert into member values ('admin', '1234', '관리자샘플', 'admin@naver.com', 'A', '01012391239', 'M', to_date('19930203','yyyymmdd'), default);
insert into member values ('actor2', '1234', '배우샘플2', 'actor2@naver.com', 'P', '01011111111', 'F', to_date('19990204','yyyymmdd'), default);
insert into member values ('actor3', '1234', '배우샘플3', 'actor3@naver.com', 'P', '01011111112', 'F', to_date('19990205','yyyymmdd'), default);
insert into member values ('actor4', '1234', '배우샘플4', 'actor4@naver.com', 'P', '01011111113', 'F', to_date('19990206','yyyymmdd'), default);
insert into member values ('actor5', '1234', '배우샘플5', 'actor5@naver.com', 'P', '01011111114', 'F', to_date('19990207','yyyymmdd'), default);
insert into member values ('actor6', '1234', '배우샘플6', 'actor6@naver.com', 'P', '01011111115', 'F', to_date('19990208','yyyymmdd'), default);
insert into member values ('actor7', '1234', '배우샘플7', 'actor7@naver.com', 'P', '01011111116', 'F', to_date('19990209','yyyymmdd'), default);
insert into member values ('actor8', '1234', '배우샘플8', 'actor8@naver.com', 'P', '01011111117', 'F', to_date('19990210','yyyymmdd'), default);
insert into member values ('actor9', '1234', '배우샘플9', 'actor9@naver.com', 'P', '01011111118', 'F', to_date('19990211','yyyymmdd'), default);
insert into member values ('actor10', '1234', '배우샘플10', 'actor10@naver.com', 'P', '01011111119', 'F', to_date('19990212','yyyymmdd'), default);
insert into member values ('actor11', '1234', '배우샘플11', 'actor11@naver.com', 'P', '01011111110', 'F', to_date('19990213','yyyymmdd'), default);
insert into member values ('actor12', '1234', '배우샘플12', 'actor12@naver.com', 'P', '01011111122', 'F', to_date('19990214','yyyymmdd'), default);
insert into member values ('actor13', '1234', '배우샘플13', 'actor13@naver.com', 'P', '01011111123', 'F', to_date('19990215','yyyymmdd'), default);
insert into member values ('actor14', '1234', '배우샘플14', 'actor14@naver.com', 'P', '01011111124', 'F', to_date('19990216','yyyymmdd'), default);


-- actor_info sample insert
insert into actor_info values('actor', SEQ_ACTOR_INFO_NO.nextval, 25, '한양대 연극영화과', 165, 50, '샘플소속사', '노래', '@actorsampleinsta', 'actorProfileSampleImg.jpg');
-- production sample insert
insert into production values ('director', 'testProduction', '디렉터', '01015971597', 'director@naver.com');



------------------------------------------------
-- work sample insert 20220610
------------------------------------------------
insert into work values (seq_work_no.nextval, '영화', '테스트영화제목', 'testProduction', '디렉터', '뭐 어떤 말을 써야되나 작품에 대한 설명입니다~');
insert into work values (seq_work_no.nextval, '드라마', '테스트드라마제목', 'testProduction', '디렉터', '뭐 어떤 말을 써야되나 드라마 작품에 대한 설명입니다~');
insert into work values (seq_work_no.nextval, '연극', '테스트연극제목', 'testProduction', '디렉터', '뭐 어떤 말을 써야되나 연극 작품에 대한 설명입니다~');

select * from work_attachment;
------------------------------------------------
-- work_attachment sample insert 20220610
------------------------------------------------
insert into work_attachment values(SEQ_WORK_ATTACHMENT_NO.nextval, 1, 'test1.jpg', '20220603_12345.jpg',default);
insert into work_attachment values(SEQ_WORK_ATTACHMENT_NO.nextval, 2, 'test2.jpg', '20220603_12346.jpg',default);
insert into work_attachment values(SEQ_WORK_ATTACHMENT_NO.nextval, 3, 'test3.jpg', '20220603_12347.jpg',default);

------------------------------------------------
-- cast sample insert 20220610
------------------------------------------------
insert into cast values(SEQ_CAST_NO.nextval, 1, '주연', '여배우', '안녕하세요 ! 여배우를 구합니다');
insert into cast values(SEQ_CAST_NO.nextval, 2, '조연', '여주인공', '안녕하세요 ! 여주인공을 구합니다');
insert into cast values(SEQ_CAST_NO.nextval, 3, '주연', '아무개', '안녕하세요 ! 아무개를 구합니다');






------------------------------------------------
-- ann 찾기 sample insert

-- 급여   String
-- 나이   ~10세 11~17세 18~25세 26세~35세 36세~45세 45세~ 연령무관 
-- 키    ~110 111~150 151~160 161~170 171~180 180~ 신장무관
-- 체형   마름 보통 통통 체형무관

-- ann: no, id, work_no, title, area(null), end_date, reg_date default, pay(n), gender(n), age(n), height(n), body(n), nop
------------------------------------------------
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목1','서울시 서초구', to_date('20220620','yyyymmdd'), default, '300만원', '여', '18~23세', '신장무관', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 2, '테스트제목2','서울시 서초구', to_date('20220615','yyyymmdd'), default, '회당 80만원', '여', '23~30세', '161~170', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목3','서울시 서초구', to_date('20220615','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목4','서울시 서초구', to_date('20220608','yyyymmdd'), default, '추후협의', '남', '연령무관', '171~180', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 2, '테스트제목5','서울시 서초구', to_date('20220619','yyyymmdd'), default, '회당 10만원', '여', '연령무관', '신장무관', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 2, '테스트제목6','서울시 서초구', to_date('20220620','yyyymmdd'), default, '회당 10만원', '여', '연령무관', '신장무관', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 2, '테스트제목7','서울시 서초구', to_date('20220621','yyyymmdd'), default, '회당 10만원', '여', '연령무관', '신장무관', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목8','서울시 서초구', to_date('20220608','yyyymmdd'), default, '추후협의', '남', '연령무관', '171~180', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목9','서울시 서초구', to_date('20220618','yyyymmdd'), default, '추후협의', '남', '연령무관', '171~180', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목10','서울시 서초구', to_date('20220615','yyyymmdd'), default, '추후협의', '남', '연령무관', '171~180', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 1, '테스트제목11','서울시 서초구', to_date('20220608','yyyymmdd'), default, '추후협의', '남', '연령무관', '171~180', '보통', 1);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목12','서울시 서초구', to_date('20220702','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목13','서울시 서초구', to_date('20220703','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목14','서울시 서초구', to_date('20220714','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목15','서울시 서초구', to_date('20220722','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);
insert into announcement values (seq_ann_no.nextval, 'director', 3, '테스트제목16','서울시 서초구', to_date('20220707','yyyymmdd'), default, '회당 8만원', '남', '30세~40세', '신장무관', '보통', 10);


-- commit;


-------------------------------------
-- insert portfolio

-- 기간 String
-------------------------------------
insert into portfolio values (SEQ_PORTFOLIO_NO.nextval, 'actor', 2, '2018년 10월~2018년 11월', null);
insert into portfolio values (SEQ_PORTFOLIO_NO.nextval, 'actor', 1, '2019년 10월~2019년 11월', null);




-------------------------------------
--테이블 정보보기
-------------------------------------
select * from actor_apply;
select * from actor_info;
select * from announcement; 
select * from board;
select * from board_attachment;
select * from board_comment;
select * from cast;
select * from member;
select * from portfolio_work;
select * from port_attachment;
select * from production;
select * from report;
select * from wishlist_actor;
select * from wishlist_ann;
select * from work;
select * from work_attachment;
select * from port_attachment where attach_type = 'P' and memberid = 'hosi';

select *  from announcement a join (select ann_no, count(*) cnt from wishlist_ann group by ann_no) w on a.ann_no = w.ann_no order by cnt desc, ann_reg_date desc;

select * from all_tables where tablespace_name = 'USERS';
SELECT *  FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = 'ANNOUNCEMENT'; 

SELECT column_name, data_type, data_length, nullable, data_default FROM ALL_TAB_COLUMNS WHERE TABLE_NAME = 'wishlist_ann';

--제약조건 조회    
select
    constraint_name
    ,uc.table_name
    ,ucc.column_name
    ,uc.constraint_type
    ,uc.search_condition
    ,delete_rule 
    ,r_constraint_name
from
    user_constraints uc join user_cons_columns ucc
        using(constraint_name)
where
    uc.table_name = 'REPORT';




-----------------------------------
-- memberId varchar2(200) 으로 변경
-----------------------------------
select * from actor_info;
alter table portfolio_work modify (member_id varchar2(200));
alter table announcement modify (ann_gender varchar2(20));
alter table actor_info modify (actor_email varchar2(200));
alter table board_attachment modify (member_id varchar2(200));
alter table PORT_ATTACHMENT modify (memberId varchar2(200));
alter table report modify (member_id varchar2(200));
alter table wishlist_actor modify (member_id varchar2(200));

select count(*) cnt from member where member_id = 'as';
select * from board;
select * from (select b.*, (select count(*) from board_attachment where board_no = b.no) attach_cnt, (select count(*) from board_comment where board_no = b.no) comment_cnt, row_number() over(order by reg_date desc) rnum from board b where title like '%안녕%') b ;
update member set gender = 'F' where member_id = 'director';
commit;