package org.kosta.banchan.model.service;

import java.util.List;
import java.util.Map;

import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.TradeVO;

public interface FoodService {
	/////////////////// start윤주/////////////////////////
	void orderFood(TradeVO tvo);

	int getLeftQuantityByFoodSellNo(String foodSellNo);
	
	List<FoodVO> findFoodList(String kw);

	/////////////////// end윤주//////////////////////////

	FoodVO getFoodByNo(String foodNo);

	FoodSellVO getFoodSellDetailByNo(String foodSellNo);


	void registerFoodSell(FoodSellVO foodSellVO);

	//////// 영민 start /////////
	void foodRegister(FoodVO fvo);

	List<Map<String, Object>> allCategorySelect();
	//////// 영민 end /////////

	FoodVO getFoodMemInfo(String foodNo);

	List<FoodVO> selectRegFoodByNo(String foodNo);

	void deleteRegFood(String foodNo);

	void imgUpdateRegFood(FoodVO fvo);

	void noimgUpdateRegFood(FoodVO fvo);

	////////우정 start /////////
	ListVO<FoodSellVO> getFoodSellInfoByMemId(String memId, String pageNo);

	List<FoodVO> selectFoodTop3();
	
	int deleteConfirmAjax(String foodSellNo);

	List<FoodVO> getFoodListByMemId(String memId);

	void deleteFoodSell(String foodSellNo);
	
	int totalFoodSellCountByMemId(String memId);
	////////우정 end /////////

	void editFoodSell(FoodSellVO foodSellVO);

	ListVO<FoodVO> selectCategoryFood(String category,String pageNo);
	




}