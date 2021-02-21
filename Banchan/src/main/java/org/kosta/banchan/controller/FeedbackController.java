package org.kosta.banchan.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.kosta.banchan.model.service.FeedbackService;
import org.kosta.banchan.model.vo.AnswerVO;
import org.kosta.banchan.model.vo.QuestionVO;
import org.kosta.banchan.model.vo.ReviewVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class FeedbackController {
	@Resource
    private FeedbackService feedbackService;
	///////////////start윤주////////////////////
	@RequestMapping("reviewRegisterForm.do")
	public String reviewRegisterForm(HttpServletRequest request) {
		request.setAttribute("foodSellNo",request.getParameter("foodSellNo"));
		request.setAttribute("foodNo",request.getParameter("foodNo"));
		request.setAttribute("memId",request.getParameter("memId"));
		return "food/reviewForm.tiles";
	}
	@RequestMapping("reviewRegister.do")
	public String reviewRegister(HttpServletRequest request) {
		String foodSellNo = request.getParameter("foodSellNo");
		String memId = request.getParameter("memId");//판매자
		String rContent = request.getParameter("rContent");
		int score = Integer.parseInt(request.getParameter("score"));
		String foodNo = request.getParameter("foodNo");
		String writerId = request.getParameter("writerId");//작성자
		ReviewVO rvo = new ReviewVO();
		rvo.setScore(score);
		rvo.setRevContent(rContent);
		rvo.setFoodNo(foodNo);
		rvo.setMemId(writerId);
		feedbackService.reviewRegister(rvo, memId,foodNo);
		return "redirect:reviewRegister_ok.do?foodSellNo="+foodSellNo;
		
	}
	@RequestMapping("reviewRegister_ok.do")
	public String reviewRegisterOk(String foodSellNo,Model model) {
		model.addAttribute("foodSellNo",foodSellNo);
		return "food/reviewRegister_ok.tiles";
	}
	//댓글에 답변달기
	@ResponseBody
	@RequestMapping("answerRegister.do")
	public AnswerVO answerRegisterAjax(String questNo,String memId2,String ansContent){
		AnswerVO avo = new AnswerVO();
		avo.setAnsContent(ansContent);
		avo.setMemId(memId2);
		avo.setQuestNo(questNo);
		feedbackService.answerRegister(avo);
		AnswerVO currAvo = feedbackService.findAnswerByAnsNo(avo.getAnsNo());
		currAvo.setAnsNo(avo.getAnsNo());
		return currAvo;
	}
	//답변 삭제하기 
	@RequestMapping("answerDelete.do")
	@ResponseBody
	public String answerDeleteAjax(String answerNo,String foodSellNo) {
		feedbackService.answerDelete(answerNo);
		return "redirect:answerDeleteOk.do?foodSellNo="+foodSellNo;
	}
	@RequestMapping("answerDeleteOk.do")
	public String answerDeleteOk(String foodSellNo) {
		return foodSellNo;
	}
	///////////////end윤주//////////////////////
	
	///////////////start정훈//////////////////////
	//댓글 목록
	@RequestMapping("commentList.do")
	@ResponseBody
	private List<QuestionVO> commentList(Model model,String foodSellNo){
		return feedbackService.commentList(foodSellNo);
	}
	
	//댓글 작성 
	@RequestMapping("commentInsert.do")
	@ResponseBody
	private int commentInsert(@RequestParam String foodSellNo, @RequestParam String content, @RequestParam String memId) throws Exception{
		QuestionVO qvo = new QuestionVO();
	     qvo.setFoodSellNo(foodSellNo);
	     qvo.setQuestContent(content);
	     qvo.setMemId(memId);
	     	return feedbackService.commentInsert(qvo);
	    }
	
	//댓글 수정  
	@RequestMapping("commentUpdate.do") 
	@ResponseBody
	private int mCommentServiceUpdateProc(@RequestParam String questNo, @RequestParam String content) throws Exception{
	     QuestionVO qvo = new QuestionVO();
	     qvo.setQuestNo(questNo);
	     qvo.setQuestContent(content);
	       	return feedbackService.commentUpdate(qvo);
	    }
	
	//댓글 삭제
	@RequestMapping("commentDelete.do")   
	@ResponseBody
	private int commentDelete(@RequestParam String questNo) throws Exception{
		QuestionVO qvo= new QuestionVO();
		qvo.setQuestNo(questNo);
			return feedbackService.commentDelete(qvo);
	    }
////////////////end정훈//////////////////////

}