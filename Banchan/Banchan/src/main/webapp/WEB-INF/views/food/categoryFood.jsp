<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<script type="text/javascript">
jQuery(document).ready(function(){
    
  
   
	$("#category").change(function(){
    	var select_name = $(this).children("option:selected").val();
        location.href="${pageContext.request.contextPath}/selectCategoryFood.do?category="+select_name+"&pageNo=1";
    });
    
 
   
  });
</script>
<style type="text/css">
#select_box {
    position: relative;
    width: 200px;
    height: 40px;
    background: url(select_arrow.png) 180px center no-repeat; 
    border: 1px solid #E9DDDD;
}

#select_box select #category {
    width: 100%;
    height: 40px;
    min-height: 40px;
    line-height: 40px;
    padding: 0 10px;
    opacity: 0;
    filter: alpha(opacity=0); 
}
 
</style> 

<section id="agent-page"  style="margin-top: 100px;">
	<div class="container">
	<div class="col-md-2"></div>
	<div class="col-md-8">
	<h3 class="title-form"><i class="icon fa fa-map-marker" style="margin-right: 5px; width: inherit;"></i> 카테고리 검색 서비스 </h3>
					<hr>
		<div id="select_box"> 
		    <select  style="position: relative;left:20px;" id="category" name="category" >
		   	 	<option value="">전체보기</option>
				<c:forEach items="${category}" var="categorylist">
				<c:choose>
				<c:when test="${categorySelected==categorylist.CATEGORY_NAME}">
					<option value="${categorylist.CATEGORY_NAME}" selected="selected" >${categorylist.CATEGORY_NAME}</option>
				</c:when>
				<c:otherwise>
					<option value="${categorylist.CATEGORY_NAME}">${categorylist.CATEGORY_NAME}</option>
				</c:otherwise>
				</c:choose>
				</c:forEach>
			</select>
		</div>
	
	<c:choose>
	<c:when test="${empty lvo.list}">
		<div class="form-large grey-color" style="border-left: 0px;border-right: 0px;margin-top: 50px;" align="center">
				<div>
					${categorySelected} 카테고리 음식이 없습니다.
				</div>
			</div>
	</c:when>
	<c:otherwise>
		<c:forEach var="food" items="${lvo.list }" >
		<div class="row" style="vertical-align: middle; margin-top: 13px;"> 
		
		
					<div class="img" style="float: left; width: 30%;" >
								<a href="${pageContext.request.contextPath}/foodDetailView.do?foodNo=${food.foodNo}"><img alt="Sample images" width="220px" height="150px" src="${pageContext.request.contextPath }/resources/images/${food.foodMainImg}"></a>
					</div>
							<!-- <div class="col-sm-8 col-md-8 col-sm-push-4"> -->
					<div class="bs-callout callout-success" style=" float: left; width: 70%; margin-top: 5px;">
										<h3 class="title" style="width: auto">
								<a href="${pageContext.request.contextPath}/foodDetailView.do?foodNo=${food.foodNo}">
									${food.foodName}</a><a style="font-size: 12px">
									</a>
									
									<span class="star_rating"> 
									<c:forEach begin="1" end="${food.foodScore-(food.foodScore%1)}">
						    			<a class="on" style="font-size: 16px;">★</a>
									</c:forEach>
									<c:forEach begin="1" end="${5-(food.foodScore-(food.foodScore%1))}">
						    			<a style="font-size: 16px;">★</a>
						    		</c:forEach> 
						      		</span> &nbsp;
						      		<b style="font-size: 14px; color: gray;">${food.foodScore}</b>
									</h3> 

							 <span class='description' style='color:black;font-size:12px;'>		
								<table height="81px">   
								<tr> 
									<td  style="width: 100px;"><a style="color:black" href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${food.memId}"><i class='fa fa-user' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 아이디&nbsp;</i></a></td><td><a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${food.memId}">${food.memId}</a></td>
								</tr>
								<tr>
									<td style="width: 100px;"><i class='fa fa-calendar' style="font-weight: bold; margin-right: 5px">&nbsp;음식 상세&nbsp;</i></td><td><a>${food.foodDe}</a></td>
								</tr>		
								<tr>
									<td ></td><td></td>
								</tr>			
								</table > 
							 </span>
						</div><!-- bs-callout callout-success -->
							<!-- </div> --><!-- /.col-md-8 -->
							<!-- <div class="col-sm-4 col-md-4 col-sm-pull-8" style="padding-top: 15px;" >  -->
							<!-- . Agent Box -->
							<!--  </div> --> <!-- /.col-md-4 -->		
							
		</div>
		
		</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
		<div class="col-md-12">
		<div class="row" style="vertical-align: middle">
		<div class="pageginationContainer" style="text-align: center;">
			  	  <div class="pagination" >
			  	  <c:set var="pb" value="${lvo.pb }"/>
			  	 <c:if test="${pb.previousPageGroup}">
					   <a href="${pageContext.request.contextPath}/selectCategoryFood.do?category=${categorySelected}&pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a>
				</c:if>
					<c:forEach var="pageNum"  begin="${pb.startPageOfPageGroup}"  end="${pb.endPageOfPageGroup}">
				  		<c:choose>
				  			<c:when test="${pageNum==pb.nowPage}">
				  				 <a href="#" class='active' >${pageNum}</a>
			                </c:when>
				  			<c:otherwise>
				  				<a href="${pageContext.request.contextPath}/selectCategoryFood.do?category=${categorySelected}&pageNo=${pageNum}">${pageNum}</a>
				  			</c:otherwise>
				  		</c:choose>
				  	</c:forEach>
			
					<c:if test="${pb.nextPageGroup}">
						 <a href="${pageContext.request.contextPath}/selectCategoryFood.do?category=${categorySelected}&pageNo=${pb.endPageOfPageGroup+1}">&raquo;</a>
					</c:if>
				   </div> 
				</div>
				</div>
		</div>
	<div class="col-md-2"></div>
	</div>
</section>
		
