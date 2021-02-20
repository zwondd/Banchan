package org.kosta.banchan.model.service;

import java.util.List;

import org.kosta.banchan.model.vo.AnswerVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.QuestionVO;
import org.kosta.banchan.model.vo.ReviewVO;

public interface FeedbackService {
	///////////// start윤주////////////////

	void reviewRegister(ReviewVO rvo, String memId,String foodNo);

	ListVO<ReviewVO> getReviewListByFoodSellNo(String foodSellNo,String pageNo);
	//답변
	void answerRegister(AnswerVO avo);
	AnswerVO findAnswerByAnsNo(String ansNo);
	List<AnswerVO> getAllAnswerListByQuestNo(String questNo);
	void answerDelete(String answerNo);

	/////////////// end윤주/////////////////

	ListVO<ReviewVO> getReviewListByFoodNo(String foodNo, String pageNo);

	///////////// start정훈////////////////
	//댓글 목록
	List<QuestionVO> commentList(String foodSellNo);
	//댓글 작성
	int commentInsert(QuestionVO qvo);
	//댓글 수정
	int commentUpdate(QuestionVO qvo);
	//댓글 삭제
	int commentDelete(QuestionVO qvo);
	///////////// end정훈////////////////

}