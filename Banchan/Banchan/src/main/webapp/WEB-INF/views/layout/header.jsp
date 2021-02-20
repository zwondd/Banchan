<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="mvo" property="principal" />
<script type="text/javascript">
	$(document).ready(function() {
		$("#logoutAction").click(function() { 
			$("#logoutForm").submit();
		});
		$("#searchBtn").hover(function(){
			$("#searchkw").css("blink")
		});	
		$("#reportListBtn").click(function(){
			var reportList="";
			$.ajax({ 
				 type:"get",   
	             url:"${pageContext.request.contextPath}/reportmain.do",
	             success:function(data){
	            	 reportList += "<li>&nbsp;&nbsp;검색어 순위</li>"
	            		 for(var i=0;i<data.length;i++){
	                         reportList += "<li><a href='${pageContext.request.contextPath}/searchByKeyword.do?kw="+data[i].keyword+"'>"+data[i].rk+". "+data[i].keyword+"</a></li>";
	                      }//for
	            		 $("#reportList").html(reportList);
	             }//data
			});//ajax
		});//click
		mover();
	});//ready
	
	function mover(){
		var listcategory = ""; 
		$.ajax({
			type:"get",
			url:"${pageContext.request.contextPath}/category.do",
			success:function(data){  
				 for(var i=0;i<data.length;i++){	 
					 listcategory += "<li><a href='${pageContext.request.contextPath}/selectCategoryFood.do?category="+data[i].CATEGORY_NAME+"&pageNo=1'>"+data[i].CATEGORY_NAME+"</a></li>" ; 	   
				 } 
				 $("#navigation #headcategoryList").html(listcategory);
			}             
		});//ajax
	} //function
</script>		

