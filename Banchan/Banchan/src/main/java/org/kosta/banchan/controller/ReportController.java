package org.kosta.banchan.controller;

import java.util.List;

import javax.annotation.Resource;

import org.kosta.banchan.model.service.FoodService;
import org.kosta.banchan.model.service.MemberService;
import org.kosta.banchan.model.service.ReportService;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.ReportVO;
import org.kosta.banchan.model.vo.SellerVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReportController {
	@Resource
	private FoodService foodService;
	@Resource
	private MemberService memberService;
	@Resource
	private ReportService reportService;
	
	@RequestMapping("reportmain.do")
	@ResponseBody
	public List<ReportVO> getReport(Model model){
		List<ReportVO> rlist = reportService.getReport();
		model.addAttribute("rlist",rlist);
		return rlist;
	}
	
	@RequestMapping("searchByKeyword.do")
	public ModelAndView SearchByKeyword(String kw) {
		ModelAndView mv = new ModelAndView();
		List<SellerVO> slist=null;
		List<FoodVO> flist = null;
		if(kw=="" || kw=="null") {
			
		}else {
			slist = memberService.findSellerList(kw);
			flist = foodService.findFoodList(kw);
		}
		mv.addObject("keyword",kw);
		mv.addObject("slist",slist);
		mv.addObject("flist",flist);
		mv.setViewName("search/search_result.tiles");
		return mv;
	}
	@RequestMapping("foodSearchMore.do")
	public ModelAndView foodSearchMore(String kw) {
		ModelAndView mv = new ModelAndView();
		List<FoodVO> flist = null;
		if(kw=="" || kw=="null") {
			
		}else {
			flist = foodService.findFoodList(kw);
		}
		mv.addObject("keyword",kw);
		mv.addObject("fslist",flist);
		mv.setViewName("search/foodSearchResult_more.tiles");
		return mv;
	} 
	@RequestMapping("sellerSearchMore.do")
	public ModelAndView sellerSearchMore(String kw) {
		ModelAndView mv = new ModelAndView();
		List<SellerVO> slist=null;
		if(kw=="" || kw=="null") {
			
		}else {
			slist = memberService.findSellerList(kw);
		}
		mv.addObject("keyword",kw);
		mv.addObject("slist",slist);
		mv.setViewName("search/sellerSearchResult_more.tiles");
		return mv;
	} 
	
}
