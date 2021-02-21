-- 전체 테이블 조회
SELECT * FROM tab
-- DROP TABLE
drop table ANSWER;
drop table QUESTION;
drop table Review;
drop table TRADE;
drop table FOOD_SELL;
drop table FOOD_IMG;
drop table FOOD;
drop table TR_STATUS;
drop table CATEGORY;
drop table SELLER;
drop table MEM_AUTH;
drop table BAN_MEM;
drop table ENABLE;
drop table PW_QNA;
drop table ADDRESS;
drop table AUTH;

-- DROP SEQUENCE
drop sequence address_seq;
drop sequence mem_auth_seq;
drop sequence category_seq;
drop sequence food_seq;
drop sequence food_img_seq;
drop sequence food_sell_seq; 
drop sequence food_sell_img_seq; 
drop sequence trade_seq;
drop sequence review_seq;
drop sequence question_seq;
drop sequence answer_seq;


-- CREATE TABLE

-- AUTH(권한)
CREATE TABLE AUTH
(
   AUTH_NO NUMBER  PRIMARY KEY ,
   AUTH_NAME VARCHAR2(100)  NOT NULL 
);

-- ADDRESS(주소)
CREATE TABLE ADDRESS
(
   ADDRESS_NO NUMBER  PRIMARY KEY ,
   ADDRESS_API VARCHAR2(500)  NOT NULL ,
   LATITUDE BINARY_DOUBLE  NOT NULL ,
   LONGITUDE BINARY_DOUBLE  NOT NULL 
);


-- PW_QNA(비밀번호 찾기 질문)
CREATE TABLE PW_QNA
(
   PW_QNA_NO NUMBER  PRIMARY KEY ,
   PW_QUEST VARCHAR2(300)  NOT NULL 
);


-- ENABLE(회원 활동상태)
CREATE TABLE ENABLE
(
   ENABLE_NO NUMBER   PRIMARY KEY ,
   ENABLE_NAME VARCHAR2(100)  NOT NULL 
);


-- BAN_MEM(회원)
CREATE TABLE BAN_MEM
(
   MEM_ID VARCHAR2(100)  PRIMARY KEY ,
   PW VARCHAR2(500)  NOT NULL ,
   BIRTH DATE  NOT NULL ,
   TEL VARCHAR2(100)  NOT NULL ,
   ADDRESS_NO NUMBER  NOT NULL ,
   constraint FK_BAN_MEM_ADDRESS_NO foreign key(ADDRESS_NO) references ADDRESS(ADDRESS_NO) ON DELETE CASCADE,
   ADDRESS_DE VARCHAR2(300)  NOT NULL ,
   PW_QNA_NO NUMBER  NOT NULL ,
   ENABLE_NO NUMBER  NOT NULL ,
   constraint FK_BAN_MEM_ENABLE_NO foreign key(ENABLE_NO) references ENABLE(ENABLE_NO) ON DELETE CASCADE,
   MEM_NAME VARCHAR2(100)  NOT NULL ,
   PW_ANSWER VARCHAR2(500)  NOT NULL ,
   constraint FK_BAN_MEM_PW_ANSWER foreign key(PW_QNA_NO) references PW_QNA(PW_QNA_NO)
);


-- MEM_AUTH(회원권한)
CREATE TABLE MEM_AUTH
(
   MEM_AUTH_NO NUMBER  PRIMARY KEY,
   MEM_ID VARCHAR2(100)  NOT NULL ,
   constraint FK_MEM_AUTH_MEM_ID foreign key(MEM_ID) references BAN_MEM(MEM_ID) ON DELETE CASCADE,
   AUTH_NO NUMBER NOT NULL ,
   constraint FK_MEM_AUTH_AUTH_NO foreign key(AUTH_NO) references AUTH(AUTH_NO) ON DELETE CASCADE
);


-- SELLER(판매자 정보)
CREATE TABLE SELLER
(
   MEM_ID VARCHAR2(100)  PRIMARY KEY ,
   constraint FK_SELLER foreign key(MEM_ID) references BAN_MEM(MEM_ID),
   SELLER_IMG VARCHAR2(300)  NOT NULL ,
   SELLER_INFO CLOB  NOT NULL ,
   SELLER_SCORE FLOAT  NULL 
);

