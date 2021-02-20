
package org.kosta.banchan.model.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.vo.AddressVO;
import org.kosta.banchan.model.vo.Authority;
import org.kosta.banchan.model.vo.MemberVO;
import org.kosta.banchan.model.vo.PwQnaVO;
import org.kosta.banchan.model.vo.SellerVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Resource
	private SqlSessionTemplate template;

	@Override
	public List<MemberVO> selectMember() {
		return template.selectList("member.selectMember");
	}

	@Override
	public MemberVO findMemberById(String id) {
		return template.selectOne("member.findMemberById", id);
	}

	@Override
	public int idcheck(String id) {
		return template.selectOne("member.idcheck", id);
	}

	/*
	 * Security에서 인증시 사용
	 */
	@Override
	public List<Authority> selectAuthorityByMemId(String memId) {
		return template.selectList("member.selectAuthorityByMemId", memId);
	}

	/*
	 * Security를 위해 권한부여를 위해 사용
	 */
	@Override
	public void registerRole(Authority authority) {
		template.insert("member.registerRole", authority);
	}

	@Override
	public void deleteMember(String memId) {
		template.update("member.deleteMember", memId);
	}

	@Override
	public void deleteMemberAuth(String memId) {
		template.delete("member.deleteMemberAuth", memId);
	}

	@Override
	public int findPasswordCheck(MemberVO mvo) {
		return template.selectOne("member.findPasswordCheck", mvo);
	}

	@Override
	public int findPasswordQnaCheck(MemberVO mvo) {
		return template.selectOne("member.findPasswordQnaCheck", mvo);
	}

	@Override
	public void resetPassword(MemberVO mvo) {
		template.update("resetPassword", mvo);
	}

	/////////////////////// start 광태 메서드 ///////////////////////////////
	// 광태 ajax id check
	@Override
	public int checkIdOnAjax(String id) {
		return template.selectOne("member.checkIdOnAjax", id);
	}

	// 광태 비밀번호 찾기 질문 리스트
	@Override
	public List<PwQnaVO> getAllPwQnAList() {
		return template.selectList("member.getAllPwQnAList");
	}

	// 광태 주소타입 존재 체크
	@Override
	public String checkAddressNoByAddressAPI(MemberVO memberVO) {
		return template.selectOne("member.checkAddressNoByAddressAPI", memberVO);
	}

	// 광태 새로운 주소지 등록
	@Override
	public void registerNewAddressInfo(AddressVO addressVO) {
		template.insert("member.registerNewAddressInfo", addressVO);
	}

	// 광태 회원 등록
	@Override
	public void registerMember(MemberVO memberVO) {
		template.insert("member.registerMember", memberVO);
	}

	// 광태 회원가입시 권한 등록
	@Override
	public void registerMemberBasicAuth(MemberVO memberVO) {
		template.insert("member.registerMemberBasicAuth", memberVO);
	}

	/////////// start 위치기반 추천 메서드 ////////////////////

	// 회원 아이디로 addressNo 정보 받기
	public String findMemberAddressnoById(MemberVO memberVO) {
		return template.selectOne("member.findMemberAddressnoById", memberVO);
	}

	@Override
	public List<SellerVO> getAllSameAddressSellerListByAddress(String addressNo) {
		return template.selectList("member.getAllSameAddressSellerListByAddress", addressNo);
	}

	@Override
	public AddressVO getAddressAPIById(MemberVO memberVO) {
		return template.selectOne("member.getAddressAPIById", memberVO.getMemId());
	}

	@Override
	public List<AddressVO> getNearSellerAddressByAddressAPI(String addressAPI) {
		return template.selectList("member.getNearSellerAddressByAddressAPI", addressAPI);
	}

	@Override
	public int getTotCountMarkerSellerList(String addressNo) {
		return template.selectOne("member.getTotCountMarkerSellerList", addressNo);
	}

	@Override
	public List<SellerVO> getMarkerSellerListByAddressNo(HashMap<String, Integer> paramMap) {
		return template.selectList("member.getMarkerSellerListByAddressNo", paramMap);
	}
	/////////// end 위치기반 추천 메서드 ////////////////////
	/////////////////////// end 광태 메서드 ///////////////////////////////

	/////////////////////// start 정훈 메서드 ///////////////////////////////

	/////////////////////// 회원정보 수정 ///////////////////////////////

	// 질문답 찾아오기(정훈)
	@Override
	public PwQnaVO findPwQnaNo(String pwQnaNo) {
		return template.selectOne("member.findPwQnaNo", pwQnaNo);
	}

	// 정훈 업데이트용 주소타입 존재 체크
	@Override
	public String checkAddressNoByAddressAPIByUpdate(MemberVO memberVO) {
		return template.selectOne("member.checkAddressNoByAddressAPIByUpdate", memberVO);
	}

	// 정훈 업데이트용 새로운 주소지 등록
	@Override
	public void registerNewAddressInfoByUpdate(AddressVO addressVO) {
		template.update("member.registerNewAddressInfoByUpdate", addressVO);
	}

	// 회원정보수정-구매자(정훈)
	@Override
	public void editMemberBuyer(MemberVO memberVO) {
		template.update("member.editMemberBuyer", memberVO);
	}

	// 회원정보수정-판매자(정훈)
	@Override
	public void editMemberSeller(SellerVO svo) {
		template.update("member.editMemberSeller", svo);
	}

	// 회원정보수정-판매자-이미지없을 때(정훈)
	@Override
	public void editMemberSellerNoImage(SellerVO svo) {
		template.update("member.editMemberSellerNoImage", svo);
	}

	// 회원정보수정-판매자(이미지, 판매자정보)(정훈)
	@Override
	public void editMemberSellerInfoAndImage(SellerVO svo) {
		template.update("member.editMemberSellerInfoAndImage", svo);
	}

	// 회원이 판매자 인지 구매자인지 판별(정훈)
	@Override
	public SellerVO findMemberTypeById(String memId) {
		return template.selectOne("member.findMemberTypeById", memId);
	}

	// 주소정보 들고오기(정훈)
	@Override
	public AddressVO findMemberAddressAPIById(String memId) {
		return template.selectOne("member.findMemberAddressAPIById", memId);
	}

	/////////////////////// end 정훈 메서드 ///////////////////////////////
	/////////////////////// start 윤주 메서드 ///////////////////////////////

	@Override
	public int isSeller(String memId) {
		return template.selectOne("member.isSeller", memId);
	}

	@Override
	public void insertAuth(Authority authority) {
		template.insert("member.insertAuth", authority);

	}

	@Override
	public void sellerRegister(SellerVO svo) {
		template.insert("member.sellerRegister", svo);

	}

	@Override
	public String getSellerNameByMemId(String memId) {
		return template.selectOne("member.getSellerNameByMemId", memId);
	}
	/////////////////////// end 윤주 메서드 ///////////////////////////////
	/////////////////////// start 지원 메서드 ///////////////////////////////
	@Override
	public MemberVO getBuyerInfo(String buyerId) {
		return template.selectOne("member.getBuyerInfo", buyerId);
	}
	/////////////////////// end 지원 메서드 ///////////////////////////////

}