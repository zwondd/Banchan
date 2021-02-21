<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<sec:authorize access="isAuthenticated()">
<sec:authentication var="mvo" property="principal" />
</sec:authorize>
<!-- 별점 style부분 ************************* -->
 <style type="text/css"> /* 별점 css */
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
.home-top{
	margin-top: 100px;
}
.tableTr{
	border: hidden;
}
</style>     

<script type="text/javascript">
	$(document).ready(function () {
		
		   var foodSellNo = $("#foodSellNo").val(); //게시글 번호 
	   /*주문 수량 확인하기*/
	   $("#trQuantity").change(function () {
	      //구매수량이 준비수량보다 적은지 확인
	      var leftQuantity=$("#leftQuantity").text();
	      if(parseInt($(this).val()) > parseInt(leftQuantity)){
	         alert("준비수량이 부족합니다!");
	         $("#trQuantity").val(1); 
	      }
	      var orderPrice=$(this).val()*$("#price").text();
	      $("#orderPrice").text(orderPrice);
	   }); //trQuantity change
	   
	   /*판매 음식 삭제하기*/
	   $("#deleteFood").click(function() {
	      if(deleteFlag=confirm("삭제하시겠습니까?")){
	         $.ajax({
	             type:"get",
	              url:"${pageContext.request.contextPath}/deleteConfirmAjax.do",
	              data:"foodSellNo="+foodSellNo,
	              success:function(data){
	                 if(data>=1)
	                    alert("구매자가 있어 삭제할 수 없습니다.");
	                 else{
	                    alert("상품이 삭제되었습니다.");
	                    location.href="${pageContext.request.contextPath}/deleteFoodSell.do?foodSellNo="+foodSellNo+"&sellerId="+$("#sellerId").val();
	                 }//if-else
	              }//success  
	         }); //ajax   
	      }//if
	   }); //delFood click

	   /* 판매음식 수정하기  */
	   $("#editFoodSell").click(function() {
	      if(deleteFlag=confirm("수정하시겠습니까?")){
	         $.ajax({
	             type:"get",
	              url:"${pageContext.request.contextPath}/deleteConfirmAjax.do",
	              data:"foodSellNo="+foodSellNo,
	              success:function(data){
	                 if(data>=1){
	                    alert("구매자가 있어 수정할 수 없습니다.");
	                 }
	                 else{
	                  /* location.href="${pageContext.request.contextPath}/editFoodSellView.do?foodSellNo="+$("#foodSellNo").val(); */
	                  location.href="${pageContext.request.contextPath}/editFoodSellView.do?foodSellNo="+foodSellNo;
	                 }//if-else
	              } //success
	         }); //ajax   
	      }//if
	   }); //click

	   commentList(); //실행시 댓글 목록 불러옴_정훈
	   $("[name=commentInsertBtn]").click(function(){ //댓글 등록 버튼 클릭시
		  if($("#memId").val()==null || $("#memId").val()==""){
		   		alert("로그인 후 작성가능 합니다");
		   		history.go(0);
		   	}else{
			var insertData = $("[name=commentInsertForm]").serialize(); //commentInsertForm의 내용을 가져옴
			commentInsert(insertData); //Insert 함수호출(아래)
		   	}
		}); 
	   
	});//ready
	
	/*질문 댓글 작성하기*/		
     //var foodSellNo = $("#foodSellNo").val(); //게시글 번호 
	var foodSellNo = ${foodSell.foodSellNo};//판매음식번호_수정한거
	/*댓글 등록*/
	function commentInsert(insertData){
		 $.ajax({
	        type : "get",
	        url : "${pageContext.request.contextPath}/commentInsert.do",
	        data : insertData,
	        success : function(data){
	        	  if(data== 1) {
	                commentList(); //댓글 작성 후 댓글 목록 reload
	                $("[name=content]").val("");
	             }//if
	        }//success
	    }); //ajax
	}//function
	
	/*댓글 목록 불러오기*/
	function commentList(){
		 $.ajax({
		     url : "${pageContext.request.contextPath}/commentList.do",
		     type : "get",
		     data : {"foodSellNo":foodSellNo},
		     success : function(data){
		        var a =""; 
		        
		          $.each(data, function(key, value){ 
		        	  
		         	   	a += '<div class="commentArea" style="border-bottom:1px solid darkgray; margin-bottom: 15px;">';
		              	a += '<div class="commentInfo'+value.questNo+'">'+'NO : '+value.questNo+' /작성자 : '+value.memId;
						
		                a += '/작성시간 :'+value.questPostdate+'';
		                if($("#memId").val()==value.memId){
		                a += '<span style="float: right;"><a onclick="commentDelete('+value.questNo+',\''+value.memId+'\');"> 삭제 </a></span>';
		                }
		               	/* a += '<a onclick="commentUpdate('+value.questNo+',\''+value.questContent+'\');"> 수정 </a>'; */
		                a += '<div class="commentContent'+value.questNo+'"> <p> 질문내용 : '+value.questContent +'</p>';
		                	for(var i=0; i<value.answerList.length; i++){
		                	a += '<div class="ansContent'+value.questNo+'">┗Re ('+value.answerList[i].memId+') : '+value.answerList[i].ansContent+'<span style="float: right;"> 작성시간 :'+value.answerList[i].ansPostdate+' </span>';
		                	if(value.answerList[i].memId == '${mvo.memId}'){
			                	a += '&nbsp;<a onclick="answerDelete('+value.answerList[i].ansNo+',\''+foodSellNo+'\');">삭제</a>';
			                	
			                	}//if
		                	a +='</div>';
		                      }//for		              	
		                a +='<a onclick="commentAnswerReply('+value.questNo+',\''+value.memId+'\');"> 답변달기 </a></div>';
		               
		                /* a += '<span style="float: right;"><a onclick="commentAnswerReply('+value.questNo+',\''+value.memId+'\');"> 답변달기 </a></span>'; */

		                a += '<div class="commentAnswerRe'+value.questNo+'">'+'</div>';
		              	a += '</div></div>'; 
		             
		            });//each
		          $(".commentList").html(a);
		      	}//success
		    }); //ajax 
	}//function
	
	function answerDelete(answerNo,foodSellNo){
    	$.ajax({
		     url : "${pageContext.request.contextPath}/answerDelete.do",
		     type : "get",
		     data : "answerNo="+answerNo+"&foodSellNo="+foodSellNo,
		     success : function(data){
		    		 commentList(foodSellNo);
		      	},//success
		      error: function(data){
		    	  alert("answer delete error");
		      }
		    }); //ajax
    }//answerDelete function
    
		//질문 답변 달기 - 답변 달기 내용 출력을 input 폼으로 변경 
		 function commentAnswerReply(questNo, memId){

			  if($("#memId").val()==null || $("#memId").val()==""){
				   		alert("로그인 후 작성가능 합니다");
				   		history.go(0);
				   	}else{

		    var a ="";
		     a += '<div class="input-group">';
		    a += '<input type="text" class="form-control" id="answerContent" name="ansContent"/>';
		    a += '<input type="hidden" id="memId2" name="memId2" value="'+$("#memId").val()+'">';
		    a += '<input type="hidden" id="questNo" name="questNo" value='+questNo+'>';
		    a += '<span class="input-group-btn"><button class="btn btn-reverse" type="button" onclick="commentAnswerReplyProc();">답변달기</button> </span>';
		    a += '</div>';
		    $('.commentAnswerRe'+questNo).html(a).toggle(); 
		}
		 $("[name=commentInsertForm]").serialize();
    }
		//질문 답변 달기
		 function commentAnswerReplyProc(questNo){
			var answer=$("#answerContent").val();
			var memId=$("#memId2").val();
			var questNo=$("#questNo").val();
			$.ajax({
	            type:"get",
	            url:"${pageContext.request.contextPath}/answerRegister.do",
	            data:"questNo="+questNo+"&memId2="+memId+"&ansContent="+answer,
	            dataType:"json",
	            success:function(data){
	            		commentList(questNo);
	            } 
	            
	         });//ajax   
		}
	
	
		
		/*댓글 수정 시 댓글 내용을 input폼으로 변경 - 아래 commentUpdateProc()호출*/ 
		/* function commentUpdate(questNo, questContent){
				
			var a ="";
		    a += '<div class="input-group">';
		    a += '<input type="text" class="form-control" id="toggle_btn_commentUpdateText" name="content_'+questNo+'" value="'+questContent+'"/>';
		    a += '<span class="input-group-btn"><button class="btn btn-reverse" type="button" onclick="commentUpdateProc('+questNo+');">수정</button> </span>';
		    a += '</div>';
		    $('.commentContent'+questNo).html(a).toggle();
		} */
		/*댓글 수정*/
		/* function commentUpdateProc(questNo){
			var updateContent = $("[name=content_"+questNo+"]").val();
		    $.ajax({
		        url : "${pageContext.request.contextPath}/commentUpdate.do",
		        type : "get",
		        data : {"content" : updateContent, "questNo" : questNo},
		        success : function(data){
		            if(data == 1) 
		            	commentList(questNo); //댓글 수정후 목록 출력 함수 호출
		        }//success
		    });//ajax
		}//commentUpdateProc
		 */
		/*댓글 삭제*/ 
		function commentDelete(questNo, memId){
			 if($("#memId").val()!=memId){
			   		alert("작성자만 삭제할 수 있습니다");
			   		history.go(0);
			   	}else{
			  $.ajax({
		        url : "${pageContext.request.contextPath}/commentDelete.do?questNo="+questNo,
		        type : "get",
		        success : function(data){
		            if(data == 1) 
		           	 commentList(foodSellNo); //댓글 삭제후 목록 출력 함수 호출
		        }//success
		    });//ajax
			  }//if-else
		}//commentDelete
		
		/*구매 조건 체크 함수*/
		function orderFoodConfirm(){ //윤주
		      var isLogin = $("#checkId").val();
		      var leftQuantity=$("#leftQuantity").text();
		      
		      if(parseInt(leftQuantity)==0){
		         alert("준비 수량이 모두 소진되었습니다");
		      }
		      else if(isLogin==null || isLogin==""){
		         var flag = confirm("로그인하셔야 구매 가능합니다. 로그인하시겠습니까?");
		         if(flag)
		            location.href="loginView.do";
		         else
		            history.go(0); 
		      }
		      else
		         return confirm("구매하시겠습니까?");
		      return false; 
		   }
