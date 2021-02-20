package org.kosta.banchan.model.dao;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.QuestionVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class QuestionDAOImpl implements QuestionDAO {

   @Resource
    private SqlSessionTemplate template;
//start정훈
   //댓글 목록
   @Override
   	public List<QuestionVO> commentList(String foodSellNo){
		return template.selectList("feedback.commentList",foodSellNo);

   	}
   //댓글 작성
   @Override
    public int commentInsert(QuestionVO qvo) {
		 return template.insert("feedback.commentInsert", qvo);
    }
   //댓글 수정
   @Override
    public int commentUpdate(QuestionVO qvo) {
		return template.update("feedback.commentUpdate", qvo);
    	
    }
   //댓글 삭제
   @Override
    public int commentDelete(QuestionVO qvo) {
		return template.delete("feedback.commentDelete", qvo);
    	
    }
//end정훈
}