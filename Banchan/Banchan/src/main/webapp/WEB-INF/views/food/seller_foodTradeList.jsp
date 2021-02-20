<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.pagination {
    display: inline-block;
    text-align: center;
}

.pagination a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    font-size: 13px;
}

.pagination a.active {
    background-color: #000;
    color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}


table, th, td{
	text-align: center;
}
.table-border-hidden th, .table-border-hidden td{
	text-align: center;
	border: hidden;
}

.trNone{
	display: none;
}
.tr_visible {
	display: table-row;
}

</style>  

<script type="text/javascript">
	$(document).ready(function () {
		/* 해당 거래내역 클릭시 구매자 상세정보 확인가능 */
		$("#tradeList .tr_visible").click(function() {
			var trade=$(this);
			var buyerId=trade.children().eq(1).text();
			$.ajax({
               type:"get",
               url:"${pageContext.request.contextPath}/getBuyerInfoOnAjax.do",
               data: "id="+buyerId,
               success:function(data){ //data로 서버의 응답정보가 할당 
      			   trade.next().find("#buyerId").text(data.memId);	
      			   trade.next().find("#buyerName").text(data.memName);	
      			   trade.next().find("#buyerTel").text(data.tel);	
      			   trade.next().find("#buyerAddress").text(data.addressVO.addressAPI);	
            	   trade.next().toggle();
               }
            }); //success 
		});
		
		/* /* 거래완료확인 */
		$("button[name = 'completeTrade']").click(function() {
			if(confirm("거래완료 확인을 하시겠습니까?")==true){
				location.href="${pageContext.request.contextPath}/completeTrade.do?tradeNo="+$(this).val();
			} else{
				return false;
			}
		}); //click */
	}); //ready
