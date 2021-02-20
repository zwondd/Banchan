<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<sec:authorize access="isAuthenticated()">
<sec:authentication var="mvo" property="principal" />
</sec:authorize>
<script>

function getimagereview(html, $target) {
    if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
       		//$target.css('display', '');
        	$target.html('<img src="' + e.target.result + '" alt="" style="width:350px; height:250px; background-size: cover;"/>');
        }
        reader.readAsDataURL(html.files[0]);
    }
}
function checkForm(f){
	f=f.elements;
	var result = confirm("음식을 등록 하시겠습니까?");
	if (result == true) {
		if(/.*\.(gif)|(jpeg)|(jpg)|(png)$/.test(f['uploadImage'].value.toLowerCase())){
	    	alert("음식이 등록 되었습니다.");
			return true;
		}else{
			alert("업로드 할 수 없는 파일 입니다");
			return false;
				}
			}else{
				alert("음식이 취소 되었습니다.");
		return false;
	}
}
function updateCheckForm(){
	var text;
	var result = confirm("선택한 음식을 수정 하시겠습니까?");
	if (result == true) {
	    text = "음식이 수정되었습니다.";
	    alert(text);
	    return true;
	}else{
		text="수정이 취소되었습니다";
		alert(text);
		history.go(-1);
		return false;
	}
}
function returnList(){
	location.href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${mvo.memId}";
}
</script>
<style>
.btn btn-default
{
width: 100px;
position: absolute;
top: 0px;
background-color: #33BB00;
color: #FFFFFF;
border-style: solid;
}
 
.file_input_hidden
{
font-size: 45px;
position: absolute;
right: 0px;
top: 0px;
opacity: 0;
 
filter: alpha(opacity=0);
-ms-filter: "alpha(opacity=0)";
-khtml-opacity: 0;
-moz-opacity: 0;
}

</style>
<section id="recent-list" style="margin-top: 100px;">
<c:choose>
<c:when test="${message!='ok'}">
	<div class="container">
		<div class="row">
			<div class="col-sm-1">
				<!-- left -->
			</div>
			<!--  음식 등록 페이지 -->
			<div class="col-sm-10">
			<h3 class="title-form"><i class="fa fa-pencil-square-o" aria-hidden="true" style="margin-right: 5px"></i>음식등록페이지</h3>
				<div class="blog-list blog-detail">
					<form class="form-large grey-color" action="foodRegister.do" method="post" enctype="multipart/form-data" onsubmit="return checkForm(this)">
					<label>음식명 :	<input type="text" class="margin-bottom form-control" name="foodname" required="required"> 
						</label>
						<input type="hidden" name="id" value="${mvo.memId}">
						<sec:csrfInput/> 
						<%-- csrf 토큰 --%>
						<div class="row">
							  
						<!-- <i class="icon fa fa-pencil-square-o" style="margin-left: 12px;"><label style="margin-left: 5px; margin-bottom: 5px;">상세내용</label></i> -->
						<div class="col-xs-5" style="float: left" class="row">
						<select name="category">
								<c:forEach items="${category}" var="categorylist">
								<option value="${categorylist.CATEGORY_NO }">${categorylist.CATEGORY_NAME}</option>
								</c:forEach>
						</select>
						
						<input type="button" value="파일 선택" class="btn btn-reverse" style="margin-top: 8px" />
						<div style="margin-top: 10px;" class="file_input_div">
							<input type ="file"  class="file_input_hidden" value="파일 업로드" name="uploadImage"  id="cma_file" required="required" accept="image/x-png, image/gif, image/jpeg" onchange="getimagereview(this,$('#cma_image'))"/>
							<div id="cma_image" style="margin-top: 10px; width:350px; height:250px; background-size: cover; border: solid 1px; #e1e1d0">
							</div>
							 </div>
						</div>

						<div class="col-xs-7" style="float: right; margin-bottom: 50px;position: relative;bottom: 30px;" class="row">  
							<label style="margin-left: 5px; margin-bottom: 5px;"><i class="icon fa fa-pencil-square-o" ></i>상세내용</label>
							<textarea rows="10" cols="52" name="foodInfo" style="width: 100%; height: 100%;  resize: none;"  placeholder="내용을 입력하세요"></textarea>
							<input style="margin-left: 77%" type="submit" class="btn btn-reverse" value="등록" >
							<a href="#" onclick="returnList()" class="btn btn-reverse button-form" style="float: right;">취소</a>
						</div>   
						</div>    
						</form> 
				</div>
			</div>
			<div class="col-sm-1">
				<!-- right -->
			</div>
			
		</div> <!-- row -->
		</div> <!-- container  -->
		</c:when>
<c:otherwise>
	<div class="container">
		<div class="row">
			<div class="col-sm-1">
				<!-- left -->
			</div>
			<!--  등록 음식 수정 페이지 -->
				<div class="col-sm-10">
				<h3 class="title-form"><i class="icon fa fa-wrench" style="margin-right: 5px"></i>음식수정페이지</h3>
				<div class="blog-list blog-detail">
					<form class="form-large grey-color" action="updateRegFood.do" method="post" enctype="multipart/form-data" onsubmit="return updateCheckForm()">
					<h2 class="title-form"><input type="text" name="foodname" value="${beFood.foodName}"></h2>
						<input type="hidden" name="memId" id="memId" value="${memId}">
						<input type="hidden" name="foodNo" value="${foodNo}">
						<sec:csrfInput/>
						<%-- csrf 토큰 --%>
						<div class="row">
							
						<div class="col-xs-5" style="float: left" class="row">
						<select name="category">
								<c:forEach items="${category}" var="categorylist">
								<c:choose>
								<c:when test="${beFood.categoryNo==categorylist.CATEGORY_NO }">
								<option value="${categorylist.CATEGORY_NO }" selected="selected">${categorylist.CATEGORY_NAME}</option>
								</c:when>
									<c:otherwise>
									<option value="${categorylist.CATEGORY_NO }">${categorylist.CATEGORY_NAME}</option>
									</c:otherwise>
									</c:choose>
								</c:forEach>
						</select>
						<input type="button" value="파일 선택" class="btn btn-reverse" style="margin-top: 8px" />
						<div style="margin-top: 10px;" class="file_input_div">
							<input type ="file"  class="file_input_hidden" value="파일 업로드" name="uploadImage"  id="cma_file" accept="image/*" onchange="getimagereview(this,$('#cma_image'))"/>
							<div id="cma_image" style="margin-top: 10px;">
								<img src="${pageContext.request.contextPath }/resources/images/${beFood.foodMainImg}" alt="" style="width:350px; height:200px;"/>
							</div>
							 </div>
						</div>
						<div class="col-xs-7" style="float: right" class="row">
							<textarea rows="10" cols="52" name="foodInfo" style="width: 100%; height: 100%;">${beFood.foodDe}</textarea>
							<input style="margin-left: 77%" type="submit" class="btn btn-reverse" value="수정" >
							<a href="#" onclick="returnList()" class="btn btn-reverse button-form" style="float: right;">취소</a>	
						</div>
						</div>
						</form>
				</div>
			</div> 
		</div>
		<div class="col-sm-1">
			<!-- right -->
		</div>
	</div>
</c:otherwise>
</c:choose>
</section>
