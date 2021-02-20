package org.kosta.banchan.model.service;

import java.util.HashMap;

import javax.annotation.Resource;

import org.kosta.banchan.model.dao.SellDAO;
import org.kosta.banchan.model.dao.TradeDAO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.PagingBean;
import org.kosta.banchan.model.vo.TradeVO;
import org.springframework.stereotype.Service;

@Service
public class TradeServiceImpl implements TradeService {

	@Resource
	private TradeDAO tradeDAO;
	@Resource
	private SellDAO sellDAO;

	/**
	 * [지원] 판매자 구매요청리스트 
	 * 해당 판매음식에 대한 구매요청 리스트 조회 
	 * [우정] pagingBean 추가
	 */
	@Override
	public ListVO<TradeVO> getSellerTradeListByFoodSellNo(String foodSellNo, String pageNo) {
		int totalCount = tradeDAO.getTradeCountByFoodSellNo(foodSellNo);
		PagingBean pagingBean = null;
		HashMap<String, Integer> paramMap = new HashMap<String, Integer>();
		if (pageNo == null)
			pagingBean = new PagingBean(totalCount);
		else
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));

		paramMap.put("startRowNumber", pagingBean.getStartRowNumber());
		paramMap.put("endRowNumber", pagingBean.getEndRowNumber());
		paramMap.put("foodSellNo", Integer.parseInt(foodSellNo));

		// start,end,foodSell no를 저장한 map를 param으로
		return new ListVO<TradeVO>(tradeDAO.getSellerTradeListByFoodSellNo(paramMap), pagingBean);
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
		tradeDAO.completeTrade(tradeNo);
	}

	/**
	 * [지원] 판매자 전체 거래내역 조회 
	 * 해당 판매자가 거래한 모든 거래내역을 조회한다. 
	 * 구매자의 정보도 함께 조회하여 보낸다.
	 * 
	 * @param sellerId
	 * @return
	 */
	@Override
	public ListVO<TradeVO> getAllSellerTradeList(String sellerId, String pageNo) {
		int totalPostCount = tradeDAO.getAllSellerTradeCount(sellerId); // 판매자 아이디에 해당하는 총 거래내역 수
		PagingBean pb = null;
		
		if (pageNo == null)
			pb = new PagingBean(totalPostCount);
		else
			pb = new PagingBean(totalPostCount, Integer.parseInt(pageNo));

		// 해당 jsp 페이지의 페이지당 게시물 개수와 페이지그룹 개수 설정
		pb.setPostCountPerPage(10); 
		pb.setPageCountPerPageGroup(5);

		HashMap<String, String> paramMap = new HashMap<String, String>();
		paramMap.put("sellerId", sellerId);
		paramMap.put("startRowNumber", String.valueOf(pb.getStartRowNumber()));
		paramMap.put("endRowNumber", String.valueOf(pb.getEndRowNumber()));

		// db에서 가져온 리스트와 PagingBean으로 ListVO생성
		ListVO<TradeVO> lvo = new ListVO<TradeVO>(tradeDAO.getAllSellerTradeList(paramMap), pb);
		return lvo;
	}

	/////////////////////// start윤주////////////////////////////////
	@Override
	public ListVO<TradeVO> getTradeListByMemId(String memId, String pageNo) {
		int totalCount = tradeDAO.getAllTradeCountByMemId(memId);
		PagingBean pagingBean = null;
		HashMap<String, String> paramMap = new HashMap<String, String>();
		if (pageNo == null) {
			pagingBean = new PagingBean(totalCount);
		} else {
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));
		}
		pagingBean.setPostCountPerPage(10);

		paramMap.put("startRowNumber",String.valueOf(pagingBean.getStartRowNumber()));
		paramMap.put("endRowNumber",String.valueOf(pagingBean.getEndRowNumber()));
		paramMap.put("memId", memId);
		// start,end,foodSell no를 저장한 map를 param으로
		return new ListVO<TradeVO>(tradeDAO.getTradeListByMemId(paramMap),pagingBean);
	}
	
	/////////////////////// end윤주///////////////////////////////////

	// 우정
	@Override
	public int getTradeCountByFoodSellNo(String foodSellNo) {
		return tradeDAO.getTradeCountByFoodSellNo(foodSellNo);
	}

	/**
	 * [지원] 판매자 전체거내애겨 개수 조회
	 * 
	 * @param sellerId
	 * @return
	 */
	@Override
	public int getAllSellerTradeCount(String sellerId) {
		return tradeDAO.getAllSellerTradeCount(sellerId);
	}

	

}