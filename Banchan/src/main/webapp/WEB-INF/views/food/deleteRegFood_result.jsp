<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<sec:authentication var="mvo" property="principal" />
<script type="text/javascript">
	$(document).ready(function(){
		var memId=$("#memId").val();
		var result="${message}";
		var foodNumber=$("#foodNo").val();
		if(result=="fail"){
			alert("판매중인 음식이 존재합니다.");
			location.href="${pageContext.request.contextPath}/sellerPageInfo.do?memId="+memId;
		}else{
			var text;
			var result = confirm("선택한 음식을 삭제 하시겠습니까?");
			if (result == true) {
			    alert("선택한 음식이 삭제되었습니다.");
			    location.href="${pageContext.request.contextPath}/deleteRegFoodResult.do?foodNo="+foodNumber+"&memId="+memId
			} else {
				alert("삭제가 취소 되었습니다.");
			    location.href="${pageContext.request.contextPath}/sellerPageInfo.do?memId="+memId;
			}
			// alert("선택한 등록음식이 삭제되었습니다.");
			// location.href="${pageContext.request.contextPath}/sellerPageInfo.do?memId="+memId;
		}
	});
</script>
<section id="recent-list" style="margin-top: 150px;">
<input type="hidden" id="memId" value="${memId}">
<input type="hidden" id="foodNo" value="${foodNo}">

</section>