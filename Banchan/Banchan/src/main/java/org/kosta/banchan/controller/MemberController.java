package org.kosta.banchan.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.kosta.banchan.model.service.FoodService;
import org.kosta.banchan.model.service.MemberService;
import org.kosta.banchan.model.vo.AddressVO;
import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.MemberVO;
import org.kosta.banchan.model.vo.PwQnaVO;
import org.kosta.banchan.model.vo.SellerVO;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class MemberController { 
	@Resource
	private MemberService memberService;
	@Resource
	private FoodService foodService;
	@Resource
	private BCryptPasswordEncoder passwordEncoder;

	Logger logger = Logger.getLogger(this.getClass());


	///////////////////////////////////// 향걸 start////////////////////////////////////
	
	@RequestMapping("loginView.do")
	public String loginView() {
		return "member/loginView.tiles";
	}
	
	@RequestMapping("registerView.do")
	public String registerView() {
		return "member/registerView.tiles";
	}
	
	@RequestMapping("login_fail.do")
	public String loginFail() {
		return "member/login_fail";
	}

	/**
	 * 회원탈퇴
	 * 로그인한 회원아이디를 받아서 회원탈퇴 처리 한다.
	 * @param memId
	 * @return
	 */
	@RequestMapping(value = "deleteMember.do", method = RequestMethod.POST)
	public String deleteMember(String memId) {
		memberService.deleteMember(memId);
		return "redirect:member/deleteMember_result.do";
	}

	/**
	 * 비밀번호 찾기 아이디,이름,전화번호 확인
	 * 아이디와 이름과 전화번호가 일치하는지 확인하여 질문답변 페이지로 넘어간다.
	 * @param id
	 * @param name
	 * @param telNo
	 * @param model
	 * @return
	 */
	@RequestMapping(value = "findPasswordCheck.do", method = RequestMethod.POST) //
	public String findPasswordCheck(String id, String name, String telNo, Model model) {
		MemberVO mvo = new MemberVO(id, name, telNo);
		int idCheck = memberService.findPasswordCheck(mvo);// 아이디 체크
		List<PwQnaVO> list = memberService.getAllPwQnAList();// 질문 목록 가져오기
		if (idCheck != 0) {
			model.addAttribute("mvo", mvo);
			model.addAttribute("qnalist", list);
			return "member/findPassword_ok.tiles";
		} else {
			return "member/findPassword_fail";
		}
	}

	/**
	 * 비밀번호 찾기 질문,답변 확인
	 * 아이디에 맞는 질문과 답변인지 확인하고 비밀번호 재설정창으로 넘어간다.
	 * @param id
	 * @param name
	 * @param question
	 * @param answer
	 * @param model
	 * @return
	 */
	@RequestMapping("findPasswordQna.do")
	public String findPasswordQna(String id, String name, String question, String answer, Model model) {
		MemberVO mvo = new MemberVO(id, name, question, answer);
		int qnaCheck = memberService.findPasswordQnaCheck(mvo);
		if (qnaCheck != 0) {
			return "redirect:findPasswordResult.do?id="+id;
		} else {
			return "member/findPasswordResult_fail";
		}
	}
	@RequestMapping("findPasswordResult.do")
	public String findPasswordResult(String id,Model model) {
		model.addAttribute("memId", id);
		return "member/findPasswordResult_ok.tiles";
	}

	/**
	 * 비밀번호 재설정
	 * 비밀번호를 다시 설정해준다.
	 * @param id
	 * @param password
	 * @return
	 */
	@RequestMapping(value = "resetPassword.do", method = RequestMethod.POST)
	@ResponseBody
	public String resetPassword(String id, String password) {
		MemberVO mvo = new MemberVO();
		mvo.setMemId(id);
		mvo.setPw(password);
		memberService.resetPassword(mvo);
		return "ok";
	}

	//////////////////////// END 향걸 /////////////////////////////////////
	/////////////////////// start 광태 메서드 ///////////////////////////////
	// 광태 Ajax id check
	@RequestMapping("checkIdOnAjax.do")
	@ResponseBody
	public String checkIdOnAjax(String id) {
		return memberService.checkIdOnAjax(id);
	}

	@RequestMapping("member/registerView.do")
	public String getAllPwQnAList(Model model) {

		List<PwQnaVO> pwQnaList = memberService.getAllPwQnAList();

		// request에 set해서 비밀번호 찾기 질문 리스트를 보냄.
		model.addAttribute("pwQnaList", pwQnaList);
		//logger.debug("인터셉터 테스트 ");
		return "member/registerView.tiles";
	}

	@RequestMapping(value = "registerMember.do", method = RequestMethod.POST)
	public String registerMember(MemberVO memberVO) {
		
		memberService.registerMember(memberVO);

		return "redirect:member/registerMember_ok.do";
	}

	/////////////// start 위치기반//////////
	@RequestMapping("locationServicePage.do")
	public String locationServicePage(Model model, Authentication authentication) {

		List<AddressVO> list = null;

		// 회원정보 수정위해 Spring Security 세션 회원정보를 반환받는다
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
			AddressVO avo = new AddressVO();
			avo.setAddressAPI("경기도 성남시 분당구 삼평동 대왕판교로 660");
			avo.setLatitude(37.4008198);
			avo.setLongitude(127.10651510000002);
			model.addAttribute("addressVO", avo);
			list = memberService.getNearSellerAddressByAddressAPI(avo.getAddressAPI());
		} else {
			MemberVO mvo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			mvo.setAddressVO(memberService.getAddressAPIById(mvo));
			list = memberService.getNearSellerAddressByAddressAPI(mvo.getAddressVO().getAddressAPI());
			model.addAttribute("addressVO", mvo.getAddressVO());
		}
		model.addAttribute("list", list);
		return "member/locationServicePage.tiles";

	}

	@RequestMapping("searchLocationByService.do")
	public String searchLocationByService(Model model, AddressVO addressVO) {
		List<AddressVO> list = null;
		list = memberService.getNearSellerAddressByAddressAPI(addressVO.getAddressAPI());
		model.addAttribute("addressVO", addressVO);
		model.addAttribute("list", list);
		return "member/locationServicePage.tiles";
	}

	@ResponseBody
	@RequestMapping("getMarkerSellerListOnAjax.do")
	public ListVO<SellerVO> getMarkerSellerListOnAjax(String addressNo,String pageNo) {
		if(addressNo!=null && pageNo==null) {
			return memberService.getMarkerSellerListByAddressNo(addressNo, "1");
		}else {
			return memberService.getMarkerSellerListByAddressNo(addressNo, pageNo);
		}

	}
	

	////////////// end 위치기반 ///////////
	/////////////////////// end 광태 메서드 ///////////////////////////////

	/////////////////////// start 정훈 메서드 ///////////////////////////////
	// 이달의 주부 Top3 리스트
	@RequestMapping("selectSellerTop3.do")
	public String selectSellerTop3(Model model) {
		List<SellerVO> list = memberService.selectSellerTop3();
		/* [영민] 인기 Top3 음식  메서드*/
		List<FoodVO> flist=foodService.selectFoodTop3();
			model.addAttribute("list", list);
			model.addAttribute("flist", flist);
		return "home.tiles";
	}

	// 회원수정페이지로 -> 판매자, 구매자
	@RequestMapping("editMemberView.do")
	public String editMemberView(Model model, String pwQnaNo, String memId) {
		List<PwQnaVO> pwQnaList = memberService.getAllPwQnAList(); // 질문리스트
		AddressVO avo = memberService.findMemberAddressAPIById(memId); // 주소찾기
		PwQnaVO pvo = memberService.findPwQnaNo(pwQnaNo); // 질문찾기
		SellerVO svo = memberService.findMemberTypeById(memId); // 회원타입 검색
		// 회원 타입 검색해서 판매자와 구매자로 분기
		if (svo != null) {
			model.addAttribute("svo", svo);
			model.addAttribute("pvo", pvo);
			model.addAttribute("avo", avo);
			model.addAttribute("pwQnaList", pwQnaList);
			return "member/editSellerMemberView.tiles"; // 판매자 회원수정 페이지로...
		} else {
			model.addAttribute("pvo", pvo);
			model.addAttribute("avo", avo);
			model.addAttribute("pwQnaList", pwQnaList);
			return "member/editBuyerMemberView.tiles"; // 구매자 회원수정 페이지로...
		}
	}

	// 회원수정-구매자
	@Secured("ROLE_BUYER")
	@RequestMapping(value = "editBuyerMember.do", method = RequestMethod.POST)
	public String editBuyerMember(MemberVO mvo) {
		//System.out.println("mvo:"+mvo);
		// security 세션정보를 셋팅해줘야 됨.
		MemberVO mvoBuyerMember = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal(); // security
																													// 세션
																													// 정보(수정전)
		memberService.editBuyerMemberService(mvo); // update
		mvoBuyerMember.setPw(mvo.getPw()); // mvoBuyerMember에 업데이트 된 값 셋팅 (웹페이지에 갱신된 정보를 표현하기 위함)
		mvoBuyerMember.setMemName(mvo.getMemName()); // 안그러면 로그아웃했다가 다시 로그인해야 수정된 정보가 출력됨
		mvoBuyerMember.setBirth(mvo.getBirth());
		mvoBuyerMember.setTel(mvo.getTel());
		mvoBuyerMember.setAddressDe(mvo.getAddressDe());
		mvoBuyerMember.setPwAnswer(mvo.getPwAnswer());
		mvoBuyerMember.setPwQnaNo(mvo.getPwQnaNo());

		return "redirect:member/editMember_ok.do";
	}

	// 회원수정-판매자
	@Secured("ROLE_SELLER")
	@RequestMapping(value = "editSellerMember.do", method = RequestMethod.POST)
	public String editMember(SellerVO svo, HttpServletRequest request, Model model) {
		uploadPath = request.getSession().getServletContext().getRealPath("/resources/images/");
		File uploadDir = new File(uploadPath);
		if (uploadDir.exists() == false)
			uploadDir.mkdirs();
		MultipartFile file = svo.getUploadImage();// 파일
		if (file != null && file.isEmpty() == false) {
			File uploadFile = new File(uploadPath + file.getOriginalFilename());
			try {
				file.transferTo(uploadFile);// 실제 디렉토리로 파일을 저장한다
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		MemberVO mvoSellerMember = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		String imageName = (String) file.getOriginalFilename();
		if (imageName.equals("null") || imageName.equals("")) {

			memberService.editSellerMemberNoImageService(svo); // 업데이트
			mvoSellerMember.setPw(svo.getPw());
			mvoSellerMember.setMemName(svo.getMemName());
			mvoSellerMember.setBirth(svo.getBirth());
			mvoSellerMember.setTel(svo.getTel());
			mvoSellerMember.setAddressDe(svo.getAddressDe());
			mvoSellerMember.setPwAnswer(svo.getPwAnswer());
			mvoSellerMember.setPwQnaNo(svo.getPwQnaNo());
		} else {

			svo.setSellerImg(file.getOriginalFilename()); // 이미지 업데이트
			memberService.editSellerMemberService(svo); // 업데이트
			mvoSellerMember.setPw(svo.getPw());
			mvoSellerMember.setMemName(svo.getMemName());
			mvoSellerMember.setBirth(svo.getBirth());
			mvoSellerMember.setTel(svo.getTel());
			mvoSellerMember.setAddressDe(svo.getAddressDe());
			mvoSellerMember.setPwAnswer(svo.getPwAnswer());
			mvoSellerMember.setPwQnaNo(svo.getPwQnaNo());

		}
		model.addAttribute("mvoSellerMember", mvoSellerMember);
		return "redirect:member/editMember_ok.do";
	}
	// 회원수정완료
	/////////////////////// end 정훈 메서드 ///////////////////////////////

	//////////////////// start 우정 메서드 ////////////////////////////

	@RequestMapping("sellerPageInfo.do")
	public String seller_myPage(Model model, String memId, String pageNo) {
		SellerVO svo = memberService.selectSellerInfo(memId);
		List<FoodVO> flist = foodService.getFoodListByMemId(memId);
		ListVO<FoodSellVO> fslist = foodService.getFoodSellInfoByMemId(memId, pageNo);
		int totalFoodSellCount=foodService.totalFoodSellCountByMemId(memId);
		model.addAttribute("svo", svo);
		model.addAttribute("flist", flist);
		model.addAttribute("lvo", fslist);
		model.addAttribute("foodSellCount",totalFoodSellCount);
		return "member/seller_myPage.tiles";
	}

	@RequestMapping("sellerPagePagingAjax.do")
	@ResponseBody
	public ListVO<FoodSellVO> sellerPagePagingAjax(Model model, String memId, String pageNo) {
		return foodService.getFoodSellInfoByMemId(memId, pageNo);
	}
	//////////////////// end 우정 메서드 ////////////////////////////

	/////////////////////// start 윤주 메서드 ///////////////////////////////
	// 판매자 등록 폼(이미 판매자로 등록되어있으면 sellerRegisterForm_fail.jsp로 alert띄움)
	@RequestMapping("sellerRegisterForm.do")
	public String sellerRegisterForm(String id) {
		String memId = id;// 로그인 기능 구현되면 세션의 아이디 정보를 가져와서 memId에 할당예정
		int sellerCheck = memberService.isSeller(memId);
		if (sellerCheck == 0)
			return "member/sellerRegisterForm.tiles";
		else
			return "member/sellerRegisterForm_fail";
	}

	private String uploadPath;// 프로필사진 업로드 경로
	// 판매자등록 메서드

	@RequestMapping(value = "sellerRegister.do", method = RequestMethod.POST)
	public String sellerRegister(String id, SellerVO svo, HttpServletRequest request) {
		// 개발시 경로
		uploadPath = "C://Users/kosta/git/Banchan/Banchan/src/main/webapp/resources/images/";
		// uploadPath=request.getSession().getServletContext().getRealPath("/resources/images/");
		File uploadDir = new File(uploadPath);
		if (uploadDir.exists() == false)
			uploadDir.mkdirs();
		MultipartFile file = svo.getUploadImage();// 파일
		
		if (file != null && file.isEmpty() == false) {
			File uploadFile = new File(uploadPath + file.getOriginalFilename());
			try {
				file.transferTo(uploadFile);// 실제 디렉토리로 파일을 저장한다
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		String memId = id; // 로그인기능 구현되면 세션정보 가져올 예정
		svo.setMemId(memId);
		svo.setSellerImg(file.getOriginalFilename());
		svo.setSellerInfo(request.getParameter("sellerInfo"));
		memberService.sellerRegister(svo);
		return "redirect:sellerRegister_ok.do";
	}

	@RequestMapping("sellerRegister_ok.do")
	public String sellerRegisterOk() {
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		List<GrantedAuthority> updatedAuthorities = new ArrayList<>(auth.getAuthorities());
		updatedAuthorities.add(new SimpleGrantedAuthority("ROLE_SELLER"));
		Authentication newAuth = new UsernamePasswordAuthenticationToken(auth.getPrincipal(), auth.getCredentials(),
				updatedAuthorities);
		SecurityContextHolder.getContext().setAuthentication(newAuth);
		return "member/sellerRegister_ok.tiles";
	}
	/////////////////////// end 윤주 메서드 ///////////////////////////////
}