<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- spring security custom tag를 사용하기 위한 선언 --%>
<%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="mvo" property="principal" />
<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
		<div class="row">
			<div class="col-sm-4">
				<!-- left -->

			</div>
			<div class="col-sm-4">
				<div class="blog-list blog-detail">
					<h3 class="title-form">
						<i class="fa fa-user-times"
							style="margin-right: 5px; font-weight: bold;"></i>회원 탈퇴
					</h3>
					<form class="form-large grey-color"
						action="${pageContext.request.contextPath }/deleteMember.do?memId=${mvo.memId}"
						method="post">
						<sec:csrfInput />
						<%-- csrf 토큰 --%>
						<a style="text-align: center; margin-top: 10px">회원 탈퇴 하시겠습니까?</a><br>
						<br>
						같은 아이디로는 재가입이 불가능 합니다.
						 <br> <br>
						<div align="center">
							<button type="submit" class="btn btn-reverse button-form"
								id="deleteBtn">예</button>
							<a href="${pageContext.request.contextPath }/home.do"><button type="button"
									class="btn btn-reverse button-form" style="margin-left: 10px"
									id="returnBtn">아니오</button></a>
						</div>
					</form>
				</div>
			</div>
			<div class="col-sm-4">
				<!-- right -->

			</div>
		</div>
	</div>
</section>
<section>
</section>