package org.kosta.banchan.model.service;

import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.TradeVO;

public interface TradeService {

	//////////////// start 지원///////////////////
	// List<TradeVO> getSellerTradeListByFoodSellNo(String foodSellNo);
	void completeTrade(String tradeNo);

	ListVO<TradeVO> getAllSellerTradeList(String sellerId, String pageNo);
	//////////////// end 지원///////////////////

	//////////////// start윤주///////////////////
	ListVO<TradeVO> getTradeListByMemId(String memId,String pageNo);
	//////////////// end윤주////////////////////

	// 우정
	int getTradeCountByFoodSellNo(String foodSellNo);

	ListVO<TradeVO> getSellerTradeListByFoodSellNo(String foodSellNo, String foodNo);

	int getAllSellerTradeCount(String sellerId);


}