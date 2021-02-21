package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.TradeVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class FoodDAOImpl implements FoodDAO {

	@Resource
	private SqlSessionTemplate template;

	//////////////////// start 윤주//////////////////////////

	@Override
	public void orderFood(TradeVO tvo) {
		template.insert("food.orderFood", tvo);

	}
	////////////////// end 윤주//////////////////////////////

	/**
	 * [지원] 음식번호로 등록된 음식을 조회하는 메서드
	 * 
	 * @param foodNo
	 * @return
	 */
	@Override
	public FoodVO getFoodByNo(String foodNo) {
		return template.selectOne("food.getFoodByNo", foodNo);
	}

	/////////////////// start 우정//////////////////////////////
	@Override
	public List<FoodVO> getFoodListByMemId(String memId) {
		return template.selectList("food.getFoodListByMemId", memId);
	}

	@Override
	public List<FoodSellVO> getFoodSellInfoByMemId(HashMap<String, String> map) {
		return template.selectList("getFoodSellInfoByMemId", map);
	}

	@Override
	public int getAllFoodSellCountByMemId(String memId) {
		return template.selectOne("getAllFoodSellCountByMemId", memId);
	}
	
	@Override
	public int deleteConfirmAjax(String foodSellNo) {
		return template.selectOne("deleteConfirmAjax",foodSellNo);
	}
	
	@Override
	public void deleteFoodSell(String foodSellNo) {
		template.delete("deleteFoodSell",foodSellNo);
	}

	@Override
	public int totalFoodSellCountByMemId(String memId) {
		return template.selectOne("totalFoodSellCountByMemId",memId);
	}

	/////////////////// end 우정//////////////////////////////

	
	/**
	 * [영민] 카테고리 받아와서 음식등록 하는 페이지
	 */
	public void foodRegister(FoodVO fvo) {
		template.insert("food.foodRegister", fvo);
	}

	@Override
	public List<Map<String, Object>> allCategorySelect() {
		return template.selectList("food.allCategorySelect");
	}

	public FoodVO getFoodMemInfo(String foodNo) {
		return template.selectOne("food.getFoodMemInfo", foodNo);
	}

	public List<FoodVO> selectRegFoodByNo(String foodNo) {
		return template.selectList("food.selectRegFoodByNo", foodNo);
	}

	public void deleteRegFood(String foodNo) {
		template.delete("food.deleteRegFood", foodNo);
	}

	public void imgUpdateRegFood(FoodVO fvo) {
		template.update("food.imgUpdateRegFood", fvo);
	}

	public void noimgUpdateRegFood(FoodVO fvo) {
		template.update("food.noimgUpdateRegFood", fvo);
	}
	public List<FoodVO> selectFoodTop3() {
		return template.selectList("food.selectFoodTop3");
	}

	@Override
	public int getTotalFoodCount() {
		return template.selectOne("food.getTotalFoodCount");
	}

	@Override
	public int getTotalFoodCountByCategory(String category) {
		return template.selectOne("food.getTotalFoodCountByCategory",category);
	}

	@Override
	public List<FoodVO> selectAllCategoryFood(HashMap<String, String> paramMap) {
		return template.selectList("food.selectAllCategoryFood",paramMap);
	}

	@Override
	public List<FoodVO> selectCategoryFood(HashMap<String, String> paramMap) {
		return template.selectList("food.selectCategoryFood",paramMap);
	}
	

}