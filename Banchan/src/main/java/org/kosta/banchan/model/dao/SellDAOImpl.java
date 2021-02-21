package org.kosta.banchan.model.dao;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SellDAOImpl implements SellDAO {

	@Resource
	private SqlSessionTemplate template;

	/**
	 * [지원] 판매음식 상세정보 조회 
	 * 판매음식의 상세정보를 조회한다. 
	 * 이 때 판매음식 정보 뿐 아니라 등록음식에 대한 정보도 함께 조회한다.
	 * 
	 * @param foodSellNo
	 * @return
	 */
	@Override
	public FoodSellVO getFoodSellDetailByNo(String foodSellNo) {
		return template.selectOne("food.getFoodSellDetailByNo", foodSellNo);
	}

	/**
	 * [지원] 판매음식등록 
	 * 판매할 음식을 등록한다.
	 * 
	 * @param foodSellVO
	 */
	@Override
	public void registerFoodSell(FoodSellVO foodSellVO) {
		template.insert("food.registerFoodSell", foodSellVO);
	}

	@Override
	public List<FoodSellVO> getFoodSellInfoByMemId(String memId) {
		return template.selectOne("food.getFoodSellInfoByMemId", memId);
	}
	
	/** [지원] 판매음식정보 수정
	 * 
	 */
	@Override
	public void editFoodSell(FoodSellVO foodSellVO) {
		template.update("food.editFoodSell", foodSellVO);
	}

	///////////////// start윤주//////////////////////////
	@Override
	public int getLeftQuantityByFoodSellNo(String foodSellNo) {
		  int sumQuantity = 0;
	      int preQuantity = 0;
	      try {
	         sumQuantity = template.selectOne("food.getsumQuantityByFoodSellNo", foodSellNo);
	         preQuantity = template.selectOne("food.getPreQuantityByFoodSellNo", foodSellNo);
	         int leftQuantity = preQuantity - sumQuantity;
	         if(leftQuantity<0) {
	            leftQuantity=0;
	            return leftQuantity;
	         }else
	            return leftQuantity;
	      } catch (NullPointerException e) {
	         sumQuantity = 0;
	         preQuantity = template.selectOne("food.getPreQuantityByFoodSellNo", foodSellNo);
	         int leftQuantity = preQuantity - sumQuantity;

	         if(String.valueOf(preQuantity) == null) {
	            System.out.println("preq:"+preQuantity);
	         }
	         return leftQuantity;
	      }
	}

	@Override
	public List<FoodVO> findFoodList(String kw) {
		return template.selectList("food.findFoodList", kw);
	}
	////////////////// end윤주//////////////////////////////

}