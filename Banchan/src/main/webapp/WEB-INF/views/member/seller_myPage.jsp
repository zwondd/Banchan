<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authorize access="isAuthenticated()">
		<sec:authentication var="mvo" property="principal" />
 </sec:authorize>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
 <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/banchan.css">
<script type="text/javascript">
			function sellFoodPage(pageNoParam){
			var pageNo=pageNoParam;
			//판매중 음식, 판매중 음식 paging 눌렀을 때 실행
			$.ajax({
						type : "get",
						url : "${pageContext.request.contextPath}/sellerPagePagingAjax.do",
						data : "memId="
								+ $("#sellerId").val()
								+ "&pageNo="+pageNo,
						dataType : "json",
						success : function(data) {
							var sellInfo = "";
							for (var i = 0; i < data.list.length; i++) {
								
								sellInfo += "<div class='row' style='vertical-align: middle'>";
								sellInfo += "<div class='col-sm-8 col-md-8 col-sm-push-4'>";
								sellInfo += "<div class='bs-callout callout-success' style='width: 800px'>";
								sellInfo += "<a href='${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo="
										+ data.list[i].foodSellNo
										+ "'>";
								sellInfo += "<b style='font-size: 20px;font-weight: bold;margin-top: 10px;'>"
										+ data.list[i].foodName
										+ "</b></a>&nbsp;&nbsp;";
								
								sellInfo += "<span class='star_rating' style=''>";
								
								 for (var j = 0; j < (data.list[i].foodScore)-((data.list[i].foodScore)%1); j++) {
									sellInfo+="<a class='on' style='font-size: 15px;position:relative;bottom:3px;'>★</a>";
								}  
								 for (var j = 0; j < 5-((data.list[i].foodScore)-((data.list[i].foodScore)%1)); j++) {
									sellInfo+="<a style='font-size: 15px;position:relative;bottom:3px;'>★</a>";
								}
								sellInfo+="</span>"; 
										
								sellInfo += "<span class='description' style='color:black;font-size:12px;'>";
								
								sellInfo += "<table height='80px'><tr><td style='width: 100px;'><i class='fa fa-krw' style='font-weight: bold'>가격&nbsp;</i></td><td>"
										+ data.list[i].price+" &nbsp; &nbsp;(단위:"+data.list[i].unit+")"
										+ "</td></tr>";
								sellInfo += "<tr><td style='width: 100px;'><i class='fa fa-calendar' style='font-weight: bold'> 거래일</i></td><td>"
										+ data.list[i].trDate
										+ "</td></tr>";
								sellInfo += "<tr><td style='width: 100px;'> <i class='fa fa-close' aria-hidden='true' style='font-weight: bold'> 예약마감일</i></td><td>"
										+ data.list[i].closeDate
								sellInfo += "</td></tr></table>";
								
								sellInfo +='<sec:authorize access="!isAuthenticated()">';
								sellInfo +="<a style='float: right;position:relative;bottom:27px;'";
								sellInfo += "class='btn btn-reverse' href='${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo="
									+ data.list[i].foodSellNo
									+ "&pageNo=1'>더 볼래요</a>";
								sellInfo +='</sec:authorize>'; 
								
								sellInfo +='<sec:authorize access="isAuthenticated()">';
									 if ($("#sellerId").val() == $("#loginId").val()) {
										sellInfo +="<a style='float: right;position:relative;bottom:27px'";
										sellInfo += "class='btn btn-reverse' href='${pageContext.request.contextPath}/getSellerTradeListByFoodSellNo.do?foodSellNo="
											+ data.list[i].foodSellNo
											+ "&pageNo=1'>판매 내역 보기</a>";
									 
									}else{
										sellInfo +="<a style='float: right;position:relative;bottom:27px;'";
										sellInfo += "class='btn btn-reverse' href='${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo="
											+ data.list[i].foodSellNo
											+ "&pageNo=1'>더 볼래요</a>";
									} 
								sellInfo +='</sec:authorize>'; 
								
								sellInfo += "</span>";
								sellInfo += "</div>";
								sellInfo += "</div>";
								sellInfo += "<div class='col-sm-4 col-md-4 col-sm-pull-8' style='padding-top: 15px;' >";
								sellInfo += "<div class='tab2img' >";
								sellInfo += "<a style='width:100%;height:100%;' href='${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo="
										+ data.list[i].foodSellNo
										+ "'><img alt='Sample images'  width='250px' height='150px' src='${pageContext.request.contextPath}/resources/images/"+data.list[i].foodMainImg+"'></a>";
								sellInfo += "</div>";
								sellInfo += "</div>";
								sellInfo += "</div>";
							}

							$("#foodSellInfo")
									.html(
											sellInfo);
							var startPageOfPageGroupMinus = data.pb.startPageOfPageGroup - 1;
							var endPageOfPageGroupPlus = data.pb.endPageOfPageGroup + 1;
							var startPageOfPageGroup = data.pb.startPageOfPageGroup;
							var endPageOfPageGroup = data.pb.endPageOfPageGroup;
							var nowPage = data.pb.nowPage;
							var info = " <div class='pagination' style='text-align:center'>";
							if (data.pb.previousPageGroup) {
								info += "<a  id="+startPageOfPageGroupMinus+">&laquo;</a>";
							}
							for (var i = startPageOfPageGroup; i < endPageOfPageGroup + 1; i++) {
								if (nowPage != i) {
									info += "<a id="+i+">"
											+ i
											+ "</a>";
								} else {
									info += "<a id='-1' class='active'>"
											+ i
											+ "</a> &nbsp;";
								}
							}
							if (data.pb.nextPageGroup) {
								info += "<a  id="+endPageOfPageGroupPlus+">&raquo;</a>";
							}
							info += "</div>";
							$("#paginationAjax").html(info);
						}//success

					});//ajax
			
	}//sellFoodPage
	
	$(document).ready(function() {
						//음식 삭제, 수정
						$("button[name='update']").click(
										function() {
											location.href = "${pageContext.request.contextPath}/updateRegViewFood.do?foodNo="
													+ $(this).val()+ "&memId="+ $("#sellerId").val();
										});
						$("button[name='delete']").click(
										function() {
											location.href = "${pageContext.request.contextPath}/deleteRegFood.do?foodNo="
													+ $(this).val()+ "&memId="+ $("#sellerId").val();
										});
						$("button[name='seller']")
								.click(
										function() {
											location.href = "${pageContext.request.contextPath}/registerFoodView.do?foodNo="
													+ $(this).val();
										});
						
						//tab 클릭시 액션
						$(".tab_content").hide();
						$("ul.tab li:first").addClass("active").show();
						$(".tab_content:first").show();
						$("ul.tab li").click(function() {
							$("ul.tab li").removeClass("active");
							$(this).addClass("active");
							$(".tab_content").hide();
							var activeTab = $(this).find("a").attr("href");
							$(activeTab).fadeIn();
							return false;
						});

						
						//판매음식 클릭시
						$(".sellFood").click(function() {
							sellFoodPage(1);
							var offset = $("");
						});
						

						//동적으로 생성되는 페이징 번호에 대한 event
						$("#paginationAjax").on("click",".pagination a",function(){
							//현재 페이지를 클릭하지 않을 경우에만 실행
							if($(this).attr('id')!=-1){
							sellFoodPage($(this).attr('id'));
							var offset = $("#pagingScroll")
							.offset();
							$('html, body').animate({
							scrollTop : offset.top
							}, 1000);
							}
						});				
								
					

					});