</script>

<!-- 수정 후 코드입니다. -->

<section id="recent-list" class="agency" style="margin-top: 150px">
<div class="container" style="width: 100%">
<div class="row">
   <div class="col-sm-1"></div><!-- col-sm-1 -->
   <div class="col-sm-10"> 
   <div class="blog-list blog-detail">  
       <div class="row" style="padding-top: 10px; padding-right: 14px" align="right">           
      <h3 class="title-form" style="float: left;"><i class="icon fa fa-wrench" style="margin-right: 5px;"></i>판매음식 상세정보</h3>
     <a href="${pageContext.request.contextPath}/sellerPageInfo.do?memId=${foodSell.memId}" class="btn btn-reverse button-form" style="margin-left: 10px;">판매자 페이지로</a>
      </div>
      <div class="form-large grey-color"> 
      <div class="row">
      <div class="col-xs-6" style="float: left" class="row">
         <img style="padding-top: 48px" width="350px" height="250px" src="${pageContext.request.contextPath}/resources/images/${foodSell.foodMainImg}">
      </div>
      <div class="col-xs-6" style="float: right" class="row">
         <div class="row">
            <h3 class="title-form"><i class="" style="margin-right: 5px"></i>${foodSell.foodName} 
     	
                  	 <!-- 별점 표현 -->
						<span class="star_rating"> 
						<c:forEach begin="1" end="${foodSell.foodScore-(foodSell.foodScore%1)}">
			    		<a class="on">★</a>
						</c:forEach>
						<c:forEach begin="1" end="${5-(foodSell.foodScore-(foodSell.foodScore%1))}">
			    		<a>★</a>
			    		</c:forEach> 
			      		</span>
			      		<b>${foodSell.foodScore}</b>
   		   </h3>  
         </div>
         <div class="row" style="border-top: 1PX solid #928f8f ;border-bottom: 1PX solid #928f8f;margin-top: 5px;margin-bottom: 5px;">
            <table class="table" style="font-size: 13px; table-layout: fixed; height:auto; overflow: hidden;">
         
               <tr class="tableTr">
                  <th>예약마감일</th>
                  <td>${foodSell.closeDate}</td>
               </tr>
               <tr class="tableTr">
                  <th>거래일</th>
                  <td>${foodSell.trDate}</td>
               </tr>
               <tr class="tableTr">
                  <th>가격</th>
                  <td><span id="price">${foodSell.price}</span> 원</td>
               </tr>
               <tr class="tableTr">
                  <th>양(개당)</th>
                  <td>${foodSell.unit}</td>
               </tr>
               <tr class="tableTr">
                  <th>준비수량</th>
                  <td><span id="preQuantity">${foodSell.preQuantity}</span>&nbsp;(${foodSell.unit })</td>
               </tr>
               <tr class="tableTr">
                  <th>남은수량</th>
                  <td><span id="leftQuantity">${leftQuantity}</span>&nbsp;(${foodSell.unit })</td>
               </tr>
               <tr class="tableTr">
                  <th>거래장소</th>
                  <td colspan="3">${foodSell.loc}</td>
               </tr>
               <tr class="tableTr">
                  <th>음식소개</th>
                  <td colspan="3">${foodSell.foodDe}</td>
               </tr>
               <tr class="tableTr">
                  <th>판매추가정보</th>
                  <td colspan="3">${foodSell.sellDetail}</td>
               </tr>                  
            </table> 
         </div>
      </div><!-- col-xs-6 -->
      </div><!-- row -->
      
      

      <form action="${pageContext.request.contextPath}/orderFood.do" onsubmit="return orderFoodConfirm()">
             <sec:authorize access="hasRole('ROLE_BUYER')"><!--구매자 권한 설정 -->
                 <input type="hidden" name="memId" id="checkId" value="${mvo.memId }">
              </sec:authorize>
            <div class="row" style="margin-top: 10px"> 
               <input type="hidden" name="foodSellVO.foodSellNo" value="${foodSell.foodSellNo}" id="foodSellNo"/> 
               <input type="hidden" name="sellerId" value="${foodSell.memId}" id="sellerId"/>
            <c:choose>
            <c:when test="${foodSell.memId!=mvo.memId || mvo.memId=='' || mvo.memId==null}">
             <div class="col-sm-2" style="text-align: right">구매수량:</div>
             <div class="col-sm-2">
                 <input type="number" min="1" name="trQuantity" id="trQuantity" class="form-control" style="width: 100px" required="required"/>
             </div>
             <div class="col-sm-3">
                 <label class="control-label" for="거래가격">거래가격: </label> 
               <span id="orderPrice"></span>원
             </div>
            </c:when>
            </c:choose>
            </div> <!-- row -->
                
            <div class="row" align="center">
              <c:choose>
                 <c:when test="${foodSell.memId!=mvo.memId}">
                   <input type="submit"  class="btn btn-reverse" style="margin-top: 20px;"  value="구매하기">
                 </c:when>
                <c:otherwise>
                   <input type="button"  class="btn btn-reverse" id="editFoodSell" style="margin-top: 20px;"  value="수정하기">
                   <input type="button"  class="btn btn-reverse" id="deleteFood" style="margin-top: 20px;" value="삭제하기">
                </c:otherwise>                   
              </c:choose>    
            </div>
        </form>
      </div> <!-- form-large grey-color -->
     <!-- 후기 작성 부분 입니다_윤주 -->  
      <div class="row" style="margin-top: 40px">
      <h4><i class="fa fa-pencil-square-o" aria-hidden="true"></i>후기</h4>
      <c:choose>
		<c:when test="${fn:length(rlist.list)==0}">
			<h5>작성된 후기가 없습니다</h5>
		</c:when>
		<c:otherwise> 
			<table class="table table-hover" style="text-align: center;font-size: 12px;">
				<thead>
					<tr class="tr_visible"> 
						<td>NO</td>
						<td style="width: 150px;">별점</td> 
						<td>내용</td>
						<td>작성자</td>
						<td>날짜</td> 
						<td></td>
					</tr>
				</thead>
				<tbody>
				<c:forEach items="${rlist.list }" var="r">
					<tr>
						<td>${r.revNo }</td>
						<td align="left">
							<span class="star_rating">  <!-- 별점 표현 -->
	      						<c:forEach begin="1" end="${r.score}">
	    							<a class="on">★</a>
								</c:forEach>
								<c:forEach begin="${r.score}" end="4">
                           			<a>★</a>
                        		</c:forEach>
       						</span>
						${r.score }
						</td>
						<td>${r.revContent }</td>
						<td>${r.memId }</td>
						<td>${r.revPostdate }</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
		</c:otherwise>
	</c:choose>
