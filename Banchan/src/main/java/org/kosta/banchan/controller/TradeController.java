package org.kosta.banchan.controller;

import javax.annotation.Resource;

import org.kosta.banchan.model.service.FeedbackService;
import org.kosta.banchan.model.service.FoodService;
import org.kosta.banchan.model.service.MemberService;
import org.kosta.banchan.model.service.TradeService;
import org.kosta.banchan.model.vo.ListVO;
import org.kosta.banchan.model.vo.MemberVO;
import org.kosta.banchan.model.vo.TradeVO;
import org.springframework.security.access.annotation.Secured;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TradeController {

	@Resource
	private FoodService foodService;
	@Resource
	private TradeService tradeService;
	@Resource
	private FeedbackService feedbackService;
	@Resource
	private MemberService memberService;

	//////////////////////////// start 지원////////////////////////////////
	/**
	 * [지원] 판매자-해당 판매상품에 관한 거래요청리스트 조회
	 * 
	 * @param foodSellNo
	 * @param model
	 * @return
	 */
	// @Secured("ROLE_SELLER")
	@RequestMapping("getSellerTradeListByFoodSellNo.do")
	public String getSellerTradeListByFoodSellNo(String foodSellNo, String pageNo, Model model) {
		ListVO<TradeVO> tradeList = tradeService.getSellerTradeListByFoodSellNo(foodSellNo, pageNo);
		model.addAttribute("foodSell", foodService.getFoodSellDetailByNo(foodSellNo));
		model.addAttribute("lvo", tradeList);
		return "food/seller_foodTradeList.tiles";
	}

	/**
	 * [지원] 판매자-전체거래내역조회 해당 판매자가 판매한 음식의 모든 거래내역을 조회한다.
	 * 
	 * @param sellerId
	 * @param model
	 * @return
	 */
	@Secured("ROLE_SELLER")
	@RequestMapping("getAllSellerTradeList.do")
	public String getAllSellerTradeList(String sellerId, String pageNo, Model model) {
		model.addAttribute("lvo", tradeService.getAllSellerTradeList(sellerId, pageNo));
		return "food/seller_allTradeList.tiles";
	}

	/**
	 * [지원] 거래완료확인 
	 * 거래완료버튼을 누르면 거래상태를 '거래완료'로 변경 
	 * 로그인 되어있을 경우 redirect로 
	 * 다시 전체거래내역 보기로 이동
	 *  
	 * @param tradeNo
	 * @return
	 */
	@Secured("ROLE_SELLER")
	@RequestMapping("completeTrade.do")
	public String completeTrade(String tradeNo, String pageNo) {
		tradeService.completeTrade(tradeNo);
		if (SecurityContextHolder.getContext().getAuthentication().getPrincipal().equals("anonymousUser")) {
			return "redirect:loginView.do";
		} else {
			MemberVO mvo = (MemberVO) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			return "redirect:getAllSellerTradeList.do?sellerId=" + mvo.getMemId()+"&pageNo="+pageNo;
		}
	}

	/**
	 * [지원] 구매자 상세정보 확인 
	 * 판매자가 거래내역을 확인할 때 
	 * 해당 거래내역을 클릭하면 토글로 
	 * 구매자의 상세정보를 확인할 수 있다.
	 * 
	 * @param buyerId
	 * @param model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("getBuyerInfoOnAjax.do")
	public MemberVO getBuyerInfo(String id) {
		return memberService.getBuyerInfo(id);
	}
	//////////////////////////// end 지원////////////////////////////////

	//////////////////////////// start윤주////////////////////////////////
	// 나의 거래 내역 리스트 가져오기
	@RequestMapping("myTradeList.do")
	public String getTradeListByMemId(String memId,String pageNo,Model model) {
		model.addAttribute("tlist", tradeService.getTradeListByMemId(memId,pageNo));
		return "member/myTradeList.tiles";
	}
	//////////////////////////// end윤주//////////////////////////////////
}