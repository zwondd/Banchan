package org.kosta.banchan.model.dao;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.AnswerVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class AnswerDAOImpl implements AnswerDAO {

   @Resource
    private SqlSessionTemplate template;
////////////////////start윤주/////////////////////
@Override
public void answerRegister(AnswerVO avo) {
	template.insert("feedback.answerRegister",avo);
}
@Override
public List<AnswerVO> getAllAnswerListByQuestNo(String questNo) {
	return template.selectList("feedback.getAllAnswerListByQuestNo",questNo);
}
@Override
public AnswerVO findAnswerByAnsNo(String ansNo) {
	return template.selectOne("feedback.findAnswerByAnsNo",ansNo);
}
@Override
public void answerDelete(String answerNo) {
	template.delete("feedback.answerDelete",answerNo);
}
////////////////////end윤주 //////////////////////

}