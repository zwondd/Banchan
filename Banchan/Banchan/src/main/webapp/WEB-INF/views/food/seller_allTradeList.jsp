<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
table, th, td{
	text-align: center;
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
			var buyerId=trade.children().eq(2).text();
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
		
		/* 거래완료확인 */
		$("button[name = 'completeTrade']").click(function() {
			if(confirm("거래완료 확인을 하시겠습니까?")==true){
				location.href="${pageContext.request.contextPath}/completeTrade.do?tradeNo="+$(this).val()+"&pageNo="+$("#pageNo").val();
			} else{
				return false;
			}
		}); //click
	}); //ready

</script>
    
<section id="recent-list" class="agency" style="margin-top: 100px">
<sec:authorize access="hasRole('ROLE_SELLER')"><!-- 오직 판매자 권한 설정 -->
<sec:authentication var="mvo" property="principal" />
<div id="page-container">
<div class="container" style="width: 100%;">
	<div class="row">
	<h3 class="title-form"><i class="icon fa fa-exchange"></i>전체판매내역</h3>   
	<div class="row"  style="margin-right:0px;">   
	<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}" class="btn btn-default" style="float:right; margin-right:0%;"><i class="fa fa-home" style="font-size: 15px"></i></a>
	</div>
		<div  class="row" style="font-size: 15px; text-align: right;margin-bottom: 10px; margin-right:0px; color: #80808075; font-style: italic">*클릭하여 구매자 정보를 확인하세요</div> 
	<c:choose>
	<c:when test="${!empty lvo.list}">      
	<table class="table table-hover" id="tradeList" style="text-align: center;font-size: 12px; " > 
	
		<thead>
			<tr class="tr_visible"> 
				<th style="width: 7%;">거래번호</th>
				<th style="width: 10%;">음식명</th>
				<th style="width: 10%;">구매자아이디</th>
				<th style="width: 10%;">거래신청날짜</th>
				<!-- <th>거래완료날짜</th> -->
				<th style="width: 10%;">거래일</th>
				<th style="width: 10%;">거래장소</th>
				<th style="width: 10%;">구매수량</th>
				<th style="width: 10%;">주문가격</th>
				<th colspan="2" style="width: 13%;">거래상태</th>
			</tr>
		</thead>
		<tbody >
			<c:forEach items="${lvo.list }" var="trade">
			<tr class="tr_visible" >
				<td>${trade.trNo }</td>
				<td><a href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=${trade.foodSellVO.foodSellNo}">${trade.foodSellVO.foodName}</a></td>
				<td>${trade.memId }</td>
				<td>${trade.trReqDate }</td>
				<%-- <td>${trade.trFinDate }</td> --%>
				<td>${trade.foodSellVO.trDate }</td>
				<td>${trade.foodSellVO.loc }</td>
				<td id="quantity">${trade.trQuantity }
				<input type="hidden" value="${trade.foodSellVO.price}" id="price">
				</td>
				<td id="orderPrice">${trade.trQuantity * trade.foodSellVO.price} </td>
				<c:choose>
					<c:when test="${trade.trStatus=='거래완료'}">
						<td colspan="2">거래완료되었습니다.</td>
					</c:when>
					<c:otherwise>
						<td>${trade.trStatus }</td>
						<td><button type="button"  name="completeTrade" value="${trade.trNo }" class="btn btn-default" style="background-color: #cc0000; border: 0px">거래완료</button></td>
					</c:otherwise>
				</c:choose>
			</tr>
			<tr class="trNone">
				<td colspan="2">구매자 아이디: <span id="buyerId"></span> </td>
				<td colspan="2" >구매자 이름: <span id="buyerName"></span></td>
				<td colspan="3">구매자 연락처: <span id="buyerTel"></span></td>
				<td colspan="4">구매자 주소: <span id="buyerAddress"></span></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</c:when>
	<c:otherwise>
		<div style="font-weight: bold;text-align: center;">판매 내역이 존재하지 않습니다</div>
		<div align="center">
		<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}" class="btn btn-reverse button-form" style="margin-top: 10px;">돌아가기</a>
		</div>
	</c:otherwise>
	</c:choose>
	</div> <!-- row -->
	
	<c:set value="${lvo.pb }" var="pb"/>
	<input type="hidden" value="${pb.nowPage}" id="pageNo">
	<div class="pageginationContainer" style="text-align: center;">
	<div class="pagination" >
		<c:if test="${pb.previousPageGroup}">
		    <a href="${pageContext.request.contextPath}/getAllSellerTradeList.do?sellerId=${mvo.memId}&pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a>
		</c:if>

	  	<c:forEach var="pageNum"  begin="${pb.startPageOfPageGroup}"  end="${pb.endPageOfPageGroup}">
	  		<c:choose>
	  			<c:when test="${pageNum==pb.nowPage}">
			    	<a href="${pageContext.request.contextPath}/getAllSellerTradeList.do?sellerId=${mvo.memId}&pageNo=${pageNum}" class="active">${pageNum}</a>
	  			</c:when>
	  			<c:otherwise>
			    	<a href="${pageContext.request.contextPath}/getAllSellerTradeList.do?sellerId=${mvo.memId}&pageNo=${pageNum}">${pageNum}</a>
	  			</c:otherwise>
	  		</c:choose>
	  	</c:forEach>

		<c:if test="${pb.nextPageGroup}">
		    <a href="${pageContext.request.contextPath}/getAllSellerTradeList.do?sellerId=${mvo.memId}&pageNo=${pb.endPageOfPageGroup+1}">&raquo;</a>
		</c:if>
	</div> <!-- pagination -->
	</div> <!-- pageginationContainer -->
</div><!-- container -->
</div> <!-- page-container -->
</sec:authorize> <!-- sec -->
</section>	<!-- recent-list -->			



