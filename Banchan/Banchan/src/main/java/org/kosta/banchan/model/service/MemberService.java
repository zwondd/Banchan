package org.kosta.banchan.model.service;

import java.util.List;

import org.kosta.banchan.model.vo.AddressVO;
import org.kosta.banchan.model.vo.Authority;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.MemberVO;
import org.kosta.banchan.model.vo.PwQnaVO;
import org.kosta.banchan.model.vo.SellerVO;

public interface MemberService {

	MemberVO findMemberById(String id);

	/////////////////////// start 정훈 메서드 ///////////////////////////////
	List<Authority> selectAuthorityByMemId(String id);

	PwQnaVO findPwQnaNo(String pwQnaNo);

	SellerVO findMemberTypeById(String memId);

	void editSellerMemberService(SellerVO svo);

	AddressVO findMemberAddressAPIById(String memId);

	void editBuyerMemberService(MemberVO mvo);

	void editSellerMemberNoImageService(SellerVO svo);
	/////////////////////// end 정훈 메서드 ///////////////////////////////

	int idcheck(String id);

	void deleteMember(String memId);

	int findPasswordCheck(MemberVO mvo);

	int findPasswordQnaCheck(MemberVO mvo);

	void resetPassword(MemberVO mvo);

	/////////////////////// start 광태 메서드 ///////////////////////////////
	// 광태 ajax id check
	String checkIdOnAjax(String id);

	// 광태 비밀번호 찾기 질문 리스트
	List<PwQnaVO> getAllPwQnAList();

	// 광태 회원가입 메소드
	void registerMember(MemberVO memberVO);

	AddressVO getAddressAPIById(MemberVO memberVO);

	List<AddressVO> getNearSellerAddressByAddressAPI(String addressAPI);

	// maker paging
	int getTotCountMarkerSellerList(String addressNo);

	ListVO<SellerVO> getMarkerSellerListByAddressNo(String addressNo, String pageNo);
	/////////////////////// end 광태 메서드 ///////////////////////////////

	/////////////////////// start 윤주 메서드 ///////////////////////////////

	int isSeller(String memId);

	void sellerRegister(SellerVO svo);

	String getSellerNameByMemId(String memId);
	
	List<SellerVO> findSellerList(String kw);

	/////////////////////// end 윤주 메서드 ///////////////////////////////

	List<SellerVO> selectSellerTop3();

	List<SellerVO> getAllSameAddressSellerListByAddress(String addressNo);

	/////////////////////// start 우정 메서드 ///////////////////////////////
	SellerVO selectSellerInfo(String id);

	List<FoodVO> selectFoodInfo(String id);
	/////////////////////// end 우정 메서드 ///////////////////////////////

	/////////////////////// start 지원 메서드 ///////////////////////////////
	MemberVO getBuyerInfo(String buyerId);
	/////////////////////// end 지원 메서드 ///////////////////////////////

}