-- CATEGORY(음식 카테고리 분류)
CREATE TABLE CATEGORY
(
   CATEGORY_NO NUMBER  PRIMARY KEY ,
   CATEGORY_NAME VARCHAR2(100)  NOT NULL 
);

-- TR_STATUS(거래상태_
CREATE TABLE TR_STATUS
(
   TR_STATUS_NO NUMBER  PRIMARY KEY ,
   TR_STATUS VARCHAR2(100)  NOT NULL 
);


-- FOOD(음식)
CREATE TABLE FOOD
(
   FOOD_NO NUMBER  PRIMARY KEY ,
   FOOD_NAME VARCHAR2(100)  NOT NULL ,
   MEM_ID VARCHAR2(100)  NOT NULL,
    constraint FOOD_FK_ID foreign key(MEM_ID) references BAN_MEM(MEM_ID),
   FOOD_DE CLOB  NOT NULL ,
   FOOD_SCORE FLOAT  NULL ,
   CATEGORY_NO NUMBER  NOT NULL ,
    constraint FOOD_FK_CATEGORY foreign key(CATEGORY_NO) references CATEGORY(CATEGORY_NO) ,
   FOOD_MAIN_IMG VARCHAR2(300)  NOT NULL ,
   FOOD_POSTDATE DATE  NOT NULL 
);

-- FOOD_IMG(음식사진)
CREATE TABLE FOOD_IMG
(
   FOOD_IMG_NO NUMBER PRIMARY KEY ,
   FOOD_NO NUMBER  NOT NULL  ,
    constraint FOOD_NO_FK foreign key(FOOD_NO) references FOOD(FOOD_NO) ON DELETE  CASCADE,
   FOOD_IMG_PATH VARCHAR2(300)  NOT NULL 
);

-- FOOD_SELL(판매정보)
CREATE TABLE FOOD_SELL
(
   FOOD_SELL_NO NUMBER  PRIMARY KEY ,
   FOOD_NO NUMBER  NOT NULL ,
    constraint FOOD_SELL_FK foreign key(FOOD_NO) references FOOD(FOOD_NO) ON DELETE  CASCADE, 
   TR_DATE DATE  NOT NULL ,
   CLOSE_DATE DATE  NOT NULL ,
   LOC VARCHAR2(100) NOT NULL ,
   PRICE NUMBER  NOT NULL ,
   PRE_QUANTITY NUMBER  NOT NULL ,
   SELL_POSTDATE DATE  NOT NULL ,
   UNIT VARCHAR2(100)  NOT NULL ,
   SELL_DETAIL CLOB  NOT NULL 
);


-- FOOD_SELL_IMG(음식사진)
CREATE TABLE FOOD_SELL_IMG
(
   FOOD_SELL_IMG_NO NUMBER PRIMARY KEY ,
   FOOD_SELL_NO NUMBER  NOT NULL  ,
    constraint FOOD_SELL_NO_FK foreign key(FOOD_SELL_NO) references FOOD_SELL(FOOD_SELL_NO) ON DELETE  CASCADE,
   FOOD_SELL_IMG_PATH VARCHAR2(300)  NOT NULL 
);


-- TRADE(거래내역)
CREATE TABLE TRADE
(
   TR_NO NUMBER  PRIMARY KEY,
   MEM_ID VARCHAR2(100)  NOT NULL ,
    constraint TRADE_FK_ID  foreign key(MEM_ID) references BAN_MEM(MEM_ID),
   FOOD_SELL_NO NUMBER  NOT NULL ,
    constraint TRADE_FK_SELL  foreign key(FOOD_SELL_NO) references FOOD_SELL(FOOD_SELL_NO) ON DELETE  CASCADE,
   TR_QUANTITY NUMBER  NOT NULL ,
   TR_STATUS_NO NUMBER  NOT NULL ,
    constraint TRADE_FK_STATUS  foreign key(TR_STATUS_NO) references TR_STATUS(TR_STATUS_NO),
   TR_FIN_DATE DATE  NOT NULL ,
   TR_REQ_DATE DATE  NOT NULL 
);


-- REVIEW(음식후기)
CREATE TABLE REVIEW
(
   REV_NO NUMBER  PRIMARY KEY,
   SCORE NUMBER  NULL ,
   REV_CONTENT CLOB  NOT NULL ,
   REV_POSTDATE DATE  NOT NULL ,
   FOOD_NO NUMBER  NOT NULL,
    constraint REVIEW_FOOD_FK foreign key(FOOD_NO) references FOOD(FOOD_NO),
   MEM_ID VARCHAR2(100) NOT NULL,
    constraint REVIEW_BAN_MEM_FK foreign key(MEM_ID) references BAN_MEM(MEM_ID)
);


-- QUESTION(판매음식 문의)
CREATE TABLE QUESTION
(
    QUEST_NO NUMBER  PRIMARY KEY,
   FOOD_SELL_NO NUMBER  NOT NULL ,
    constraint QUESTION_SELL_FK foreign key(FOOD_SELL_NO) references FOOD_SELL(FOOD_SELL_NO) ON DELETE  CASCADE,
   MEM_ID VARCHAR2(100)  NOT NULL ,
    constraint QUESTION_ID_FK foreign key(MEM_ID) references BAN_MEM(MEM_ID),
   QUEST_CONTENT CLOB  NOT NULL ,
   QUEST_POSTDATE DATE  NOT NULL 
);


-- ANSWER(판매음식문의 답변)
CREATE TABLE ANSWER
(
   ANS_NO NUMBER  PRIMARY KEY ,
   MEM_ID VARCHAR2(100)  NOT NULL ,
    constraint ANSWER_ID_FK foreign key(MEM_ID) references BAN_MEM(MEM_ID) ON DELETE  CASCADE,
   ANS_CONTENT CLOB  NOT NULL ,
   ANS_POSTDATE DATE  NOT NULL ,
   QUEST_NO NUMBER  NOT NULL, 
    constraint ANSWER_NO_FK foreign key(QUEST_NO) references QUESTION(QUEST_NO) ON DELETE  CASCADE   
);

CREATE TABLE BANCHAN_REPORT(
	KEYWORD VARCHAR2(100) PRIMARY KEY,
	HIT NUMBER NOT NULL
);

-- CREATE SEQUENCE
create sequence address_seq nocache; 
create sequence mem_auth_seq nocache;
create sequence category_seq nocache;
create sequence food_seq nocache;
create sequence food_img_seq nocache;
create sequence food_sell_seq nocache;
create sequence food_sell_img_seq nocache;
create sequence trade_seq nocache;
create sequence review_seq nocache;
create sequence question_seq nocache;
create sequence answer_seq nocache;


-- INSERT (고정된 정보)
insert into enable(enable_no,enable_name) values(11,'활동중');
insert into enable(enable_no,enable_name) values(22,'탈퇴');

insert into pw_qna(pw_qna_no,pw_quest) values(1,'가장 좋아하는 색은?');
insert into pw_qna(pw_qna_no,pw_quest) values(2,'가장 좋아하는 영화 제목은?');
insert into pw_qna(pw_qna_no,pw_quest) values(3,'가장 아끼는 물품은?');
insert into pw_qna(pw_qna_no,pw_quest) values(4,'학창시절 별명은?');

insert into auth(auth_no,auth_name) values(10,'ROLE_BUYER');
insert into auth(auth_no,auth_name) values(20,'ROLE_SELLER');
insert into auth(auth_no,auth_name) values(30,'ROLE_ADMIN');

insert into category(category_no, category_name) values(category_seq.nextval, '반찬');
insert into category(category_no, category_name) values(category_seq.nextval, '김치');
insert into category(category_no, category_name) values(category_seq.nextval, '고기');
insert into category(category_no, category_name) values(category_seq.nextval, '국,찌게');
insert into category(category_no, category_name) values(category_seq.nextval, '도시락');
insert into category(category_no, category_name) values(category_seq.nextval, '베이커리');

insert into tr_status(tr_status_no, tr_status) values(1,'거래중');      
insert into tr_status(tr_status_no, tr_status) values(2,'거래완료');      





