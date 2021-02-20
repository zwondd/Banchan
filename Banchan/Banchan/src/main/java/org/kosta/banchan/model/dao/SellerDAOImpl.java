package org.kosta.banchan.model.dao;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.SellerVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class SellerDAOImpl implements SellerDAO {

	@Resource
	private SqlSessionTemplate template;

	// 우정 seller+member+address 정보 받아오기
	@Override
	public SellerVO selectSellerInfo(String id) {
		return template.selectOne("member.selectSellerInfo", id);
	}

	// TOP3 뽑아오기(정훈)
	@Override
	public List<SellerVO> selectSellerTop3() {
		List<SellerVO> list = template.selectList("member.selectSellerTop3");
		return list;
	}

	@Override
	public List<FoodVO> selectFoodInfo(String id) {
		return template.selectList("member.selectFoodInfo", id);
	}
/////////////////////start윤주///////////////////////////
	@Override
	public List<SellerVO> findSellerList(String kw) {
		return template.selectList("member.findSellerList",kw);
	}
///////////////////////end윤주///////////////////////////
}