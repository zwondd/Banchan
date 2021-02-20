package org.kosta.banchan.model.dao;

import java.util.List;

import org.kosta.banchan.model.vo.QuestionVO;


public interface QuestionDAO {
	
//start정훈
	//댓글 목록
	List<QuestionVO> commentList(String foodSellNo);
	//댓글 작성
	int commentInsert(QuestionVO qvo);
	//댓글 삭제
	int commentDelete(QuestionVO qvo);
	//댓글 수정
	int commentUpdate(QuestionVO qvo);
//end정훈


	

}