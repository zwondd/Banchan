<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
	<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication var="mvo" property="principal" />
</sec:authorize>
<script type="text/javascript">
function loginCheck(){
  	    var isLogin = $("#checkId").val();
			if(isLogin==null || isLogin==""){
		    var flag = confirm("로그인이 필요합니다. 로그인하시겠습니까?");
		    if(flag)
		       location.href="loginView.do";
		    else
		       history.go(0);
		 }
}
function registeSeller(){
	var flag = confirm("판매자 등록을 하시겠습니까?")
	if(flag)
		location.href="${pageContext.request.contextPath}/sellerRegisterForm.do?id=${mvo.memId}";
	else
		history.go(0);
}
</script>

 <!-- 슬라이드 부분 *************************** -->
 	
	<section id="home-slide" class="home-top"  style="margin-left: -11%; width: 122%">
			<div class="home-slider"  style="width: 100%" data-navigation=".home-slider-nav" >
				<div class="crsl-wrap">
					<div class="crsl-item" style="background-image: url('resources/images/img/main_img_00.png');">
						<div class="container slider-box">
						</div>
					</div>
					<div class="crsl-item" style="background-image: url('resources/images/img/main_img_01.png');">
						<div class="container slider-box">
						</div>
					</div>
					<div class="crsl-item" style="background-image: url('resources/images/img/main_img_02.png');">
						<div class="container slider-box">
						</div>
					</div>
				</div>
				<p class="home-slider-nav previus">
					<a href="#" class="previous">previous</a>
				</p>
				<p class="home-slider-nav next">
					<a href="#" class="next">next</a>
				</p>
			</div>
		</section>
<!-- 슬라이드 부분끝 *************************** -->

		<section id="recent-list" class="nexthome">
			<div class="section-detail">
				<h1>
				  <span>오늘은 </span>
				  <span id="spinner-show"  style="color: red; font-weight: bold;">
					  <em class="current" style="color: red; font-weight: bold;">순대국</em>
					  <span class="next"><span></span></span>
				  </span>
				  <span> 먹을까?</span>
				</h1>
				<ul id="spinner">
					 <li>제육볶음</li>
					 <li>김치찌개</li>
					 <li>갈비찜</li>
					 <li>닭 볶음탕</li>
					 <li>낙지젓갈</li>
				</ul>
				<h4  style="color: black;">집이 생각나는 따뜻한 밥상</h4>		
			</div> 
			
<c:if test="${fn:length(list)!=0}">
<!-- 인기 주부님 목록 -->
			<div class="container">
				<div class="list-box-title">
					<span><i class=""></i>인기 주부님</span>
				</div>
				<div class="row"> 
				<!-- 주부님 리스트 -->
				<c:forEach items="${list}" var="list">
					<div class="col-md-4">
						<div class="box-ads box-home" style="height: 425px">
							<a class="hover-effect image image-fill" href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${list.getMemId()}">
								<span class="cover"></span>
								<img alt="Sample images" style="width:380px;height:auto;" src="${pageContext.request.contextPath}/resources/images/${list.getSellerImg()}">
								<h3 class="title">${list.getMemName()} &nbsp;주부님</h3>
							</a><!-- /.hover-effect -->
							<span class="address"><i class="fa fa-map-marker"></i>&nbsp;${list.getAddressVO().getAddressAPI()}</span>
							<span class="description">${list.getSellerInfo()}</span>
							<dl class="detail">
							<div>
                      			<i class="fa fa-star" aria-hidden="true" style="margin-left: 4px; margin-right: 5px"></i>판매자 별점<br><br>
                       			 <span class="star_rating">  <!-- 별점 표현 -->
                         	  <c:forEach begin="1" end="${list.sellerScore-(list.sellerScore%1)}">
					    		<a class="on">★</a>
							  </c:forEach>
							  <c:forEach begin="1" end="${5-(list.sellerScore-(list.sellerScore%1))}">
					    		<a>★</a>
			    			  </c:forEach> 
                        		</span>
                             &nbsp;${list.getSellerScore()}
                         	</div>
       						</dl><!-- /.detail -->
						</div><!-- /.box-home .box-ads -->
					</div><!-- ./col-md-4 -->
				</c:forEach>		
			</div>
		</div>
	</c:if>
	<c:if test="${fn:length(flist)!=0}">
	<!-- 인기 음식 -->
		<div class="container">
				<div class="list-box-title">
					<span><i class=""></i>인기 음식</span>
				</div>
				<div class="row">
				<!--  인기 음식 -->
				<c:forEach items="${flist}" var="flist">
					<div class="col-md-4">
						<div class="box-ads box-home" style="height: 425px">
							<a class="hover-effect image image-fill" href="${pageContext.request.contextPath}/foodDetailView.do?foodNo=${flist.foodNo}">
								<span class="cover"></span>
								<img alt="Sample images" style="width:380px;height:270px" src="${pageContext.request.contextPath}/resources/images/${flist.foodMainImg}">
								<h3 class="title">${flist.foodName}</h3>
							</a><!-- /.hover-effect -->
							
							<span class="address"><i class="fa fa-map-marker"></i> ${flist.sellerVO.memName} &nbsp; 주부님</span>
							<span class="description">${flist.foodDe}</span>
								<dl class="detail">
							<div>
								<i class="fa fa-star" aria-hidden="true" style="margin-left: 4px; margin-right: 5px"></i>음식 별점<br><br>
								<span class="star_rating">  <!-- 별점 표현 -->
      							<c:forEach begin="1" end="${flist.foodScore-(flist.foodScore%1)}">
				    			<a class="on">★</a>
								</c:forEach>
								<c:forEach begin="1" end="${5-(flist.foodScore-(flist.foodScore%1))}">
				    			<a>★</a>
				    			</c:forEach> 
       							</span>
       							 &nbsp;${flist.foodScore}
       						</div>
       						</dl><!-- /.detail -->
						</div><!-- /.box-home .box-ads -->
					</div><!-- ./col-md-4 -->
					</c:forEach>
				</div>
			</div>
		</c:if>	 
		</section>
		<section id="submit-property" data-parallax-speed="0" align="center">
			<span class="overlay"></span>
			<div class="container">
				<div class="section-detail">
					<h1 style="color: #1a1a1a; font-weight: bold;">여러분이 주인공입니다.</h1>
					<h2 style="color: #1a1a1a">직접 만든 음식을 주변 사람들과 나누며 수익을 창출해 보세요.</h2>	
				</div>
				<div class="row text-center">
			<sec:authorize access="!isAuthenticated()"><!-- 비회원 권한 설정 -->
					<input type="hidden" value="" name="checkId" id="checkId">
					<a href="#" id="loginCheck" onclick="loginCheck()" class="btn btn-default button-large">판매자 등록하기</a>
			</sec:authorize>
			<sec:authorize access="hasRole('ROLE_BUYER')"><!-- 구매자 권한 설정 -->
					<a href="#" onclick="registeSeller()" class="btn btn-default button-large">판매자 등록하기</a>
			</sec:authorize>
				</div>
			</div>
		</section>


		

