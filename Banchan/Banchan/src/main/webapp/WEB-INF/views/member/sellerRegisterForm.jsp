<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
 <sec:authorize access="isAuthenticated()">
    <sec:authentication var="mvo" property="principal" />
 </sec:authorize>
<script type="text/javascript">
function getimagereview(html, $target) {
    if (html.files && html.files[0]) {
        var reader = new FileReader();
        reader.onload = function (e) {
       		//$target.css('display', '');
	        $target.html('<img src="' + e.target.result + '" alt="" style="width:350px; height:200px;"/>');
        }
        reader.readAsDataURL(html.files[0]);
    }
}

$(document).ready(function(){
	$("#registerData").click(function(){
		var data=$("#dataCheck").val();
		if(data.length > 90 || data ==""){
			alert("판매자 소개는 80자 이내로 입력해주세요!");
			return false;
			}
		return true;
	}); //click
}); //ready

function checkForm(f){
	f=f.elements;
	var result = confirm("판매자로 등록 하시겠습니까?");
	if (result == true) {
		if(/.*\.(gif)|(jpeg)|(jpg)|(png)$/.test(f['uploadImage'].value.toLowerCase())){
	    	alert("판매자로 등록 되었습니다.");
			return true;
		}else{
			alert("업로드 할 수 없는 파일 입니다");
			return false;
				}
			}else{
				alert("판매자 등록이 취소 되었습니다.");
		return false;
	}
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

<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
		<div class="col-sm-1">
		</div>
		 
		<div class=" col-sm-10">
			<h3 class="title-form"><i class="icon fa fa-pencil-square-o" style="margin-right: 5px; font-weight: bold;"></i>판매자 등록</h3>
			<div class="blog-list blog-detail ">
					<form class="form-large grey-color"  style="height: 310px" action="sellerRegister.do?id=${mvo.memId}" method="post" enctype="multipart/form-data" onsubmit="return checkForm(this)">
					<label for="id" style="font-weight: bold; margin-left: 15px">프로필사진 업로드</label><br>  
				<div class="col-sm-6" >
					<sec:csrfInput/>
					<div style="margin-top: 5px;" class="file_input_div" >
					<input type="button" value="파일 선택" class="btn btn-reverse" style="margin-top: 8px" />
					<input type="file" class="file_input_hidden" value="파일 업로드" name="uploadImage" id="cma_file" required="required" accept="image/*" onchange="getimagereview(this,$('#cma_image'))" >
					<div id="cma_image" style="margin-top: 10px; width: 350px; height: 200px; border: solid 1px; #e1e1d0">
					</div>
					</div>
				</div>
				
				<div class="col-sm-6">
					<div style="position: relative;bottom: 25px;">
					<label for="id" style="font-weight: bold;">판매자 소개 :</label>  
					<br>
					<textarea rows="10" cols="100" id="dataCheck" name="sellerInfo" style="width: 400px; height: 200px; resize: none;"></textarea>
					</div>
					<div align="right" style="position: relative;bottom: 25px;">
					<input type="submit" id="registerData" class="btn btn-reverse button-form" value="등록">
					<a href="${pageContext.request.contextPath}" class="btn btn-reverse button-form">돌아가기</a>
					</div>
				</div>
					</form>
			</div>
		</div>
		<div class="col-sm-1">
		</div>
	</div>
</section>