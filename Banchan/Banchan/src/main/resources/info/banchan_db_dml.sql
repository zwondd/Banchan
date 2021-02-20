-- ADDRESS 
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval,'경기도 성남시 분당구 삼평동 대왕판교로 660', 37.4008198,127.10651510000002);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '서울특별시 용산구 이태원1동 200-4',37.537363 ,126.992168);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 삼평동 30-18',37.39654549999999 ,127.11839789999999);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 황새울로 347',37.3868489,127.12322270000004);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '경기도 성남시 분당구 서현1동 233-2',37.3836054,127.13391679999995);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '대한민국 경기도 성남시 중원구 도촌동 568',37.4145857,127.15163159999997);
insert into address(address_no, address_api, latitude, longitude) values(address_seq.nextval, '대한민국 경기도 성남시 수정구 신흥1동 4789',37.4408917,127.1416772);


-- BAN_MEM
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('java','1234','송중기',to_date('19800101','YYYYMMDD'),'01012341234','주공아파트110동 101호','파란색',11, 1, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('spring','1234','송혜교',to_date('19840101','YYYYMMDD'),'01098769876','벽산아파트 222동 111호','쇼생크탈출',11, 1, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('ajax','1234','배수지',to_date('19940101','YYYYMMDD'),'01036463575','블루밍힐 7010동 904호','아이패드',11, 2, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('javascript','1234','이종석',to_date('19880101','YYYYMMDD'),'01011113575','블루밍힐 7011동 905호','아이패드',11, 2, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('java2','1234','박보영',to_date('19900101','YYYYMMDD'),'01022223575','주공아파트210동 104호','모찌',11, 2, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('spring2','1234','유재석',to_date('19700101','YYYYMMDD'),'01099923575','주공아파트211동 105호','빨간색',11, 3, 1);
insert into ban_mem(mem_id, pw, mem_name, birth, tel, address_de, pw_answer, enable_no, address_no, pw_qna_no)
values('ajax2','1234','전지현',to_date('19790101','YYYYMMDD'),'01089898989','한양아파트115동 101호','필통',11, 4, 1);


-- MEM_AUTH
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
insert into seller(mem_id, seller_img, seller_info, seller_score) values('java2','이미지경로', '주부경력 10년입니다.',0);
insert into seller(mem_id, seller_img, seller_info, seller_score) values('spring2','이미지경로', '20년동안 매일 아침점심저녁을 담당한 손맛을 보여드립니다~',0);
insert into seller(mem_id, seller_img, seller_info, seller_score) values('ajax2','이미지경로','혜자스러운 반찬을 전해드립니다!',0 );

-- FOOD
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '갓김치', '전라도 명품 갓김치!', 0, '이미지경로', sysdate, 1, 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '파김치', '매콤하고 맛있는 파김치~~', 0, '이미지경로', sysdate, 2, 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '도라지무침', '직접 재배한 도라지로 만들었어요~', 0, '이미지경로', sysdate, 3, 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '시금치무침', '직접 재배한 시금치로 만들었어요~', 0, '등갈비.jpg', sysdate, '10101', 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '두부조림', '직접 재배한 콩으로 만들었어요~', 0, '미역국.jpg', sysdate, '10101', 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '총각김치', '직접 재배한 콩으로 만들었어요~', 0, '미역국.jpg', sysdate, '10101', 'java2');
insert into food(food_no, food_name, food_de, food_score, food_main_img, food_postdate, category_no, mem_id)
values(food_seq.nextval, '치즈등갈비', '직접 재배한 콩으로 만들었어요~', 0, '미역국.jpg', sysdate, '10101', 'java2');
select * from food
-- FOOD_SELL 
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171117 15:30','YYYYMMDD HH24:MI'), to_date('20171130 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 5000, 5, sysdate, '600g/개', '놀이터에서 일괄 구매만 가능합니다.', 1);
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171010 15:30','YYYYMMDD HH24:MI'), to_date('20171120 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 3000, 5, sysdate, '400g/개', '생각보다 매울 수 있습니다. 택배가능합니다. 미리 개인적으로 연락주세요.', 2);
insert into food_sell(food_sell_no, tr_date, close_date, loc, price, pre_quantity, sell_postdate, unit, sell_detail, food_no)
values(food_sell_seq.nextval, to_date('20171129 15:30','YYYYMMDD HH24:MI'), to_date('20171201 15:30','YYYYMMDD HH24:MI'), 
      '놀이터', 2000, 10, sysdate, '300g/개', '이번엔 좀 덜 맵게 만들었습니다. 아이들도 먹을 수 있어요. 택배는 불가합니다.', 2);

-- TRADE
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 1, sysdate, sysdate, 'java', 1, 2);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 2, sysdate, sysdate, 'java', 1, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 3, sysdate, sysdate, 'spring', 2, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 2, sysdate, sysdate, 'spring', 2, 1);
insert into trade(tr_no, tr_quantity, tr_req_date, tr_fin_date, mem_id, food_sell_no, tr_status_no)
values(trade_seq.nextval, 1, sysdate, sysdate, 'ajax', 2, 1);


-- REVIEW
insert into review(rev_no, score, rev_postdate, rev_content, food_no, mem_id) 
values(review_seq.nextval, 5 ,sysdate, '진짜 맛있었어요 주부님짱짱 또 구매하고 싶네요~~!^^', 1,'java');
insert into review(rev_no, score, rev_postdate, rev_content, food_no, mem_id) 
values(review_seq.nextval, 2, sysdate, '별로 제 입맛에는 맞지 않았지만 다른분들은 좋아하실수도 있겠네요',1,'java');
insert into review(rev_no, score, rev_postdate, rev_content, food_no, mem_id) 
values(review_seq.nextval, 4, sysdate, '다시 구매하고 싶어요!ㅇㅇ주부님 감사해요~~', 2,'spring');


-- QUESTION
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '많이 맵나요?', sysdate, 1, 'java');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '너무 짜진 않은가요? 저염식 식단 먹고있어서요', sysdate, 1, 'spring');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '택배배달은 안되나요? 집이 좀 멀어서요', sysdate, 2, 'ajax');
insert into question(quest_no, quest_content, quest_postdate, food_sell_no, mem_id)
values(question_seq.nextval, '다음에도 또 판매예정인가요? 지금 말고 좀 나중에 사고 싶어요', sysdate, 2, 'java');


-- ANSWER
insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '저번에 먹었을 때 그렇게 맵진 않았어요!', sysdate, 'spring',1);
insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '저는 좀 매웠던거 같은데...', sysdate, 'ajax',2);
insert into answer(ans_no, ans_content, ans_postdate, mem_id, quest_no)
values(answer_seq.nextval, '많이 짜진 않습니다!', sysdate, 'java2',3);




--revie 수정
alter table REVIEW add (mem_id varchar2(100));
update REVIEW set mem_id='본인 db에 있는 아이디';
alter table REVIEW modify (mem_id not null);
alter table REVIEW add constraint fk_review_writer_id foreign key(mem_id) references ban_mem(mem_id) ON DELETE CASCADE;

