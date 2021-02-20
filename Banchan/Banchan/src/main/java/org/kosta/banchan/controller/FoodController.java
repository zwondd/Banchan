package org.kosta.banchan.controller;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.kosta.banchan.model.service.FeedbackService;
import org.kosta.banchan.model.service.FoodService;
import org.kosta.banchan.model.service.MemberService;
import org.kosta.banchan.model.vo.FoodSellVO;
import org.kosta.banchan.model.vo.FoodVO;
import org.kosta.banchan.model.vo.TradeVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller
public class FoodController {

	@Resource
	private FoodService foodService;
	@Resource
	private MemberService memberService;
	@Resource
	private FeedbackService feedbackService;
	// 파일 업로드를 FoodController에서 하실지 FileUploadController에서 하실지..
	private String uploadPath;

	@RequestMapping("category.do")
	@ResponseBody
	public List<Map<String, Object>> allCategoryList() {
		List<Map<String,Object>> list = foodService.allCategorySelect();      
		return list;
	}
	
	///////////////////////// start 윤주 ////////////////////////////

	@RequestMapping("orderFood.do")
	public String orderFood(HttpServletRequest request) {

		int trQuantity = Integer.parseInt(request.getParameter("trQuantity"));
		String memId = request.getParameter("memId");
		String foodSellNo = request.getParameter("foodSellVO.foodSellNo");

		TradeVO tvo = new TradeVO();
		tvo.setTrQuantity(trQuantity);
		tvo.setMemId(memId);
		tvo.setFoodSellVO(new FoodSellVO());
		tvo.getFoodSellVO().setFoodSellNo(foodSellNo);
		foodService.orderFood(tvo);
		return "redirect:orderFood_ok.do";
	}

	@RequestMapping("orderFood_ok.do")
	public String orderFoodOk() {
		return "food/orderFood_ok.tiles";
	}
	///////////////////////// end 윤주///////////////////////////////////

	///////////////////////// start 우정///////////////////////////////////
	@RequestMapping("registerFoodView.do")
	public String registerFoodView(String foodNo, Model model) {
		FoodVO fvo = foodService.getFoodByNo(foodNo);
		model.addAttribute("fvo", fvo);
		return "food/register_foodsell_view.tiles";
	}
	@RequestMapping("deleteConfirmAjax.do")
	@ResponseBody
	public int deleteConfirmAjax(String foodSellNo) {
		return foodService.deleteConfirmAjax(foodSellNo);
	}

	@RequestMapping("deleteFoodSell.do")
	public String deleteFoodSell(String foodSellNo,String sellerId, Model model, HttpServletRequest req, HttpServletResponse resp) {
		foodService.deleteFoodSell(foodSellNo);
		// Start 광태 추가 코드(최근클릭)
		Cookie[] coo= req.getCookies();
		Cookie clickCoo = null;

		for (int i = 0; i < coo.length; i++) {
			if(coo[i].getName().equals("click")) {
				clickCoo = coo[i];
				break;
			}
		}
		
		String strTemp= clickCoo.getValue();
		//FoodSellVO fvo =foodService.getFoodSellDetailByNo(foodSellNo);
		int start=strTemp.indexOf(foodSellNo);
		int end =strTemp.indexOf("/", start);
		String strFront= strTemp.substring(0,start);
		String strBack = strTemp.substring(end+1, strTemp.length());
		strTemp= strFront+strBack;		
		clickCoo.setValue(strTemp);
		resp.addCookie(clickCoo);
		// End 광태 추가 코드(최근클릭)
		
		return "redirect:sellerPageInfo.do?memId="+sellerId+"&pageNo=1";
	}
	@RequestMapping("selectCategoryFood.do")
	public String selectCategoryFood(String category,String pageNo,Model model) {
		model.addAttribute("lvo",foodService.selectCategoryFood(category,pageNo));
		model.addAttribute("category",foodService.allCategorySelect());
		model.addAttribute("categorySelected",category);
		return "food/categoryFood.tiles";
	}
	
	///////////////////////// end 우정///////////////////////////////////

	///////////////////////// start 지원///////////////////////////////////

	/**
	 * [지원] 판매음식등록 등록음식 중 판매할 음식을 등록한다.
	 * 
	 * @param foodSellVO
	 * @return
	 */
	@RequestMapping(method = RequestMethod.POST, value = "registerFoodSell.do")
	public String registerFoodSell(FoodSellVO foodSellVO) {
		foodService.registerFoodSell(foodSellVO);
		return "redirect:getFoodSellDetail.do?foodSellNo=" + foodSellVO.getFoodSellNo();
	}

