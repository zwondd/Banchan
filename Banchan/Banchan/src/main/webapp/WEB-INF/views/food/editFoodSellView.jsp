<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%> 
 
 <!-- datepicker --> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
 
<script type="text/javascript">
	$(document).ready(function () { 
		$.datepicker.regional['ko'] ={
				showOn: "both",
				buttonImage: "${pageContext.request.contextPath}/resources/images/calendar2.png",
				buttonImageOnly: true,
				buttonText: "날짜를 선택하세요.",
				closeText : '닫기',         
	            prevText : '이전달',         
	            nextText : '다음달',         
	            currentText : '오늘',         
	            monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],         
	            monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],         
	            dayNames : ['일', '월', '화', '수', '목', '금', '토'],         
	            dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],         
	            dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	            closeText:'취소',
	            dateFormat: "yy-mm-dd",
	            showButtonPanel: true,
	            
	            onClose: function () {
	                if ($(window.event.srcElement).hasClass('ui-datepicker-close')) {
	                    $(this).val('');
	                }
	            }
			};
		
			$.datepicker.setDefaults($.datepicker.regional['ko']); 
			
			$('#closeDate').datepicker({
				minDate: 0,
				onSelect: function(selected) {
					$("#trDate").datepicker("option","minDate",selected);
				}
			});
			
			$('#trDate').datepicker({
				minDate: 0,
				onSelect: function(selected) {
					$("#closeDate").datepicker("option","maxDate",selected);
				}
			});
			
			$("#regForm").submit(function() {
				return confirm("수정하시겠습니까?");
			});
			
			
			
	});//ready
function returnList(){
			var foodSellNo = $("#foodSellNo").val();
			var flag = confirm("취소하시겠습니까?");
			if(flag)
				location.href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo="+foodSellNo;
			else
				history(0);  
	}
</script>	 
    
<section id="recent-list" class="agency" style="margin-top: 150px">
<sec:authorize access="hasRole('ROLE_SELLER')"><!-- 오직 판매자 권한 설정 -->
<sec:authentication var="mvo" property="principal" />
<div class="container">
	<div class="row">
		<div class="col-sm-1"><!-- left --></div>
		
		<div class="col-sm-10" >
			<div class="blog-list blog-detail">
		<h3 class="title-form"><i class="fa fa-wrench" aria-hidden="true" style="margin-right: 5px"></i>판매음식 수정</h3>

		<form  class="form-large grey-color" action="${pageContext.request.contextPath}/editFoodSell.do?" method="post"  id="regForm" >
		<sec:csrfInput/><%-- csrf 토큰 --%>
		<div class="col-xs-6" style="float: left" class="row">
			<img style="padding-top: 15px" width="350px" height="250px" src="${pageContext.request.contextPath}/resources/images/${foodSell.foodMainImg}" > 
		</div>
		<div  class="col-xs-6" style="float:right" class="row">
		<div class="row">   
				<h3 class="title-form" style="margin-bottom: 15px">${foodSell.foodName }</h3>  
			</div>
			<div class="row">
					<div  class="col-xs-4" >
						<label for="price">가격 </label>
						<input type="number" name="price"  id="price" min="0" class="margin-bottom form-control"  required="required" value="${foodSell.price}">
						</div>
					<div  class="col-xs-4" >
						<label for="preQuantity">준비수량</label>
						<input type="number" name="preQuantity"  id="preQuantity" min="1" class="margin-bottom form-control" required="required" value="${foodSell.preQuantity}">	
					</div>
					<div  class="col-xs-4" >
						<label for="unit">수량 당 정보</label>
						<input type="text" name="unit"  id="unit" class="margin-bottom form-control"  required="required" value="${foodSell.unit}" >
					</div>
				</div>
			<div class="row">	 
				<label for="date">마감일자</label>
				<input type="text" name="closeDate" id="closeDate" class="margin-bottom small-text " required="required" value="${foodSell.closeDate}">	
			</div>
			<div class="row" >
				<label for="id">거래일자</label>
				<input type="text"  name="trDate" id="trDate" required="required" class="margin-bottom small-text trDate" value="${foodSell.trDate}" > 
			</div>
			<div class="row">
				<label for="loc">거래장소 </label>
				<input type="text"	 name="loc"  id="loc" class="margin-bottom small-text"  required="required" value="${foodSell.loc}">	
			</div>
		</div>
		<div class= "row">
	 		<div  class="container-fluid">										
				<label for="sellDetail" style="padding-top: 40px">음식 상세정보</label><br>
				<textarea rows="4" class="" cols="52"  style="width: 100%" readonly="readonly">${foodSell.foodDe}</textarea>
			</div>
		</div>				
		<div class="row">
	 		<div  class="container-fluid">										
				<label for="sellDetail" style="padding-top: 30px">판매 추가 상세정보</label><br>
				<textarea rows="10" class="" cols="52" name="sellDetail" style="width: 100%"  required="required">${foodSell.sellDetail}</textarea>
			</div>
		</div>
		
		<div class="row" align="right">
			<input type="submit" id="editButton" class="btn btn-reverse" style="margin-right: 14px" value="수정하기" >
			<a href="#" onclick="returnList()" style="margin-right: 14px" class="btn btn-reverse">취소</a>		
		</div> 
			<input type="hidden" name="foodSellNo" value="${foodSell.foodSellNo}" id="foodSellNo"/>
			<input type="hidden" name="memId" value="${foodSell.memId}" id="sellerId"/>
		</form> 
		</div>  
		</div>
		</div>	
	
		<div class="col-sm-1"><!-- right --></div>
		</div>
</sec:authorize>	
</section> 