package org.kosta.banchan.model.dao;

import java.util.List;

import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.SellerVO;

public interface SellerDAO {
	//// 우정 start//////
	SellerVO selectSellerInfo(String id);

	List<FoodVO> selectFoodInfo(String id);

	//// 우정 end//////
	List<SellerVO> selectSellerTop3();
	
	/////////////start윤주/////////////////
	List<SellerVO> findSellerList(String kw);
	///////////////end윤주////////////////

}