	/**
	 * [지원] 판매음식상세정보 판매음식에 대한 상세정보 FoodSellVO 와 FoodVO의 정보를 함께 가져온다.
	 * 
	 * @param foodSellNo
	 * @param model
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	@RequestMapping("getFoodSellDetail.do")
	public String getFoodSellDetail(String foodSellNo, Model model,String pageNo, HttpServletRequest req, HttpServletResponse resp) throws UnsupportedEncodingException {
		// 윤주
		model.addAttribute("rlist", feedbackService.getReviewListByFoodSellNo(foodSellNo,pageNo));
		model.addAttribute("leftQuantity", foodService.getLeftQuantityByFoodSellNo(foodSellNo));
		model.addAttribute("foodSell", foodService.getFoodSellDetailByNo(foodSellNo));
		
		///// Start 최근 클릭 리스트 코드 추가 광태
		
		Cookie[] coo= req.getCookies();
		Cookie clickCoo = null;
		for (int i = 0; i < coo.length; i++) {
			if(coo[i].getName().equals("click")) {
				clickCoo = coo[i];
				break;
			}
		}
		// 첫 클릭시 click 쿠키 생성
		if(clickCoo == null) {
			clickCoo = new Cookie("click", "");
		}
		String strTemp= URLDecoder.decode(clickCoo.getValue(), "UTF-8");
				
		FoodSellVO fvo =foodService.getFoodSellDetailByNo(foodSellNo);
		
		//특정 문자 개수 구하기
	      Pattern p = Pattern.compile("/");
	      Matcher m = p.matcher(strTemp);
	      int count = 0;
	      for( int i = 0; m.find(i); i = m.end())
	    	  count++;
	      
	    if(count>4) {
	    	if(strTemp.contains(fvo.getFoodSellNo())) {
	    		
	    	}else {
	    		strTemp = strTemp.substring(strTemp.indexOf("/")+1, strTemp.length());
	    	}    	
	    }
		
		if( !(strTemp.contains(fvo.getFoodSellNo())) ) {
			strTemp+= fvo.getFoodSellNo()+":"+fvo.getFoodMainImg()+"/";
		}
		String strEncoding=URLEncoder.encode(strTemp, "UTF-8");
		clickCoo.setValue(strEncoding);
		resp.addCookie(clickCoo);
		//System.out.println("22222");
		///// end 최근 클릭 리스트 코드 추가 광태
		
		return "food/foodsell_detail.tiles";
	}
	
	@RequestMapping("editFoodSellView.do") 
	public String editFoodSellView(String foodSellNo,Model model) {
		model.addAttribute("foodSell",foodService.getFoodSellDetailByNo(foodSellNo));
		return "food/editFoodSellView.tiles";
	}
	
	@RequestMapping(value="editFoodSell.do", method=RequestMethod.POST)
	public String editFoodSell(FoodSellVO foodSellVO) {
		foodService.editFoodSell(foodSellVO);
		return "redirect:editFoodSellOk.do?foodSellNo=" + foodSellVO.getFoodSellNo();
	}
	
	@RequestMapping("editFoodSellOk.do")
	public String editFoodSellOk(String foodSellNo,Model model) {
		model.addAttribute("foodSellNo", foodSellNo);
		return "food/editFoodSell_ok.tiles";
	}
	
	
	
	
	///////////////////// end 지원 ///////////////////////////////////
	
	
	///////////////////// 영민 start ///////////////////////////////////
	@RequestMapping("foodRegisterForm.do")
	public String foodRegisterForm(Model model) {
		List<Map<String, Object>> list = foodService.allCategorySelect();

		model.addAttribute("category", list);
		return "food/foodRegister.tiles";
	}

	@RequestMapping(value = "foodRegister.do", method = RequestMethod.POST)
	public String foodRegister(String id, FoodVO fvo, HttpServletRequest request) {

		/* 테스트 경로 */
		uploadPath = "C://Users/kosta/git/Banchan/Banchan/src/main/webapp/resources/images/";
		/* 서버 경로 */
		// uploadPath=request.getSession().getServletContext().getRealPath("/resources/images/");

		File uploadDir = new File(uploadPath);
		if (uploadDir.exists() == false)
			uploadDir.mkdirs();
		MultipartFile file = fvo.getUploadImage();// 파일
		if (file != null && file.isEmpty() == false) {
			File uploadFile = new File(uploadPath + file.getOriginalFilename());
			
			try {
				file.transferTo(uploadFile);// 실제 디렉토리로 파일을 저장한다
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}


		fvo.setMemId(id);
		// fvo.setFoodScore(score);
		fvo.setFoodName(request.getParameter("foodname"));
		fvo.setFoodMainImg(file.getOriginalFilename());
		fvo.setFoodDe(request.getParameter("foodInfo"));
		fvo.setCategoryNo(request.getParameter("category"));
		foodService.foodRegister(fvo);

		return "redirect:foodRegister_ok.do?memId=" + id;
	}

