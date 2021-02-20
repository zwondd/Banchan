package org.kosta.banchan.model.service;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.dao.MemberDAO;
import org.kosta.banchan.model.dao.SellerDAO;
import org.kosta.banchan.model.vo.AddressVO;
import org.kosta.banchan.model.vo.Authority;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.MemberVO;
import org.kosta.banchan.model.vo.PagingBean;
import org.kosta.banchan.model.vo.PwQnaVO;
import org.kosta.banchan.model.vo.SellerVO;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberServiceImpl implements MemberService {

	@Resource
	private MemberDAO memberDAO;
	@Resource
	private SellerDAO sellerDAO;
	//비밀번호 암호화 객체 주입
	@Resource
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public MemberVO findMemberById(String id) {
		return memberDAO.findMemberById(id);
	}

	/*
	 * 권한 확인
	 */
	@Override
	public List<Authority> selectAuthorityByMemId(String id) {
		return memberDAO.selectAuthorityByMemId(id);
	}

	/*
	 * 아이디 체크
	 */
	@Override
	public int idcheck(String id) {
		return memberDAO.idcheck(id);
	}

	@Override
	public void deleteMember(String memId) {
		memberDAO.deleteMember(memId);
		memberDAO.deleteMemberAuth(memId);
	}

	@Override
	public int findPasswordCheck(MemberVO mvo) {
		return memberDAO.findPasswordCheck(mvo);
	}

	@Override
	public int findPasswordQnaCheck(MemberVO mvo) {
		return memberDAO.findPasswordQnaCheck(mvo);
	}
	/**
	 * 비밀번호 재설정
	 * 암호화 처리 해준다.
	 */
	@Override
	public void resetPassword(MemberVO mvo) {
		String encodePassword = passwordEncoder.encode(mvo.getPw());
		mvo.setPw(encodePassword);
		memberDAO.resetPassword(mvo);
	}

	/////////////////////// start 광태 메서드 ///////////////////////////////
	// 광태 회원가입 ajax id check
	@Override
	public String checkIdOnAjax(String id) {
		int count = memberDAO.checkIdOnAjax(id);
		return (count == 0) ? "ok" : "fail";
	}

	// 광태 비밀번호 찾기 질문 리스트
	@Override
	public List<PwQnaVO> getAllPwQnAList() {
		return memberDAO.getAllPwQnAList();
	}

	// 광태 회원가입 메소드
	@Transactional
	@Override
	public void registerMember(MemberVO memberVO) {

		// 비밀번호를 bcrypt 알고리즘으로 암호화
		String encodedPwd = passwordEncoder.encode(memberVO.getPw());
		memberVO.setPw(encodedPwd);

		// 주소 타입이 존재하는지 확인
		String addressNO = memberDAO.checkAddressNoByAddressAPI(memberVO);
		if (addressNO != null) {
			// memberVO안에 addressVO의 addressNo에 SET
			memberVO.getAddressVO().setAddressNo(addressNO);
		}
		// 주소 테이블 insert
		else if (addressNO == null) {
			// 시퀀스 이용하여 주소테이블에 insert ( 번호, api 주소, 위도,경도) ,
			// registerNewAddressInfo메서드 실행후 memberVO의 addressNo변수에는 insert시의 address_no값이
			// set 된다.
			memberDAO.registerNewAddressInfo(memberVO.getAddressVO());
		}

		// 멤버 테이블 insert
		// 전화번호 - 제거
		// String tempTel= memberVO.getTel();
		// memberVO.setTel(tempTel.replaceAll("-", ""));
		memberDAO.registerMember(memberVO);
		// 권한 테이블 insert
		memberDAO.registerMemberBasicAuth(memberVO);

	}
	/////////// start 위치기반 추천 메서드 ////////////////////

	public void getAllNearSellerListByAddress() {
		// 현재 로그인된 회원 아이디로 addressNO get
		// 멤버 테이블에서 addressNO 같은 회원들 List 로 get 후 return
		/*
		 * ??
		 */
	}

	@Override
	public List<SellerVO> getAllSameAddressSellerListByAddress(String addressNo) {
		return memberDAO.getAllSameAddressSellerListByAddress(addressNo);
	}

	private String cutAddressAPI(String addressAPI) {
		int first = addressAPI.indexOf(" ");
		String temp = addressAPI.substring(addressAPI.indexOf(" ") + 1, addressAPI.length());
		int second = temp.indexOf(" ");
		String temp2 = addressAPI.substring(0, first + second + 1);
		return temp2;
	}

	@Override
	public AddressVO getAddressAPIById(MemberVO memberVO) {
		return memberDAO.getAddressAPIById(memberVO);
	}

	@Override
	public List<AddressVO> getNearSellerAddressByAddressAPI(String addressAPI) {
		return memberDAO.getNearSellerAddressByAddressAPI(cutAddressAPI(addressAPI));
	}

	@Override
	public int getTotCountMarkerSellerList(String addressNo) {
		return memberDAO.getTotCountMarkerSellerList(addressNo);
	}

	@Override
	public ListVO<SellerVO> getMarkerSellerListByAddressNo(String addressNo, String pageNo) {
		ListVO<SellerVO> markerSellerList = new ListVO<SellerVO>();
		HashMap<String, Integer> paramMap = new HashMap<String, Integer>();

		PagingBean pagingBean = new PagingBean(Integer.parseInt(pageNo), 3, 3,
				memberDAO.getTotCountMarkerSellerList(addressNo));
		paramMap.put("startRowNumber", pagingBean.getStartRowNumber());
		paramMap.put("endRowNumber", pagingBean.getEndRowNumber());
		paramMap.put("addressNo", Integer.parseInt(addressNo.trim()));

		markerSellerList.setList(memberDAO.getMarkerSellerListByAddressNo(paramMap));
		markerSellerList.setPb(pagingBean);
		return markerSellerList;
	}
	/////////// end 위치기반 추천 메서드 ////////////////////
	/////////////////////// end 광태 메서드 ///////////////////////////////

	//////////////////// start 우정 메서드 ////////////////////////////
	@Override
	public SellerVO selectSellerInfo(String id) {
		return sellerDAO.selectSellerInfo(id);
	}

	@Override
	public List<FoodVO> selectFoodInfo(String id) {
		return sellerDAO.selectFoodInfo(id);
	}

	//////////////////// start 우정 메서드 ////////////////////////////

	/////////////////////// start 정훈 메서드 ///////////////////////////////
	// 정훈 main화면 top3 판매자 리스트 메서드
	@Override
	public List<SellerVO> selectSellerTop3() {
		List<SellerVO> list = sellerDAO.selectSellerTop3();
		for (int i = 0; i < list.size(); i++) {
			if (!(list.get(i).getSellerInfo().length() < 18)) {
				String str = list.get(i).getSellerInfo().substring(0, 18);
				list.get(i).setSellerInfo(str + "...");
			}
			if(!(list.get(i).getAddressVO().getAddressAPI().length() < 18)) {
				String str = list.get(i).getAddressVO().getAddressAPI().substring(0, 18);
				list.get(i).getAddressVO().setAddressAPI(str + "...");
			}
		}
		return list;
	}

	@Override
	public PwQnaVO findPwQnaNo(String pwQnaNo) {
		return memberDAO.findPwQnaNo(pwQnaNo);
	}

	@Override
	public SellerVO findMemberTypeById(String memId) {
		return memberDAO.findMemberTypeById(memId);
	}

	@Override
	public AddressVO findMemberAddressAPIById(String memId) {
		return memberDAO.findMemberAddressAPIById(memId);
	}

	@Transactional
	@Override
	public void editBuyerMemberService(MemberVO mvo) {
		// 비밀번호를 bcrypt 알고리즘으로 암호화
		String encodedPwd = passwordEncoder.encode(mvo.getPw());
		mvo.setPw(encodedPwd);

		// 주소 타입이 존재하는지 확인
		String addressNO = memberDAO.checkAddressNoByAddressAPIByUpdate(mvo);
		if (addressNO != null) {
			// memberVO안에 addressVO의 addressNo에 SET
			mvo.getAddressVO().setAddressNo(addressNO);
		}
		// 주소 테이블 insert
		else if (addressNO == null) {
			// 시퀀스 이용하여 주소테이블에 insert ( 번호, api 주소, 위도,경도) ,
			// registerNewAddressInfo메서드 실행후 memberVO의 addressNo변수에는 insert시의 address_no값이
			// set 된다.
			memberDAO.registerNewAddressInfoByUpdate(mvo.getAddressVO());
		}
		memberDAO.editMemberBuyer(mvo);
	}

	@Transactional
	@Override
	public void editSellerMemberService(SellerVO svo) {
		// 비밀번호를 bcrypt 알고리즘으로 암호화
		String encodedPwd = passwordEncoder.encode(svo.getPw());
		svo.setPw(encodedPwd);

		// 주소 타입이 존재하는지 확인
		String addressNO = memberDAO.checkAddressNoByAddressAPIByUpdate(svo);
		if (addressNO != null) {
			// memberVO안에 addressVO의 addressNo에 SET
			svo.getAddressVO().setAddressNo(addressNO);
		}
		// 주소 테이블 insert
		else if (addressNO == null) {
			// 시퀀스 이용하여 주소테이블에 insert ( 번호, api 주소, 위도,경도) ,
			// registerNewAddressInfo메서드 실행후 memberVO의 addressNo변수에는 insert시의 address_no값이
			// set 된다.
			memberDAO.registerNewAddressInfoByUpdate(svo.getAddressVO());
		}
		memberDAO.editMemberSellerInfoAndImage(svo);
		memberDAO.editMemberSeller(svo);
	}

	@Transactional
	@Override
	public void editSellerMemberNoImageService(SellerVO svo) {
		// 비밀번호를 bcrypt 알고리즘으로 암호화
		String encodedPwd = passwordEncoder.encode(svo.getPw());
		svo.setPw(encodedPwd);

		// 주소 타입이 존재하는지 확인
		String addressNO = memberDAO.checkAddressNoByAddressAPIByUpdate(svo);
		if (addressNO != null) {
			// memberVO안에 addressVO의 addressNo에 SET
			svo.getAddressVO().setAddressNo(addressNO);
		}
		// 주소 테이블 insert
		else if (addressNO == null) {
			// 시퀀스 이용하여 주소테이블에 insert ( 번호, api 주소, 위도,경도) ,
			// registerNewAddressInfo메서드 실행후 memberVO의 addressNo변수에는 insert시의 address_no값이
			// set 된다.
			memberDAO.registerNewAddressInfoByUpdate(svo.getAddressVO());
		}
		memberDAO.editMemberSellerNoImage(svo);
		memberDAO.editMemberSeller(svo);
	}

	/////////////////////// end 정훈 메서드 ///////////////////////////////

	/////////////////////// start 윤주 메서드 ///////////////////////////////

	@Override
	public int isSeller(String memId) {
		return memberDAO.isSeller(memId);
	}

	@Transactional
	@Override
	public void sellerRegister(SellerVO svo) { // 트랜젝션 처리
		memberDAO.insertAuth(new Authority(svo.getMemId(), "20"));
		memberDAO.sellerRegister(svo);
	}

	@Override
	public String getSellerNameByMemId(String memId) {
		return memberDAO.getSellerNameByMemId(memId);
	}
	@Override
	public List<SellerVO> findSellerList(String kw) {
		return sellerDAO.findSellerList(kw);
	}
	/////////////////////// end 윤주 메서드 ///////////////////////////////

	/////////////////////// start 지원 ///////////////////////////////
	@Override
	public MemberVO getBuyerInfo(String buyerId) {
		return memberDAO.getBuyerInfo(buyerId);
	}
	/////////////////////// end 지원 ///////////////////////////////

}