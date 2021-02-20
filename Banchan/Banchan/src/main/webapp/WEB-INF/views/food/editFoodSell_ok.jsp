<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function() {
	alert("수정되었습니다.");
	location.href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=" + $("#foodSellNo").val();
});
</script>

<input type="hidden" value="${foodSellNo}" id="foodSellNo">