	@RequestMapping("foodRegister_ok.do")
	public String foodRegister_ok(String memId, Model model) {
		model.addAttribute("memId", memId);
		return "food/foodRegister_ok.tiles";
	}

	@RequestMapping("foodDetailView.do")
	public String foodDetailView(String foodNo, String pageNo, Model model) {
		FoodVO food = foodService.getFoodMemInfo(foodNo);
		model.addAttribute("food", food);
		// 지원 후기 리스트 추가
		model.addAttribute("rlist", feedbackService.getReviewListByFoodNo(foodNo, pageNo));
		
		return "food/foodDetailView.tiles";
	}

	@RequestMapping("deleteRegFood.do")
	public String deleteRegFood(String foodNo, Model model, String memId) {
		//String message = "";
		List<FoodVO> food = foodService.selectRegFoodByNo(foodNo);
		if (food.size() == 0) {
			// foodService.deleteRegFood(foodNo);
			model.addAttribute("message", "ok");
			model.addAttribute("foodNo", foodNo);
			model.addAttribute("memId", memId);
		} else {
			model.addAttribute("message", "fail");
			model.addAttribute("foodNo", foodNo);
			model.addAttribute("memId", memId);
		}
		return "food/deleteRegFood_result.tiles";
	}

	@RequestMapping("deleteRegFoodResult.do")
	public String deleteRegFoodResult(String foodNo, String memId) {
		foodService.deleteRegFood(foodNo);
		return "redirect:sellerPageInfo.do?memId=" + memId;
	}

	@RequestMapping("updateRegViewFood.do")
	public String updateRegViewFood(String foodNo, Model model, String memId) {
		//String message = "";
		List<FoodVO> foodlist = foodService.selectRegFoodByNo(foodNo);
		if (foodlist.size() == 0) {

			List<Map<String, Object>> list = foodService.allCategorySelect();
			model.addAttribute("category", list);
			FoodVO beforeFood = foodService.getFoodMemInfo(foodNo);

			model.addAttribute("foodNo", foodNo);
			model.addAttribute("memId", memId);
			model.addAttribute("beFood", beforeFood);

			model.addAttribute("message", "ok");
			return "food/foodRegister.tiles";

		} else {
			model.addAttribute("message", "fail");
			model.addAttribute("memId", memId);
			return "food/deleteRegFood_result.tiles";
		}
	}

	@RequestMapping(value = "updateRegFood.do", method = RequestMethod.POST)
	public String updateRegFood(String memId, FoodVO fvo, HttpServletRequest request, Model model) {

		/* 테스트 경로 */
		uploadPath = "C://Users/kosta/git/Banchan/Banchan/src/main/webapp/resources/images/";
		/* 서버 경로 */
		// uploadPath=request.getSession().getServletContext().getRealPath("/resources/images/");
		File uploadDir = new File(uploadPath);
		if (uploadDir.exists() == false)
			uploadDir.mkdirs();
		MultipartFile file = fvo.getUploadImage();// 파일
		if (file != null && file.isEmpty() == false) {

			File uploadFile = new File(uploadPath + file.getOriginalFilename());
			try {
				file.transferTo(uploadFile);// 실제 디렉토리로 파일을 저장한다
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		String foodImage = (String) file.getOriginalFilename();
		if (foodImage.equals("null") || foodImage.equals("")) {

			fvo.setMemId(memId);
			// fvo.setFoodScore(score);
			fvo.setFoodNo(request.getParameter("foodNo"));
			fvo.setFoodName(request.getParameter("foodname"));
			fvo.setFoodDe(request.getParameter("foodInfo"));
			fvo.setCategoryNo(request.getParameter("category"));
			foodService.noimgUpdateRegFood(fvo);
		
			return "redirect:updateRegFoodOk.do?memId="+ memId;
		} else {
			fvo.setMemId(memId);
			// fvo.setFoodScore(score);
			fvo.setFoodNo(request.getParameter("foodNo"));
			fvo.setFoodName(request.getParameter("foodname"));
			fvo.setFoodMainImg(file.getOriginalFilename());
			fvo.setFoodDe(request.getParameter("foodInfo"));
			fvo.setCategoryNo(request.getParameter("category"));
			foodService.imgUpdateRegFood(fvo);

			return "redirect:updateRegFoodOk.do?memId="+memId;
		}
	}

	@RequestMapping("updateRegFoodOk.do")
	public String updateRegFoodOk(String memId, Model model) {

		model.addAttribute("memId", memId);
		
		return "food/updateRegFood_ok.tiles";
	}
	////////////////////////// 영민 end//////////////////////////////////////
}