</script>
  
    
<section id="recent-list" class="agency" style="margin-top: 100px"> 
<sec:authorize access="hasRole('ROLE_SELLER')"><!-- 오직 판매자 권한 설정 -->
<sec:authentication var="mvo" property="principal" />
<div class="container" >
<div class="row">
	<div class="col-md-1"></div>
	<div class="col-md-10" >
		<div class="blog-list blog-detail">
		 <h3 class="title-form"><i class="icon fa fa-exchange" style="margin-right: 5px"></i>판매내역</h3>
				 <div class="container" style="width: 100%;">
				 <div class="form-large grey-color"> 
				 <div class="row">
				 <!-- image -->
				      <div class="col-xs-6"  class="row">  
				         <img style="padding-top: 48px" width="350px" height="250px" src="${pageContext.request.contextPath}/resources/images/${foodSell.foodMainImg}">
				      </div>
				      <div class="col-xs-6" style="float: right" class="row">
				         <div class="row">
				          <h3 class="title-form"><i class="" style="margin-right: 5px"></i>${foodSell.foodName} 
							<span class="star_rating" > 
		                    <c:forEach begin="1" end="${foodSell.foodScore-(foodSell.foodScore%1)}">
   							<a class="on" style="font-size: 12px;">★</a>
							</c:forEach>
							 <c:forEach begin="1" end="${5-(foodSell.foodScore-(foodSell.foodScore%1))}">
   							<a style="font-size: 12px;">★</a>
   							</c:forEach> 
     							</span>
     				                <b style="font-size: 12px">&nbsp;&nbsp;별점 :&nbsp;&nbsp;${foodSell.foodScore}</b>
				          </h3>
				         </div>
						 <div class="row" style="border-top: 1PX solid #928f8f ;border-bottom: 1PX solid #928f8f;margin-top: 5px;margin-bottom: 5px;width: 100%"> 
					            <table class="table table-border-hidden" style="font-size: 13px; table-layout: fixed; height:auto; overflow: hidden;" >
					               <tr> 
					                  <th style="width: 20%;">예약마감일</th>
					                  <td style="width: 30%;">${foodSell.closeDate}</td>
					                  <th style="width: 20%;">거래일</th>
					                  <td style="width: 30%;">${foodSell.trDate}</td>
					               </tr> 
					               <tr>
					                  <th style="width: 25%;">가격</th>
					                  <td style="width: 25%;"><span id="price">${foodSell.price}</span> 원</td> 
					                  <th style="width: 25%;">양(개당)</th>
					                  <td style="width: 25%;">${foodSell.unit}</td>
					                <tr> 
					                  <th style="width: 25%;">준비수량</th>
					                  <td style="width: 25%;"><span id="preQuantity">${foodSell.preQuantity}</span>&nbsp;(${foodSell.unit })</td>
					                  <th style="width: 25%;">남은수량</th>
					                  <td style="width: 25%;"><span id="leftQuantity">${leftQuantity}</span>&nbsp;(${foodSell.unit })</td>
					               </tr> 
					               <tr>
					                  <th>거래장소</th>
					                  <td colspan="3">${foodSell.loc}</td>
					               </tr>
					               <tr>
					                  <th>음식소개</th>
					                  <td colspan="3">${foodSell.foodDe}</td>
					               </tr>
					               <tr>
					                  <th>판매추가정보</th>
					                  <td colspan="3">${foodSell.sellDetail}</td>
					               </tr>                  
					            </table> 
					            
					         </div> <!-- row  -->
						 
				      </div><!-- col-xs-6 -->
		     	</div> <!--form-large grey-color  --> 
				</div><!--  <div class="row"> -->
				<c:if test="${!empty lvo.list}">
						<div align="right">
						<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}" class="btn btn-reverse button-form" style="margin-top: 10px;">돌아가기</a>
						</div>
				</c:if>
				<div class="row" style="margin-top: 20px">  
				<div style="font-size: 15px; text-align: right;margin-bottom: 10px;color: #80808075; font-style: italic">*클릭하여 구매자 정보를 확인하세요</div> 
				<table class="table table-hover" id="tradeList" style="text-align: center;font-size: 12px;">
					<c:choose>
					<c:when test="${!empty lvo.list}">
					<tr class="tr_visible">
						<th style="width: 20%;">거래번호</th>
						<th style="width: 20%;">구매자명</th>
						<th style="width: 20%;">거래수량</th>
						<th style="width: 20%;">거래신청날짜</th>
						<th style="width: 20%;">거래상태</th>
					</tr>
					<c:forEach items="${lvo.list}" var="trade">
					<tr class="tr_visible">
						<td>${trade.trNo}</td>
						<td>${trade.memId}</td>
						<td>${trade.trQuantity}</td>
						<td>${trade.trReqDate}</td>
						<td>${trade.trStatus}</td>
					</tr>
					<tr class="trNone">
						<td colspan="1">구매자 아이디:<span id="buyerId"></span> </td>
						<td colspan="1">구매자 이름: <span id="buyerName"></span></td>
						<td colspan="1">구매자 연락처:<span id="buyerTel"></span></td>
						<td colspan="2">구매자 주소: <span id="buyerAddress"></span></td>
					</tr>
					</c:forEach>
					</c:when>
					<c:otherwise>
					<br>
					<br>
						<div style="font-weight: bold;text-align: center;">판매 상품에 대한 거래 내역이 존재하지 않습니다</div>
						<div align="center">
						<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}" class="btn btn-reverse button-form" style="margin-top: 10px;">돌아가기</a>
						</div>
					</c:otherwise>
					</c:choose>
				</table>
				 
				<div class="pageginationContainer" style="text-align: center;">
				 <div class="pagination" >
								<c:set var="pb" value="${lvo.pb}"></c:set>
								<c:if test="${pb.previousPageGroup}">	
								<a href="${pageContext.request.contextPath}/getSellerTradeListByFoodSellNo.do?foodSellNo=${foodSell.foodSellNo}
								&pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a>
								</c:if>
								<c:forEach var="i" begin="${pb.startPageOfPageGroup}" end="${pb.endPageOfPageGroup}">
								<c:choose>
								<c:when test="${pb.nowPage!=i}">
								<a href="${pageContext.request.contextPath}/getSellerTradeListByFoodSellNo.do?foodSellNo=${foodSell.foodSellNo}
								&pageNo=${i}">${i}</a>
								</c:when>
								<c:otherwise>
								<a href="#" class='active' >${i}</a>
								</c:otherwise>
								</c:choose>
								&nbsp;
								</c:forEach>
								<c:if test="${pb.nextPageGroup}">	
								<a href="${pageContext.request.contextPath}/getSellerTradeListByFoodSellNo.do?foodSellNo=${foodSell.foodSellNo}
								&pageNo=${pb.endPageOfPageGroup+1}">&raquo;</a>
								</c:if>
									 		
				</div> <!-- pagination -->
				</div> <!-- pageginationContainer  -->
		</div> <!-- row -->
		
				</div> <!-- container -->
				
			</div><!-- blog-list blog-detail -->
		</div> <!-- col-md-10 -->
			<div class="col-md-1"></div>
	</div> <!-- container  -->
	
	

</div> <!-- page-container -->
</sec:authorize> <!-- sec -->
</section>	<!-- recent-list -->			