</script>
<style type="text/css">

/*tab*/
ul.tab {
	
	padding: 0;
	float: left;
	list-style: none;
	height: 32px;
	border-bottom: 1px solid #e5e5e5;
	border-left: 0px solid #999;
	width: 100%;
}

ul.tab li {
	float: left;
	margin: 0;
	padding: 0;
	height: 31px;
	line-height: 31px;
	border: 0px solid #999;
	border-left: none;
	margin-bottom: -1px;
	overflow: hidden;
	position: relative;
	background: #fff;
}

ul.tab li a {
	/* text-decoration: none; */
	color: #5e5e5e;
	display: block;
	font-size: 1.0em;
	padding: 0 20px;
	border: 0px solid #fff;
	outline: none;
}

ul.tab li a:hover {
	color: #f47821;
}

html ul.tab li.active, html ul.tab li.active a:hover {
	background: #fff;
	border-bottom: 0px solid #e5e5e5;
}

#tabcontainer {
	border: 0px solid #999;
	border-top: none;
	overflow: hidden;
	clear: both;
	float: left;
	width: 100%;
	background: #fff;
}

.tab_content {
	padding: 20px;
	font-size: 1.2em;
}

#tab2Container {
	padding: 10px;
	border: 5px solid gray;
	margin: 0;
}

.home-top {
	margin-top: 100px;
}
#agent-page{
	margin-top: 150px;
	align-items: center;
}
</style>



