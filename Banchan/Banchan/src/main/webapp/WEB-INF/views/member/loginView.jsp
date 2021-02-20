<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
    
		<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
				<div class="row">
				<div class="col-sm-4"><!-- left -->
				
				</div>
					<div class="col-sm-4">
						<div class="blog-list blog-detail">
		<h3 class="title-form"><i class="icon fa fa-user user" style="margin-right: 5px; font-weight: bold;"></i>로그인</h3>
							<form class="form-large grey-color" action="${pageContext.request.contextPath }/login.do" method="post">
							
										<sec:csrfInput/><%-- csrf 토큰 --%>
									
										<label for="id" >아이디</label>
										<input type="text" placeholder="아이디" name="id" id="id" class="margin-bottom form-control" autocomplete="off">
								
										<label for="password" style="padding-top: 5px; ">비밀번호</label> 
										<input type="password" placeholder="비밀번호" name="password" id="password" class="margin-bottom form-control" autocomplete="off">
								
								<br>
								<button type="submit" class="btn btn-reverse button-form" style="float: left" id="loginBtn" >로그인</button>
								<a href="${pageContext.request.contextPath}/member/registerView.do"><button type="button"  class="btn btn-reverse button-form" style="margin-left: 25px" id="registerBtn" >회원가입</button></a>
								<a href="${pageContext.request.contextPath}/member/findPasswordView.do"><button type="button"  class="btn btn-reverse button-form" style="float: right;" id="findBtn" >비밀번호찾기</button></a>
							</form>		
							</div>
							</div>	
							<div class="col-sm-4"><!-- right -->
							
							</div>
							</div>
							</div>
	</section>
	<section>
	</section>
	
