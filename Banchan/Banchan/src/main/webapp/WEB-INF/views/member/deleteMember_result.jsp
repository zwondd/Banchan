<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<script type="text/javascript"> 
$(document).ready(function() { 
		alert("회원 탈퇴가 완료 되었습니다.");
		$("#logoutForm").submit();
		/* $("#logoutForm").submit(function(){
				alert("회원 탈퇴가 완료 되었습니다.");
		}); */
});
</script>
<form id="logoutForm" action="${pageContext.request.contextPath}/logout.do" method="post" style="display: none">
	<sec:csrfInput />
</form>
