<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<style type="text/css">
table, th, td{
	text-align: center;
}
</style>
<sec:authentication var="mvo" property="principal" />
<section id="recent-list" style="margin-top: 100px;">
<div id="page-container">
	<div class="container" style="width: 100%">
		<div class="row">
			<h3 class="title-form"><i class="fa fa-exchange" aria-hidden="true" style="margin-right: 5px"></i>나의 구매내역</h3>				
			<a href="${pageContext.request.contextPath}/home.do" class="btn btn-default" style="float:right; margin-right:7%;"><i class="fa fa-home" style="font-size: 15px"></i></a>      
			<c:choose>           
			<c:when test="${fn:length(tlist.list)==0}">      
				<br><br><h4 style="text-align: center;font-weight: bold">거래내역이 없습니다.</h4>
				<div align="center">
					<a href="${pageContext.request.contextPath}/home.do" class="btn btn-reverse button-form" style="margin-top: 10px;">돌아가기</a>
				</div>
			</c:when>
			<c:otherwise> 
				<table class="table table-hover"  style="text-align: center;font-size: 12px; ">
					<thead>
						<tr class="tr_visible"> 
						<th>거래번호</th>
						<th>음식명</th>
						<th>거래신청날짜</th>
						<!-- <th>거래완료날짜</th> -->
						<th>거래일</th>
						<th>주문마감일</th>
						<th>거래장소</th>
						<th>구매수량</th>
						<th>단위</th>
						<th>단위당 가격</th>
						<th>총 주문가격</th>
						<th>판매자 이름</th>
						<th>판매자 연락처</th>
						<th>거래상태</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${tlist.list}" var="t">
			 			<tr>
						<td>${t.trNo}</td>
						<td>${t.foodSellVO.foodName}</td>
						<td>${t.trReqDate}</td>
						<%-- <td>${t.trFinDate}</td> --%>
						<td>${t.foodSellVO.trDate}</td>
						<td>${t.foodSellVO.closeDate}</td>
						<td>${t.foodSellVO.loc}</td>
						<td>${t.trQuantity}</td>
						<td>${t.foodSellVO.unit}</td>
						<td>${t.foodSellVO.price}원</td>
						<td>${t.foodSellVO.price*t.trQuantity}원</td>
						<td>${t.foodSellVO.sellerVO.memName}</td>
						<td>${t.foodSellVO.sellerVO.tel}</td>
						<td>${t.trStatus}</td>
						<c:if test="${t.trStatusNo=='2'}">  
						<td style="border-top-color: #fff">    
						<a href="${pageContext.request.contextPath}/reviewRegisterForm.do?foodSellNo=${t.foodSellVO.foodSellNo}&foodNo=${t.foodSellVO.foodNo}&memId=${t.foodSellVO.sellerVO.memId}"  style="color: red;margin-top:-7px">후기작성</a>
						</td>
						</c:if> 
						</tr>
					</c:forEach>
					</tbody>  
				</table>
				<div class="pageginationContainer" style="text-align: center;">
			  	  <div class="pagination" >
			  	  <c:set var="pb" value="${tlist.pb }"/>
			  	 <c:if test="${pb.previousPageGroup}">
					   <a href="${pageContext.request.contextPath}/myTradeList.do?memId=${mvo.memId}&pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a>
				</c:if>
					<c:forEach var="pageNum"  begin="${pb.startPageOfPageGroup}"  end="${pb.endPageOfPageGroup}">
				  		<c:choose>
				  			<c:when test="${pageNum==pb.nowPage}">
				  				 <a href="#" class='active' >${pageNum}</a>
			                </c:when>
				  			<c:otherwise>
				  				<a href="${pageContext.request.contextPath}/myTradeList.do?memId=${mvo.memId}&pageNo=${pageNum}">${pageNum}</a>
				  			</c:otherwise>
				  		</c:choose>
				  	</c:forEach>
			
					<c:if test="${pb.nextPageGroup}">
					   <a href="${pageContext.request.contextPath}/myTradeList.do?memId=${mvo.memId}&pageNo=${pb.endPageOfPageGroup+1}">&raquo;</a>
			       </c:if>
				   </div> 
				</div>
	<!-- pagination -->
			</c:otherwise>
		</c:choose>


	</div>
</div>
</div>
</section>