package org.kosta.banchan.model.dao;

import java.util.List;

import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;

public interface SellDAO {

	FoodSellVO getFoodSellDetailByNo(String foodSellNo);

	//////////// start윤주////////////
	int getLeftQuantityByFoodSellNo(String foodSellNo);
	List<FoodVO> findFoodList(String kw);
	//////////// end윤주///////////////

	void registerFoodSell(FoodSellVO foodSellVO);

	List<FoodSellVO> getFoodSellInfoByMemId(String memId);
	
	void editFoodSell(FoodSellVO foodSellVO);

}