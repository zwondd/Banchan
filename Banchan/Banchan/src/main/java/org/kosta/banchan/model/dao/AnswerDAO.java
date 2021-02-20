package org.kosta.banchan.model.dao;

import java.util.List;

import org.kosta.banchan.model.vo.AnswerVO;

public interface AnswerDAO {
	/////////////start윤주///////////////
	void answerRegister(AnswerVO avo);
	AnswerVO findAnswerByAnsNo(String ansNo);
	List<AnswerVO> getAllAnswerListByQuestNo(String questNo);
	void answerDelete(String answerNo);
	/////////////end윤주////////////////

}