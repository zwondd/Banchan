<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<section id="recent-list" style="margin-top: 150px;">
			<div class="container">
				<div class="row">
				<div class="col-sm-4"><!-- left -->
				
				</div>
					<div class="col-sm-4">
						<div class="blog-list blog-detail">
		<h3 class="title-form"><i class="icon fa fa-comment" style="margin-right: 5px; font-weight: bold;"></i>비밀번호 찾기 질문 답변</h3>
							<form class="form-large grey-color" id="findPassForm" name="findPassForm" action="${pageContext.request.contextPath }/findPasswordQna.do" method="get">
										<input type="hidden" name="id" id="id" value="${mvo.memId}">
										<input type="hidden" name="name" id="name" value="${mvo.memName}">
										<label for="question">비밀번호 질문</label>
										<select id="question" name="question">
											<option value="100" selected="selected">질문을 선택하세요</option>
											<c:forEach items="${qnalist}" var="q">
															<option value="${q.pwQnaNo}">${q.pwQuest}</option>
											</c:forEach>
										</select> 
										<br>
										<label for="answer" style="padding-top: 5px; ">비밀번호 답변</label>
										<input type="text" placeholder="비밀번호 찾기 답변" name="answer" id="answer" class="margin-bottom form-control">
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