<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<sec:authentication var="mvo" property="principal" />
<section id="recent-list" style="margin-top: 150px;">
	<div class="container" style="height: 300px">
		<div class="col-sm-2">
		</div>
		<div class="col-sm-8">
			<h3>음식등록이 수정되었습니다.</h3>
			<div class="form-large grey-color" style="border-left: 0px;border-right: 0px;" align="center">
				<div>
					<a href="home.do">홈으로</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${memId}">판매자 마이페이지로</a>
				</div>
			</div>
		</div>
		<div class="col-sm-2">
		</div>
	</div>
</section>