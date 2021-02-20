package org.kosta.banchan.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.kosta.banchan.model.dao.FoodDAO;
import org.kosta.banchan.model.dao.SellDAO;
import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.PagingBean;
import org.kosta.banchan.model.vo.TradeVO;
import org.springframework.stereotype.Service;

@Service
public class FoodServiceImpl implements FoodService {

	@Resource
	private FoodDAO foodDAO;
	@Resource
	private SellDAO sellDAO;

	/////////////////// start윤주/////////////////////////
	@Override
	public void orderFood(TradeVO tvo) {
		foodDAO.orderFood(tvo);
	}

	@Override
	public int getLeftQuantityByFoodSellNo(String foodSellNo) {
		return sellDAO.getLeftQuantityByFoodSellNo(foodSellNo);
	}

	@Override
	public List<FoodVO> findFoodList(String kw) {
		
		return sellDAO.findFoodList(kw);
	}
	/////////////////// end윤주////////////////////////

	/**
	 * [지원] 등록음식 상세정보 조회 
	 * 선택한 등록음식의 상세정보를 등록음식번호로 조회한다.
	 * 
	 */
	@Override
	public FoodVO getFoodByNo(String foodNo) {
		return foodDAO.getFoodByNo(foodNo);
	}

	/**
	 * [지원] 판매음식상세정보 조회 
	 * 판매등록한 판매음식의 상세정보를 조회한다. 
	 * 판매음식상세정보 뿐 아니라 등록음식의 정보도 함께 조회한다.
	 * 
	 */
	@Override
	public FoodSellVO getFoodSellDetailByNo(String foodSellNo) {
		FoodSellVO foodSellVO = sellDAO.getFoodSellDetailByNo(foodSellNo);
		return foodSellVO;
	}

	/**
	 * [지원] 판매음식등록 
	 * 선택한 등록음식을 판매하기 위해 판매음식등록한다.
	 * 
	 */
	@Override
	public void registerFoodSell(FoodSellVO foodSellVO) {
		sellDAO.registerFoodSell(foodSellVO);
	}

	/**
	 * [우정] 판매자페이지에서 음식리스트 조회 
	 * 판매가페이지에서 판매자가 등록한 음식을 조회한다.
	 */
	@Override
	public List<FoodVO> getFoodListByMemId(String memId) {
		return foodDAO.getFoodListByMemId(memId);
	}
	/**
	 * [우정] 판매음식있는지 check
	 */
	@Override
	public int deleteConfirmAjax(String foodSellNo) {
		return foodDAO.deleteConfirmAjax(foodSellNo);
	}
	/**
	 * [우정] 판매자페이지에서 판매음식리스트 조회 
	 * 판매가페이지에서 판매자가 등록한 판매 음식을 조회한다.
	 */
	@Override
	public ListVO<FoodSellVO> getFoodSellInfoByMemId(String memId, String pageNo) {
		int totalCount = foodDAO.getAllFoodSellCountByMemId(memId);
		PagingBean pagingBean = null;
		HashMap<String, String> paramMap = new HashMap<String, String>();
		if (pageNo == null)
			pagingBean = new PagingBean(totalCount);
		else
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));
		paramMap.put("startRowNumber", Integer.toString(pagingBean.getStartRowNumber()));
		paramMap.put("endRowNumber", Integer.toString(pagingBean.getEndRowNumber()));
		paramMap.put("memId", memId);

		return new ListVO<FoodSellVO>(foodDAO.getFoodSellInfoByMemId(paramMap), pagingBean);
	}
	/**
	 * [우정] 판매자페이지에서 판매음식리스트 조회 
	 * 판매가페이지에서 판매자가 등록한 판매 음식을 조회한다.
	 */
	@Override
	public void deleteFoodSell(String foodSellNo) {
			foodDAO.deleteFoodSell(foodSellNo);
	}
	
	/**
	 * [우정] 판매자의 판매중 음식 숫자를 보여준다
	 */
	@Override
	public int totalFoodSellCountByMemId(String memId) {
		return foodDAO.totalFoodSellCountByMemId(memId);
	}
//
	@Override
	public ListVO<FoodVO> selectCategoryFood(String category,String pageNo){
		int totalCount=0;
		if(category=="")
			totalCount= foodDAO.getTotalFoodCount();
		else
			totalCount=foodDAO.getTotalFoodCountByCategory(category);
		PagingBean pagingBean = null;
		HashMap<String, String> paramMap = new HashMap<String, String>();
		if (pageNo == null)
			pagingBean = new PagingBean(totalCount);
		else
			pagingBean = new PagingBean(totalCount, Integer.parseInt(pageNo));
		paramMap.put("startRowNumber", Integer.toString(pagingBean.getStartRowNumber()));
		paramMap.put("endRowNumber", Integer.toString(pagingBean.getEndRowNumber()));
		if(category!="")
			paramMap.put("category", category);
		if(category=="")
			return new ListVO<FoodVO>(foodDAO.selectAllCategoryFood(paramMap), pagingBean);
		else
			return new ListVO<FoodVO>(foodDAO.selectCategoryFood(paramMap), pagingBean);
	}
	/*
	 * [영민] 카테고리 받아와서 음식등록
	 */

	@Override
	public void foodRegister(FoodVO fvo) {
		foodDAO.foodRegister(fvo);
	}
	

	@Override
	public List<Map<String, Object>> allCategorySelect() {
		return foodDAO.allCategorySelect();
	}

	public FoodVO getFoodMemInfo(String foodNo) {
		return foodDAO.getFoodMemInfo(foodNo);
	}

	public List<FoodVO> selectRegFoodByNo(String foodNo) {
		return foodDAO.selectRegFoodByNo(foodNo);
	}

	public void deleteRegFood(String foodNo) {
		foodDAO.deleteRegFood(foodNo);
	}

	public void imgUpdateRegFood(FoodVO fvo) {
		foodDAO.imgUpdateRegFood(fvo);
	}

	public void noimgUpdateRegFood(FoodVO fvo) {
		foodDAO.noimgUpdateRegFood(fvo);
	}
	public List<FoodVO> selectFoodTop3(){
		List<FoodVO> list=foodDAO.selectFoodTop3();
		for(int i=0; i< list.size(); i++) {
			if(!(list.get(i).getFoodDe().length() < 25)) {
				String foodStr=list.get(i).getFoodDe().substring(0, 25);  
				list.get(i).setFoodDe(foodStr + "...");
			}
		}
		return list;
	}
	/* [영민] End */
	
	/** [지원] 판매음식 수정
	 * 
	 */
	@Override
	public void editFoodSell(FoodSellVO foodSellVO) {
		sellDAO.editFoodSell(foodSellVO);
	}
}