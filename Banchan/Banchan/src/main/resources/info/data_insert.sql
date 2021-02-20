-- ENABLE
insert into enable(enable_no,enable_name) values(11,'활동중');
insert into enable(enable_no,enable_name) values(22,'탈퇴');


-- ADDRESS 
-- API로 정보 정확히 확인해야함
-- 주소 1000~1004 까지 만들어둬야함
create sequence address_seq start with 1000 nocache; 

insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval,'경기도 성남시 분당구 삼평동 대왕판교로 660', 37.4008198,127.10651510000002);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '서울특별시 용산구 이태원1동 200-4',37.537363 ,126.992168);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 삼평동 30-18',37.39654549999999 ,127.11839789999999);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 황새울로 347',37.3868489,127.12322270000004);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 서현1동 233-2',37.3836054,127.13391679999995);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '대한민국 경기도 성남시 중원구 도촌동 568',37.4145857,127.15163159999997);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '대한민국 경기도 성남시 수정구 신흥1동 4789',37.4408917,127.1416772);


-- PW_QNA
insert into pw_qna(pw_qna_no,pw_quest) values(1,'가장 좋아하는 색은?');
insert into pw_qna(pw_qna_no,pw_quest) values(2,'가장 좋아하는 영화 제목은?');
insert into pw_qna(pw_qna_no,pw_quest) values(3,'가장 아끼는 물품은?');
insert into pw_qna(pw_qna_no,pw_quest) values(4,'학창시절 별명은?');


-- AUTH
insert into auth(auth_no,auth_name) values(10,'ROLE_BUYER');
insert into auth(auth_no,auth_name) values(20,'ROLE_SELLER');
insert into auth(auth_no,auth_name) values(30,'ROLE_ADMIN');



-- BAN_MEM
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('java','1234','송중기',to_date('19800101','YYYYMMDD'),'01012341234','주공아파트110동 101호','파란색',11, 1000, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('spring','1234','송혜교',to_date('19840101','YYYYMMDD'),'01098769876','벽산아파트 222동 111호','쇼생크탈출',11, 1001, 2);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('ajax','1234','배수지',to_date('19940101','YYYYMMDD'),'01036463575','블루밍힐 7010동 904호','아이패드',11, 1001, 3);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('javascript','1234','이종석',to_date('19880101','YYYYMMDD'),'01011113575','블루밍힐 7011동 905호','아이패드',11, 1002, 3);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('java2','1234','박보영',to_date('19900101','YYYYMMDD'),'01022223575','주공아파트210동 104호','모찌',11, 1002, 4);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('spring2','1234','유재석',to_date('19700101','YYYYMMDD'),'01099923575','주공아파트211동 105호','빨간색',11, 1003, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('ajax2','1234','전지현',to_date('19790101','YYYYMMDD'),'01089898989','한양아파트115동 101호','필통',11, 1004, 3);


-- MEM_AUTH
create sequence mem_auth_seq start with 100 nocache;

insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval,'java','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'spring','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'ajax','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'javascript','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'java2','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'spring2','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'ajax2','10');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'java2','20');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'spring2','20');
insert into mem_auth(mem_auth_no, mem_id, auth_no) values(mem_auth_seq.nextval, 'ajax2','20');


-- SELLER
-- ID 뒤에 2 붙은 건 판매자 권한 가지고 있는 회원
-- 이미지 경로: "C:\\Users\\kosta\\git\\FASTakeout\\FASTakeout\\WebContent\\upload" 이런식으로?
insert into seller(mem_id, seller_img, seller_info, seller_score) values('java2','이미지경로', '주부경력 10년입니다.',0);
insert into seller(mem_id, seller_img, seller_info, seller_score) values('spring2','이미지경로', '20년동안 매일 아침점심저녁을 담당한 손맛을 보여드립니다~',0);
insert into seller(mem_id, seller_img, seller_info, seller_score) values('ajax2','이미지경로','혜자스러운 반찬을 전해드립니다!',0 );



-- CATEGORY
create sequence category_seq start with 10101 nocache;
-- 10101.반찬   10102.김치  10103.고기   10104.국,찌게   10105.도시락   10106.베이커리
insert into category(category_no, category_name) values(category_seq.nextval, '반찬');
insert into category(category_no, category_name) values(category_seq.nextval, '김치');
insert into category(category_no, category_name) values(category_seq.nextval, '고기');
insert into category(category_no, category_name) values(category_seq.nextval, '국,찌게');
insert into category(category_no, category_name) values(category_seq.nextval, '도시락');
insert into category(category_no, category_name) values(category_seq.nextval, '베이커리');


-- FOOD
-- 이미지 경로: "C:\\Users\\kosta\\git\\FASTakeout\\FASTakeout\\WebContent\\upload" 이런식으로?
create sequence food_seq start with 1001 nocache;

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '갓김치', '전라도 명품 갓김치!', 0, '이미지경로', sysdate, 10102, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '파김치', '매콤하고 맛있는 파김치~~', 0, '이미지경로', sysdate, 10102, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '도라지무침', '직접 재배한 도라지로 만들었어요~', 0, '이미지경로', sysdate, 10101, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '잡채', '간을 약하게 했습니다. 참고하세요!', 0, '이미지경로', sysdate, 10101, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '호박전', '추석이 생각나는 맛~', 0, '이미지경로', sysdate, 10101, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '쭈꾸미볶음', '화끈하게 매운 맛입니다!! 중국산 쭈꾸미아니고 국산이에요^^', 0, '이미지경로', sysdate, 10101, 'java2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '제육볶음', '매콤달콤한 맛있는 제육볶음! 재료: 국산돼지고기 600g', 0, '이미지경로', sysdate, 10103, 'spring2');

insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '김치찌게', '돼지고기 베이스의 맛있는 김치찌게~~', 0, '이미지경로', sysdate, 10104, 'spring2');


-- FOOD_SELL
create sequence food_sell_seq start with 101010 nocache;

insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171117 15:30','YYYYMMDD HH24:MI'), to_date('20171130 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 5000, 5, sysdate, '600g/개', '놀이터에서 일괄 구매만 가능합니다.', 1001);
      
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171010 15:30','YYYYMMDD HH24:MI'), to_date('20171120 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 3000, 5, sysdate, '400g/개', '생각보다 매울 수 있습니다. 택배가능합니다. 미리 개인적으로 연락주세요.', 1002);
      
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171129 15:30','YYYYMMDD HH24:MI'), to_date('20171201 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 2000, 10, sysdate, '300g/개', '이번엔 좀 덜 맵게 만들었습니다. 아이들도 먹을 수 있어요. 택배는 불가합니다.', 1002);

insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171129 15:30','YYYYMMDD HH24:MI'), to_date('20171201 15:30','YYYYMMDD HH24:MI'), 
      '분당초앞', 2000, 7, sysdate, '50g/개', '따로 용기는 제공하지 않고 비닐봉지에 담아드립니다. 해당일 외에는 거래 불가', 1003);
      
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171129 15:30','YYYYMMDD HH24:MI'), to_date('20171201 15:30','YYYYMMDD HH24:MI'), 
      '분당초앞', 2000, 7, sysdate, '50g/개', '따로 용기는 제공하지 않고 비닐봉지에 담아드립니다. 해당일 외에는 거래 불가', 1003);
      

-- TR_STATUS
insert into tr_status(tr_status_no, tr_status) values(1,'거래중');      
insert into tr_status(tr_status_no, tr_status) values(2,'거래완료');      
      
      
-- TRADE
create sequence trade_seq nocache;
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 1, sysdate, sysdate, 'y3qpmm', 101010, 2);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 2, sysdate, sysdate, 'java', 101011, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 3, sysdate, sysdate, 'spring', 101011, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 2, sysdate, sysdate, 'spring', 101012, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 1, sysdate, sysdate, 'ajax', 101012, 1);


-- REVIEW
create sequence review_seq nocache;
--insert review data   (food_no는 각자 사용하는  음식 번호를 집어 넣으세요)
insert into review(rev_no, score, rev_postdate, rev_content, food_no) 
values(review_seq.nextval, 5 ,sysdate, '진짜 맛있었어요 주부님짱짱 또 구매하고 싶네요~~!^^', 1001);

insert into review(rev_no, score, rev_postdate, rev_content, food_no) 
values(review_seq.nextval, 2, sysdate, '별로 제 입맛에는 맞지 않았지만 다른분들은 좋아하실수도 있겠네요', 1001);

insert into review(rev_no, score, rev_postdate, rev_content, food_no) 
values(review_seq.nextval, 4, sysdate, '다시 구매하고 싶어요!ㅇㅇ주부님 감사해요~~', 1001);


-- QUESTION
create sequence question_seq nocache;

insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '많이 맵나요?', sysdate, 101010, 'java');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '너무 짜진 않은가요? 저염식 식단 먹고있어서요', sysdate, 101010, 'spring');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '택배배달은 안되나요? 집이 좀 멀어서요', sysdate, 101011, 'ajax');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '다음에도 또 판매예정인가요? 지금 말고 좀 나중에 사고 싶어요', sysdate, 101011, 'java');


-- ANSWER
create sequence answer_seq nocache;

insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '저번에 먹었을 때 그렇게 맵진 않았어요!', sysdate, 'spring',1);
insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '저는 좀 매웠던거 같은데...', sysdate, 'ajax',2);
insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '많이 짜진 않습니다!', sysdate, 'java2',3);


 
drop sequence address_seq;
drop sequence mem_auth_seq;
drop sequence category_seq;
drop sequence food_seq;
drop sequence food_sell_seq; 
drop sequence trade_seq;
drop sequence review_seq;
drop sequence question_seq;
drop sequence answer_seq;

/*top3 sql*/
select m.mem_id, m.mem_name, a.address_api, s.seller_img, s.seller_info, s.seller_score 
					from (select mem_id, seller_score, seller_info, seller_img, rank() over(order by seller_score desc) as rank from seller)
					s, ban_mem m, address a 
					where m.mem_id=s.mem_id and m.address_no=a.address_no and rank<=3
		
					
					select * from seller;
delete from seller where mem_id='java';
select * from mem_auth;
select *from AUTH
delete from mem_auth where mem_id='java' and auth_no='20';
commit
				
