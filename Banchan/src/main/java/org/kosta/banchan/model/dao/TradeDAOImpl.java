package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.TradeVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class TradeDAOImpl implements TradeDAO {

	@Resource
	private SqlSessionTemplate template;

	/**
	 * [지원] 판매자 구매요청리스트 
	 * 해당 판매음식에 대한 구매요청 리스트 조회
	 */
	@Override
	public List<TradeVO> getSellerTradeListByFoodSellNo(HashMap<String, Integer> paramMap) {
		return template.selectList("trade.getSellerTradeListByFoodSellNo", paramMap);
	}

	/**
	 * [지원] 판매자 거래완료확인 
	 * 실제 거래가 완료된 후 거래완료 확인을 한다. 
	 * 판매자가 거래완료 버튼을 누르면 trade 테이블의 해당
	 * trade_no 에 대한 tr_status가 '거래완료'로 변경된다.
	 * 
	 * @param tradeNo
	 */
	@Override
	public void completeTrade(String tradeNo) {
		template.update("trade.completeTrade", tradeNo);
	}

	/**
	 * [지원] 판매자 전체거래내역조회 
	 * 로그인한 판매자 아이디에 해당하는 전체 거래내역을 조회한다.
	 * 
	 * @param sellerId
	 * @return
	 */
	@Override
	public List<TradeVO> getAllSellerTradeList(HashMap<String, String> paramMap) {
		return template.selectList("trade.getAllSellerTradeList", paramMap);
	}

	////////////////////// start 윤주//////////////////////////
	@Override
	public List<TradeVO> getTradeListByMemId(HashMap<String, String> paramMap) {
		return template.selectList("trade.getTradeListByMemId", paramMap);
	}
	public int getAllTradeCountByMemId(String memId) {
		return template.selectOne("trade.getAllTradeCountByMemId",memId);
	}
	////////////////////// end 윤주/////////////////////////////

	// 우정
	@Override
	public int getTradeCountByFoodSellNo(String foodSellNo) {
		return template.selectOne("trade.getTradeCountByFoodSellNo", foodSellNo);

	}

	/**
	 * [지원] 판매자 전체거래내역 개수 조회
	 * 
	 */
	@Override
	public int getAllSellerTradeCount(String sellerId) {
		return template.selectOne("trade.getAllSellerTradeCount", sellerId);
	}

}