</div><!--후기 작성 리스트 row-->
<!-- 후기 페이징입니다_윤주 -->
<c:set value="${rlist.pb }" var="pb"/>
<div class="row" style="text-align: center;">
	<div class="pageginationContainer">
		<div class="pagination">
			 <c:if test="${pb.previousPageGroup}">
				<a href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=${sellfood.foodSellNo }&pageNo=${pb.startPageOfPageGroup-1}">&laquo;</a>
			 </c:if>
			 <c:forEach var="pageNum"  begin="${pb.startPageOfPageGroup}"  end="${pb.endPageOfPageGroup}">
			  	<c:choose>
			  		<c:when test="${pageNum==pb.nowPage}">
					  <a href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=${foodSell.foodSellNo }&pageNo=${pageNum}" class="active">${pageNum}</a>
			  		</c:when>
			  		<c:otherwise>
					  <a href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=${foodSell.foodSellNo }&pageNo=${pageNum}">${pageNum}</a>
			  		</c:otherwise>
			  	</c:choose>
			 </c:forEach>
			<c:if test="${pb.nextPageGroup}">
				<a href="${pageContext.request.contextPath}/getFoodSellDetail.do?foodSellNo=${foodSell.foodSellNo }&pageNo=${pb.startPageOfPageGroup+1}">&raquo;</a>
			</c:if>
	</div>
	</div>
