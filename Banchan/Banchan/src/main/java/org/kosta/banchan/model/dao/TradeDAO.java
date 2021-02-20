package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;

import org.kosta.banchan.model.vo.TradeVO;

public interface TradeDAO {

	List<TradeVO> getSellerTradeListByFoodSellNo(HashMap<String, Integer> paramMap);

	void completeTrade(String tradeNo);

	List<TradeVO> getAllSellerTradeList(HashMap<String, String> paramMap);

	//////////////////// Start 윤주 //////////////////////////
	List<TradeVO> getTradeListByMemId(HashMap<String, String> paramMap);
	int getAllTradeCountByMemId(String memId);
	//////////////////// END 윤주 //////////////////////////

	int getTradeCountByFoodSellNo(String foodSellNo);

	int getAllSellerTradeCount(String sellerId);

}