<section id="agent-page"  style="margin-top: 100px;">
	<br>

	<div class="container">
		<div class="row">
			<div class="col-md-3">
				<div class="row">
			   <div class="" style="margin-left: 14px">
			                 <!-- . Agent Box -->
			                 <div class="agent-box-card grey">
			                     <div class="image-content">
			                         <div class="image image-fill">
			                             <!-- <img alt="Image Sample" src="resources/images/${svo.sellerImg }"> -->
			                             <img alt="Image Sample" style="width:270px;height:250px;" src="${pageContext.request.contextPath}/resources/images/${svo.sellerImg }">
			                         </div>						
			                     </div>
			                    <!--  <div class="info-agent" > -->
			                     <%--별점 위치 변경 --%>
			                         <%-- <div class="text" style="text-align:center">
			                               		 판매자 별점:<b>   ${svo.sellerScore}</b><br>
			                                 <span class="star_rating">  <!-- 별점 표현 -->
			                                     <c:forEach begin="1" end="${svo.sellerScore}">
			                                          <a class="on">★</a>
			                                     </c:forEach>
			                                     <c:forEach begin="1" end="${5-list.getSellerScore()}">
    													<a>★</a>
   												</c:forEach>
			                                  </span>
			                             <b>별점:${svo.sellerScore}</b>
			                         </div> --%>
			                       <%--sns 연결 보류 --%>
			                        <!--  <ul class="contact">
			                             <li><a class="icon" href="#"><i class="fa fa-facebook"></i></a></li>
			                             <li><a class="icon" href="#"><i class="fa fa-google-plus"></i></a></li>
			                             <li><a class="icon" href="#"><i class="fa fa-twitter"></i></a></li>
			                             <li><a class="icon" href="#"><i class="fa fa-envelope-o"></i></a></li>
			                             <li><a class="icon" href="agent-detail.html"><i class="fa fa-info-circle"></i></a></li>
			                         </ul> 
			                     </div>-->
			                 </div>
			
			             </div><!-- /.col-md-4 -->
				</div>
			</div>
		   <div class="col-md-6">
			         <div class="row">
			             <div class="" style="margin-left: 20px">
			                     <input type="hidden" id="sellerId" value="${svo.memId }">			                 
			                             <input type="hidden" id="loginId" value="${mvo.memId }">	
			                            	                        
			                     <b style="font-size: 30px;font-weight: bold;margin-top: 10px;" class="name">${svo.memName } </b> 
						                     <!-- 별점 표현 -->
						                    <span class="star_rating"> 
						                    <c:forEach begin="1" end="${svo.sellerScore-(svo.sellerScore%1)}">
			    							<a class="on">★</a>
											</c:forEach>
											 <c:forEach begin="1" end="${5-(svo.sellerScore-(svo.sellerScore%1))}">
			    							<a>★</a>
			    							</c:forEach> 
			      							</span>
   											&nbsp;&nbsp;&nbsp;&nbsp; 판매자 별점:<b>   ${svo.sellerScore}</b><br>
			                 <span class="address" style="font-weight:bold;color: #5e5e5e"><i class="fa fa-map-marker" style="padding-top: 5px"></i>&nbsp;${svo.addressVO.addressAPI}<br></span>
			                 <span id="pagingScroll"class="text">
			        			        <br> 주부님 소개
			                 </span> 
			                 <div class="bs-callout callout-success" style="width: 100%;position:relative;bottom:10px;height: 100px;">
							   <i class="fa fa-quote-left" aria-hidden="true" style=" font-size: 20px; color: #5e5e5e; margin-right: 10px;"></i>			                 
			                   <b style="color: #5e5e5e;">${svo.sellerInfo }</b>
			                   <i class="fa fa-quote-right" aria-hidden="true" style="font-size: 20px; color: #5e5e5e; margin-left: 10px;"></i>
			                 </div>
			             </div><!-- /.col-md-8 -->
			         </div><!-- /.row -->
			     </div><!-- col-md-9 -->
			  <div class="col-md-3">  
			  <sec:authorize access="isAuthenticated()">
					<c:if test="${mvo.memId==svo.memId}">
					  <div > 
			          <a href="getAllSellerTradeList.do?sellerId=${mvo.memId }&pageNo=1" class="btn btn-reverse" style="float:right;margin-left: 10px;" >전체 판매내역 보기</a>
					 </div>
					 <div > 
						<a href="${pageContext.request.contextPath}/foodRegisterForm.do"
							class="btn btn-reverse" style="float:right;">음식 등록</a> 
					</div>
					
					</c:if>
				</sec:authorize>
			</div>
		</div>
		<!-- ./row -->



		<div id="tabcontainer">
			<ul class="tab">
				<li class="active"><a href="#tab1">등록 음식 <b>(</b>${flist.size()}<b>)</b></a></li>
				<li><a href="#tab2" class="sellFood" id="1">판매중 음식 <b>(</b>${foodSellCount}<b>)</b></a></li>
			</ul>
		<div class="tab_container">

				<!-- tab1 -->
				<div id="tab1" class="tab_content" style="display: block;">
					<!-- 받아온 음식 반복 구간 -->
					<div class="my-property" data-navigation=".my-property-nav">
						<div class="crsl-wrap">
							<c:forEach items="${flist}" var="food">
								<figure class="crsl-item">
									<div class="box-ads box-grid">
										<a class="hover-effect image image-fill"
											href="${pageContext.request.contextPath}/foodDetailView.do?foodNo=${food.foodNo}">
											<%-- 	<input type="hidden" id="foodNo" value="${food.foodNo }"> --%>

											<span class="cover" style="height: 10px"></span> 
											<div style="width:100%;height:100%;">
											<img alt="Sample images"
											src="${pageContext.request.contextPath }/resources/images/${food.foodMainImg}">
											</div>
											<h3 class="title">${food.foodName}</h3>
										</a> 
										<span class="description">${food.foodDe}</span>
										 <dl style="display:inline-block;height:70px"  class="detail" > 
										<!-- <dl class="detail"> -->
										<table>
											<tr>
											<td >
											<!-- <small><i class="fa fa-star fa-fw" ></i></small> -->
											        <!--  <a class="star_rating.on" style="color: #ffcc00">★</a> -->
											<span class="star_rating" > 
						                    <c:forEach begin="1" end="${food.foodScore-(food.foodScore%1)}">
			    							<a class="on" style="font-size: 12px;">★</a>
											</c:forEach>
											 <c:forEach begin="1" end="${5-(food.foodScore-(food.foodScore%1))}">
			    							<a style="font-size: 12px;">★</a>
			    							</c:forEach> 
			      							</span>
			      				                <b style="font-size: 12px">&nbsp;&nbsp;별점 :&nbsp;&nbsp;${food.foodScore}</b> </td>
											</tr>
											<tr>
											<c:choose>
											<c:when test="${food.sellCheck==1}">
											<td><b style="font-size: 12px">판매중 상품이</b><b style="color:blue;font-size: 12px"> 있습니다.</b></td>
											</c:when>
											<c:otherwise>
											<td><b style="font-size: 12px">판매중 상품이 </b><b style="color:red;font-size: 12px"> 없습니다.</b></td>
											</c:otherwise>
											</c:choose>
											</tr>
										</table>
										
										</dl>
										<sec:authorize access="isAuthenticated()">
											<c:if test="${mvo.memId==svo.memId}">
												<div class="footer" style="height: 50px">
													<!-- <a class="btn btn-default" href="#"></a>
										<a class="btn btn-default" href="#"></a> -->

													<%-- <a  style="display:inline-block" class="btn btn-default" hre	f="${pageContext.request.contextPath}/registerFoodView.do?foodNo=${food.foodNo}">판매등록</a> --%>
													<button type="button" name="update" value="${food.foodNo }"
														style="margin-top: 60px; margin-left: 5px"
														class="btn btn-reverse btn-xs">수정</button>
													<button type="button" name="delete" value="${food.foodNo }"
														style="margin-top: 60px" class="btn btn-reverse btn-xs">삭제</button>
													<button type="button" name="seller" value="${food.foodNo }"
														style="margin-top: 60px; margin-left: 50px"
														class="btn btn-reverse btn-xs">판매등록</button>
												</div>
											</c:if>
										</sec:authorize>
									</div>
								</figure>
							</c:forEach>
						</div>
						<div class="my-property-nav">
							<p class="button-container">
								<a href="#" class="next">next</a> <a href="#" class="previous">previous</a>
							</p>
						</div>
					</div>
					<!-- myproperty -->

				</div>
				<!--tab1 -->

				<!-- tab2 -->
				<div id="tab2" class="tab_content" style="display: none;">
					<!-- 받아온 음식 반복 구간 -->

					<div class="tab2Container">

						<div class="col-md-9">
							<div id="foodSellInfo"></div>
							<!-- 여기서 부터 ajax 시작 -->
							<!-- 여기가 ajax 끝 -->
						</div>
						<div class="col-md-12">
							<div class="paginationContainer">
								<div id="paginationAjax" style="text-align: center;"></div>
							</div>
							<!-- paginationContainer -->
						</div>
					</div>

				</div>

			</div>
			<!-- tab_container -->
		</div>
		<!-- tabcontainer -->
	</div>
	<!-- ./container -->
</section>
<!-- /#about-us -->
