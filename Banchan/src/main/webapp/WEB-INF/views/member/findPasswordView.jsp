<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="mvo" property="principal" />
<script type="text/javascript">

</script>
		<section id="recent-list" style="margin-top: 150px;">
			<div class="container">
				<div class="row">
				<div class="col-sm-4"><!-- left -->
				
				</div>
					<div class="col-sm-4">
						<div class="blog-list blog-detail">
		<h3 class="title-form"><i class="icon fa fa-search" style="margin-right: 5px; font-weight: bold;"></i>비밀번호 찾기</h3>
							<form class="form-large grey-color" id="findPassForm" name="findPassForm" action="${pageContext.request.contextPath }/findPasswordCheck.do" method="post">
										<sec:csrfInput/><%-- csrf 토큰 --%>
										<label for="id">아이디</label>
										<input type="text" placeholder="아이디" name="id" id="id" class="margin-bottom form-control">
								 
										<label for="password" style="padding-top: 5px; ">이름</label>
										<input type="text" placeholder="이름" name="name" id="name" class="margin-bottom form-control">
										
										<label for="password" style="padding-top: 5px; ">전화번호</label>
										<input type="tel" placeholder="전화번호" required pattern="[0-9]{3}-[0-9]{3-4}-[0-9]{4}" title="###-####-####" name="telNo" id="telNo" class="margin-bottom form-control">
								<br>
								<div align="center"> 
								<button type="submit" class="btn btn-reverse button-form"  id="findPassBtn" >확인</button>
								<a href="${pageContext.request.contextPath}/home.do"><button type="button"  class="btn btn-reverse button-form" style="margin-left: 20px" id="findBtn" >홈으로</button></a>
								</div>
							</form>		
							</div>
							</div>	
							<div class="col-sm-4"><!-- right -->
							
							</div>
							</div>
							</div>
		</section>