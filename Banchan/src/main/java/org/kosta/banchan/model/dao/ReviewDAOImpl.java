package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.ReviewVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class ReviewDAOImpl implements ReviewDAO {
	@Resource
	private SqlSessionTemplate template;
	
	
	/*
	 * [우정]
	 * Food 평정 update
	 */
	
	@Override
	public void updateFoodScore(String foodNo) {
		template.update("feedback.updateFoodScore", foodNo);
	}
	/////////////// start윤주//////////////////////////
	@Override
	public void reviewRegister(ReviewVO rvo) {
		template.insert("feedback.reviewRegister", rvo);
	}

	@Override
	public void updateSellerScore(String memId) {
		template.update("feedback.updateSellerScore", memId);
	}
	@Override
	public List<ReviewVO> getReviewListByFoodSellNo(HashMap<String, String> paramMap) {
		return template.selectList("feedback.getReviewListByFoodSellNo", paramMap);

	}
	@Override
	public int getAllReviewCountByFoodSellNo(String foodSellNo) {
		return template.selectOne("feedback.getAllReviewCountByFoodSellNo",foodSellNo);
	}
	//////////////// end윤주///////////////////////////

	//////////////// start지원///////////////////////////
	
	/** [지원] 등록음식 후기 리스트
	 * 등록음식 상세페이지에서 해당 음식에 관한 후기 리스트 조회 
	 * 페이징빈 적용
	 * 
	 */
	@Override
	public List<ReviewVO> getReviewListByFoodNo(HashMap<String, String> paramMap){
		return template.selectList("feedback.getReviewListByFoodNo", paramMap);
	}
	/** [지원] 등록음식에 해당하는 후기 개수 조회
	 * 
	 */
	@Override
	public int getAllReviewCountByFoodNo(String foodNo) {
		return template.selectOne("feedback.getAllReviewCountByFoodNo",foodNo);
	}
	//////////////// end지원///////////////////////////

}











