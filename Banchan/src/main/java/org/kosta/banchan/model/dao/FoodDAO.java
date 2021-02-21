package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.kosta.banchan.model.vo.FoodSellVO;
//github.com/ryuhyg/Banchan.git
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.TradeVO;

public interface FoodDAO {
	/////////////////// start윤주/////////////////////////
	void orderFood(TradeVO tvo);
	/////////////////// end윤주//////////////////////////

	FoodVO getFoodByNo(String foodNo);

	List<FoodVO> getFoodListByMemId(String memId);

	void foodRegister(FoodVO fvo);

	List<Map<String, Object>> allCategorySelect();

	FoodVO getFoodMemInfo(String foodNo);

	List<FoodVO> selectRegFoodByNo(String foodNo);

	void deleteRegFood(String foodNo);

	void imgUpdateRegFood(FoodVO fvo);

	void noimgUpdateRegFood(FoodVO fvo);

	List<FoodSellVO> getFoodSellInfoByMemId(HashMap<String, String> map);

	int getAllFoodSellCountByMemId(String memId);

	List<FoodVO> selectFoodTop3();

	int deleteConfirmAjax(String foodSellNo);

	void deleteFoodSell(String foodSellNo);

	int totalFoodSellCountByMemId(String memId);

	int getTotalFoodCount();

	int getTotalFoodCountByCategory(String category);

	List<FoodVO> selectAllCategoryFood(HashMap<String, String> paramMap);

	List<FoodVO> selectCategoryFood(HashMap<String, String> paramMap);

	

}