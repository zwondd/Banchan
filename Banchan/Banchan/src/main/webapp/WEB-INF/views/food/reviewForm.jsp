<%@page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style type="text/css">
	.star_rating {font-size:0; letter-spacing:-4px;}
	.star_rating a {
	    font-size:22px;
	    letter-spacing:0;
	    display:inline-block;
	    margin-left:5px;
	    color:#ccc;
	    text-decoration:none;
	}
	.star_rating a:first-child {margin-left:0;}
	.star_rating a.on {color:#ffcc00;}
</style>

<script type="text/javascript">
//별점기능 javascript
$(document).ready(function() {
	 $(".star_rating a").removeClass("on");
	 $( ".star_rating a" ).click(function() {
	     $(this).addClass("on").prevAll("a").addClass("on");
	     var star = $(this).prevAll("a").length+1;
	    
	     $("#pstar").text(star);
	    
	     $( ".star_rating a" ).click(function() {
	     	if(($(this).prevAll("a").length+1)<star){
	     		$(".star_rating a").removeClass("on");    	
	     		$(this).addClass("on").prevAll("a").addClass("on");
	     	}
	     }); //click
	});//click
});//ready
</script>

<script type="text/javascript">
//후기작성 javascript
function reviewCheck(){
	var pText = $("#rContent");
	var score = $("#pstar");
	if(score.text()=="" || score.text()==null){
		alert("별점을 선택해주세요");
		return false;
	}
	$("#score").val(score.text());
	return true;
}
</script>    
<sec:authentication var="mvo" property="principal" />
<section id="recent-list" style="margin-top: 100px;">
	<div class="container">
	<div class="row" style="margin-left: 20%">         
	<h3 class="title-form"><i class="icon fa fa-pencil-square-o" style="margin-right: 5px"></i>후기작성</h3>
	</div>
	<div class="row" align="center">      
<form action="${pageContext.request.contextPath}/reviewRegister.do" style="width: 60%" class="form-large grey-color" onsubmit="return reviewCheck()" >	
          <div class="row">
           <span class="form-inline" role="form">                    
		              별점&nbsp;
				<span class="star_rating">  
				    <a href="#" class="on">★</a>
				    <a href="#" class="on">★</a>
				    <a href="#" class="on">★</a>
				    <a href="#" class="on">★</a>
				    <a href="#" class="on">★</a>
				</span>
				<span id="pstar"></span><br>
				<input type="hidden" id="score" name="score" value="">
				<input type="hidden" name="foodSellNo" value="${foodSellNo }">
           	  	<input type="hidden" name="memId" value="${memId }">
           	  	<input type="hidden" name="foodNo" value="${foodNo }">
           	  	  <sec:authorize access="isAuthenticated()">
			            <input type="hidden" name="writerId" value="${mvo.memId }">
			      </sec:authorize>
			        </span>      
			      </div>
              <br>    
  				<textarea id="rContent" name="rContent" class="form-control" rows="4" style="resize: none; width:70%;height:300px" required="required"></textarea>
           	 <div class="row" style="padding-top: 10px">
           	  <input type="submit" class="btn btn-danger" value="후기작성">
           	 </div>
           	      
          
              	 
         

 </form>
 </div>
	</div>
</section>