<header class="menu-base" id="header-container-box"
	style="top: 0px !important;">
	<div class="info" style="height: 50px;">
		<!-- info -->
		<div class="container">
			<div class="row">
				<div class="col-md-6">
					<a href="${pageContext.request.contextPath}/home.do">
					<img src="${pageContext.request.contextPath}/resources/images/logo/header_logo5.png"
						style="margin-top: -2px; z-index: 1000; width: 200px"></a>  
				</div>
				<div id="login-pan" class="col-md-6">
					<sec:authorize access="!isAuthenticated()">
						<!-- 비회원 권한 설정 -->
						<a href="${pageContext.request.contextPath}/member/registerView.do"><i
							class="icon fa fa-pencil-square-o"></i> 회원가입</a>
						<a href="${pageContext.request.contextPath}/member/loginView.do"><i
							class="icon fa fa-user user"></i> 로그인</a>
					</sec:authorize>

					<sec:authorize access="hasRole('ROLE_BUYER') and !hasRole('ROLE_SELLER')">
						<!-- 오직 구매자 권한 설정 -->
						<a href="#" id="logoutAction" style="padding-left: 12px"><i class="fa fa-sign-out"></i>로그아웃</a>
						<form id="logoutForm"
							action="${pageContext.request.contextPath}/logout.do"
							method="post" style="display: none">
							<sec:csrfInput />
						</form>
						<a href="${pageContext.request.contextPath}/sellerRegisterForm.do?id=${mvo.memId}"><i
							class="icon fa fa-pencil-square-o"></i> 판매자 등록</a>
						<button class="btn btn-primary dropdown-toggle" type="button"
							data-toggle="dropdown"
							style="color: #1a1a1a; background-color: #fff; font-size: 12px; border: 0px; margin-top: 5px; float: right">
							<i class="icon fa fa-pencil-square-o"></i>마이페이지<span
								class="caret"></span>
						</button>   
						<ul class="dropdown-menu" style="margin-left: 36%;">
							<li><a href="${pageContext.request.contextPath}/editMemberView.do?memId=${mvo.memId}&pwQnaNo=<sec:authentication property="principal.pwQnaNo" />"><i class="fa fa-wrench" aria-hidden="true" style="margin-right: 5px;"></i>회원정보수정</a></li>
							<li><a href="${pageContext.request.contextPath}/myTradeList.do?memId=${mvo.memId}"><i class="fa fa-exchange" aria-hidden="true" style="margin-right: 5px"></i>구매내역</a></li>
							<li><a href="${pageContext.request.contextPath}/member/deleteMemberView.do"><i class="fa fa-user-times" aria-hidden="true" style="margin-right: 5px"></i>회원탈퇴</a></li>
						</ul>
						<a><label for="id" style="font-weight: bold;">${mvo.memName} 님</label></a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_SELLER')">
						<!-- 판매자 권한 설정 -->
						<a href="#" id="logoutAction" style="padding-left: 12px"><i class="fa fa-sign-out" aria-hidden="true"></i>로그아웃</a>
						<form id="logoutForm"
							action="${pageContext.request.contextPath}/logout.do"
							method="post" style="display: none">
							<sec:csrfInput />
						</form>
						<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}"><i
							class="icon fa fa-user user"></i> 판매자 페이지</a>
						<button class="btn btn-primary dropdown-toggle" type="button"
							data-toggle="dropdown"
							style="color: #1a1a1a; background-color: #fff; font-size: 12px; border: 0px; margin-top: 5px; float: right">
							<i class="icon fa fa-pencil-square-o"></i>마이페이지 <span
								class="caret"></span>
						</button>
						<ul class="dropdown-menu" style="margin-left: 36%;">
							<li><a href="${pageContext.request.contextPath}/editMemberView.do?memId=${mvo.memId}&pwQnaNo=<sec:authentication property="principal.pwQnaNo" />"><i class="fa fa-wrench" aria-hidden="true" style="margin-right: 5px;"></i>회원정보수정</a></li>
							<li><a href="${pageContext.request.contextPath}/myTradeList.do?memId=${mvo.memId }"><i class="fa fa-exchange" aria-hidden="true" style="margin-right: 5px"></i>구매내역</a></li>
							<li><a href="${pageContext.request.contextPath}/member/deleteMemberView.do"><i class="fa fa-user-times" aria-hidden="true" style="margin-right: 5px"></i>회원탈퇴</a></li>
						</ul>
						<a><label for="id" style="font-weight: bold;">${mvo.memName} 님</label></a>
					</sec:authorize>
				</div>
			</div>
		</div>
	</div>
	<!-- /.info -->
	<div class="menu-navbar" style="z-index: -1;">
		<div class="container" id="menu-nav">
			<div class="col-sm-2">
			</div> 
			<div class="col-sm-7">
			<nav id="navigation" style="margin-left: 140px">    
				<ul>
					<li class="has_submenu"><a href="">Home</a> 
						<ul>
							<li><a href="${pageContext.request.contextPath}/home.do">홈으로</a></li>
							<li><a href="${pageContext.request.contextPath}/intro/service_intro.do">소개</a></li>
						</ul>
					</li>
					<li class="has_submenu"><a href="${pageContext.request.contextPath}/locationServicePage.do">위치검색</a>
					
					</li>
					<li class="has_submenu" id="headcategory"><a href="${pageContext.request.contextPath}/selectCategoryFood.do?category=">카테고리검색</a>
						<ul id="headcategoryList" >
						
						</ul>
					</li>
				</ul> 
			</nav>
			</div>  
			<div class="col-sm-3">			
				<form action="searchByKeyword.do">
						<div class="searchForm">
							<input type="text" style="border: 0; width:71%; box-shadow: none; " autocomplete="off"  placeholder="&nbsp;&nbsp;검색" name="kw">
							<button class="btn btn-primary dropdown-toggle dropdown-hover searchBtn" type="button"
							data-toggle="dropdown" data-hover="dropdown" id="reportListBtn"
							style="border: none; background-color: #fff">
							<i class="fa fa-arrow-down" ></i> 
							</button>
							
						<ul class="dropdown-menu"  id="reportList" style=" width:71%;" >
							<li></li>
						</ul>
						
							<span><button class="searchBtn" type="submit">
							<i class="fa fa-search" aria-hidden="true"></i></button></span>
						</div>
					</form>
			</div>
				
		</div>
	</div>
	<!-- /.menu -->

	<a href="#" class="fixed-button top"><i class="fa fa-chevron-up"></i></a>
	<!-- 탑버튼 -->
	<!-- <a href="#" class="hidden-xs fixed-button email" data-toggle="modal" data-target="#modal-contact" data-section="modal-contact"><i class="fa fa-envelope-o"></i></a> -->
</header>