</div><!-- row center-block pagination 후기 페이징 끝_윤주 -->
      
      <hr>
<!--  댓글  -->
      <div class="row">
        <label for="content">Q&A</label>
        <form name="commentInsertForm"> 
            <!-- <div class="input-group"> -->
            <div class="form-group row">
               <input type="hidden" name="foodSellNo" value="${foodSell.foodSellNo}"/>
               <input type="hidden" id="memId" name="memId" value="${mvo.memId}"/>
               <div class="col-xs-10">    
               <input type="text" class="form-control" id="content" name="content" placeholder="내용을 입력하세요.">
               </div>
               <span class="input-group-btn">
                    <Button class="btn btn-reverse" type="button" id="commentInsertBtn" name="commentInsertBtn">등록</Button>
               </span>
              </div>
        </form> 
        
    </div><!-- row -->
    
    <div class="row">
        <div class="commentList">
        	<!-- <table class="table" style="text-align: center;font-size: 12px;">
				<thead>
					<tr class="tr_visible">
						<td>NO</td>
						<td>내용</td>
						<td>작성자</td>
						<td>날짜</td> 
					</tr>
				</thead>
				<tbody id="inner">
				</tbody>
			</table> -->
        </div> <!-- commentList -->
    </div> <!-- row -->
      
   </div><!-- blog-list blog-detail -->
   </div> <!-- col-sm-10 -->
   <div class="col-sm-1"></div><!-- col-sm-1 -->
</div><!-- row -->   
</div> <!-- container -->
</section> <!-- section  -->
