<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
       <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!-- services와 clusterer, drawing 라이브러리 불러오기 : MAP sdk -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98caf95ee9ce0f476e2beb58b89d2a54&libraries=services,clusterer,drawing"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98caf95ee9ce0f476e2beb58b89d2a54"></script>  
 <!-- 우편번호 api -->
 <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
 <!-- datepicker --> 
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="./jquery-ui-1.12.1/datepicker-ko.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <script type="text/javascript">
	$(document).ready(function(){
		
		var checkResultId="";	
		var checkPassword="";
		var checkPasswordRe="";
		var checkPwAnswer="";
		$("#regForm").submit(function(){			
			if(checkPassword==""){
				alert("적정 패스워드가 아닙니다! ");
				return false;
			}
			if(checkPasswordRe==""){
				alert("패스워드 불일치! ");
				return false;
			}
			
			if($("#regForm :input[id=roadAddress]").val().trim()==""){
				alert("주소를 검색하세요");				
				return false;
			}	
			if(checkResultId==""){
				alert("아이디 중복확인을 하세요");
				return false;
			}
			if($("#pwQnaSelect").val()==100){
				alert("질문을 선택하세요!");
				return false;
			}
			if(checkPwAnswer==""){
				alert("비밀번호 찾기 질문의 답변을 입력하세요! ");
				return false;
			}
		});
		
		
		$("#regForm :input[name=memId]").keyup(function(){
			var id=$(this).val().trim();
			if(id.length<4 || id.length>10){
				$("#idCheckView").html(" 4 ~ 10 자리로 입력해주세요.");  
				checkResultId="";
				return;
			}
			// spring security 적용시 ajax post 방식은 아래와 같이 beforeSend property에서 csrf 값을 셋팅해야 함 
			$.ajax({
				type:"post",
				url:"${pageContext.request.contextPath}/checkIdOnAjax.do",				
				data:"id="+id,	
				beforeSend : function(xhr){   /*데이터를 전송하기 전에 헤더에 csrf값을 설정한다*/
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
				success:function(data){				 		
					if(data=="fail"){
						$("#idCheckView").html(" 중복된 아이디 입니다.");
							checkResultId="";
						}else{						
							$("#idCheckView").html(" Welcome!");		
							checkResultId=id; 
						}				
				}//callback			
			});//ajax
		});//keyup
		
		//비밀번호 체크
		$("#regForm :input[id=password]").keyup(function() {
			var id=$(this).val().trim();
			if(id.length<4 || id.length>10){
				$("#passwordCheckView").html(" 4 ~ 10 자리로 입력해주세요.");
				checkPassword="";
			}else{
				$("#passwordCheckView").html(" Ok");
				checkPassword="passwordOK";
			}
			$("#regForm :input[id=passwordRe]").trigger("keyup");
			
		});//keyup
		
		//비밀번호 일치 체크
		$("#regForm :input[id=passwordRe]").keyup(function() {
			if($("#regForm :input[id=password]").val().trim()==""&& !checkPassword==""){
				
				$("#regForm :input[id=passwordRe]").val("");
				$("#regForm :input[id=password]").focus();
				alert("적정 비밀번호를 먼저 입력하세요!");
			}
			else{
				if($("#regForm :input[id=password]").val().trim()!=$("#regForm :input[id=passwordRe]").val().trim()){
					checkPasswordRe="";
					$("#passwordReCheckView").text("비밀번호가 일치하지 않습니다.");
				}
				else if($("#regForm :input[id=password]").val().trim()==$("#regForm :input[id=passwordRe]").val().trim()){
					checkPasswordRe="passwordOK";
					$("#passwordReCheckView").text("Ok");
				}
			}
			
		});//keyup
		
		$("#searchaddress").click(function() {
			  new daum.Postcode({
		            oncomplete: function(data) {
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		            	// 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = ''; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수

		                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    fullAddr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    fullAddr = data.roadAddress;
		                }

						   // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
		                if(data.userSelectedType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		               // document.getElementById('sample4_postcode').value = data.zonecode; //5자리 새우편번호 사용
		              //  document.getElementById('sample4_roadAddress').value = fullRoadAddr;
		               // document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
		                $("#roadAddress").val(fullAddr);
		                $("#roadAddress").trigger("change");

		            }
		        }).open();
			
		});//$("#searchaddress").click
		
		$("#roadAddress").change(function() {
				//alert($(this).val());
				// 주소-좌표 변환 객체를 생성합니다  
				var geocoder = new daum.maps.services.Geocoder();
				// 주소로 좌표를 검색합니다
				geocoder.addressSearch($(this).val(), function(result, status) {
	
				    // 정상적으로 검색이 완료됐으면 
				     if (status === daum.maps.services.Status.OK) {
	
				        var coords = new daum.maps.LatLng(result[0].y, result[0].x);
	
				        // 결과값으로 받은 위치를 마커로 표시합니다
				        var marker = new daum.maps.Marker({
				            map: map,
				            position: coords
				        });
	
				        // 인포윈도우로 장소에 대한 설명을 표시합니다
				        var infowindow = new daum.maps.InfoWindow({
				            content: '<div style="width:100px;text-align:center;padding:6px 0;">검색위치</div>'
				        });
				        infowindow.open(map, marker);
	
				        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				        map.setCenter(coords);
				        
				  //////지도 정보
					    // 지도의 현재 중심좌표를 얻어옵니다 
					    var center = map.getCenter(); 
					    
					    // 지도의 현재 레벨을 얻어옵니다
					    var level = map.getLevel();
					    
					    // 지도타입을 얻어옵니다
					    var mapTypeId = map.getMapTypeId(); 
					    
					    // 지도의 현재 영역을 얻어옵니다 
					    var bounds = map.getBounds();
					    
					    // 영역의 남서쪽 좌표를 얻어옵니다 
					    var swLatLng = bounds.getSouthWest(); 
					    
					    // 영역의 북동쪽 좌표를 얻어옵니다 
					    var neLatLng = bounds.getNorthEast(); 
					    
					    // 영역정보를 문자열로 얻어옵니다. ((남,서), (북,동)) 형식입니다
					    var boundsStr = bounds.toString();
					  
					    $("#latitude").val(center.getLat());
					    $("#longitude").val(center.getLng());
					//alert( center.getLat()+"ddd"+center.getLng());
				    } 
				    
			});   
			
			
		});//$("#jibunAddress").change  
		
		//전화번호 양식에 맞게 입력했는지 확인
		$("#telno").keyup(function() {
			
			var patt = new RegExp("[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}");
			var res = patt.test( $("#telno").val());
			if($("#telno").val()==""){
				 $("#telCheckView").text("");
			}
			else if( !patt.test( $("#telno").val()) ){
			  //  alert("전화번호를 정확히 입력하여 주십시오.");
			    $("#telCheckView").text("포함하여 정확히 입력해주세요~");   	
			   
			}else{
				$("#telCheckView").text("Ok");   	
			}
			
		})//$("#telno").keyup
		
		
		//비밀번호 찾기 항목 값 form 안의 hidden에 설정
		$("#pwQnaSelect").change(function() {
			$("#pwQnaNo").val($("#pwQnaSelect").val());
			//alert($(this).val());
		});//$("#pwQnaSelect").change
		
		//비밀번호 찾기 질문 답변 입력시 
		$("#pwAnswer").keyup(function() {
			if($(this).val()!=""){
				checkPwAnswer="pwAnswerOK";
			}else{
				checkPwAnswer="";
			}
		});//$("#pwAnswerId").keyup
		
		
		//생년월일 지정 할 때 쓰는 datepicker
		$.datepicker.regional['ko'] ={
				showOn: "both",
				/* buttonImage: "${pageContext.request.contextPath}/resources/images/calendar2.png", */ 
				buttonImageOnly: true,
				closeText : '닫기',         
	            prevText : '이전달',         
	            nextText : '다음달',         
	            currentText : '오늘', 
	            changeYear: true,
	            changeMonth: true,
	            monthNames : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],         
	            monthNamesShort : ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],         
	            dayNames : ['일', '월', '화', '수', '목', '금', '토'],         
	            dayNamesShort : ['일', '월', '화', '수', '목', '금', '토'],         
	            dayNamesMin : ['일', '월', '화', '수', '목', '금', '토'],
	            closeText:'취소',
	            dateFormat: "yy-mm-dd",
	            showButtonPanel: true,
	            showMonthAfterYear: true,
	            onClose: function () {
	                if ($(window.event.srcElement).hasClass('ui-datepicker-close')) {
	                    $(this).val('');
	                }
	            }
			};
			
		//datepicker 기본세팅 설정
		$.datepicker.setDefaults($.datepicker.regional['ko']); 
		
		//생년월일 datepicekr 적용 
		$('#birth').datepicker({
			maxDate: 0,
			yearRange: "-100:+0", 
		});
	});//ready
function returnHome(){
		var flag = confirm("회원가입을 취소하시겠습니까?");
		if(flag)
			location.href="${pageContext.request.contextPath}/home.do";
		else
			history.go(0);
}
</script>
    
    
<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
				<div class="row">
				<div class="col-sm-3"><!-- left -->
				
				</div>
					<div class="col-sm-6" >
							<div class="blog-list blog-detail">
		<h3 class="title-form"><i class="icon fa fa-pencil-square-o" style="margin-right: 5px;"></i>회원가입</h3>
		
							<form class="form-large grey-color" action="${pageContext.request.contextPath}/registerMember.do" method="post" id="regForm" >
							<sec:csrfInput/><%-- csrf 토큰 --%>
							<div class="row" >
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div class="col-xs-8" > 
										<label for="id"></i>아이디</label> 
										<input type="text" name="memId" id="id"  class="margin-bottom form-control" placeholder="아이디" required="required" autocomplete="off" style="margin: 0px;">
										<span id="idCheckView" style="margin: 0px; "></span>												
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;">  
														
								</div>
							</div>		
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">
										<label for="password" style="padding-top: 10px; "></i>비밀번호</label>
										<input type="password" name="pw" id="password" class="margin-bottom form-control" placeholder="비밀번호" required="required" autocomplete="off" style="margin: 0px;">
										<span id="passwordCheckView" style="margin: 0;"></span>
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;">
															
								</div>									
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">										
										<label for="password" style="padding-top: 10px; ">비밀번호 확인</label>
										<input type="password"  id="passwordRe" class="margin-bottom form-control" placeholder="비밀번호확인" required="required" autocomplete="off" style="margin: 0px;">
										<span id="passwordReCheckView" style="margin: 0;"></span>
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;">
															
								</div>
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">										
										<label for="password" style="padding-top: 10px; ">이름</label>
										<input type="text"  name="memName" id="name" class="margin-bottom form-control" placeholder="이름" required="required" autocomplete="off" style="margin: 0px;">
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;"> 				

								</div>
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">		 								
									<label for="birthDate" style="padding-top: 10px; ">생년월일</label>
									<input type="text" name="birth" id="birth" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" maxlength="10" class="margin-bottom form-control" required="required" style="margin: 0px;">	
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">										
										<label for="password" style="padding-top: 10px; ">전화번호  (   -   포함하여 입력해주세요! )</label>
										<!-- <input type="text" name="tel"  class="margin-bottom form-control" placeholder="전화번호"> -->
										<input  class="margin-bottom form-control"  type="tel" name="tel" id="telno" title=" -  포함하여 입력해주세요!" placeholder="00*-000*-0000" pattern="[0-9]{2,3}-[0-9]{3,4}-[0-9]{4}" maxlength="13" required="required" autocomplete="off" style="margin: 0px;">
										<span id="telCheckView" style="margin: 0;"></span>	
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;">
										
								</div>
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8">															
										<label for="password" style="padding-top: 10px; ">주소</label>
										<div id="map" style="width:auto;height:200px;"></div> 
										<input class="btn btn-reverse" type="button" id="searchaddress" value="주소 찾기" style="margin-top: 5px;">
										<input type="text" name="addressVO.addressAPI"  id="roadAddress" class="margin-bottom form-control" placeholder="검색 주소"  readonly="readonly" style=" margin: 2px;">	 	 
										<input type="text" name="addressDe"  id="detailAddress" class="margin-bottom form-control" placeholder="상세주소 입력" required="required" autocomplete="off" style="margin: 2px;">							
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
							</div>
							<div class="row"> 
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
								<div  class="col-xs-8" style="margin-top: 10px">										
										<label for="password" style="padding-top: 10px; ">비밀번호 찾기 질문</label>
										<select id="pwQnaSelect">
											<option value="100" selected="selected">질문을 선택하세요</option>
											<c:forEach items="${pwQnaList}" var="p">
														<option value="${p.pwQnaNo}">${p.pwQuest}</option>
											</c:forEach>
										</select>
										<input type="hidden" id="pwQnaNo" name="pwQnaNo"  value="">
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
							</div>
							<div class="row">
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
							 	<div  class="col-xs-8">										
										<label for="password" style="padding-top: 10px; ">비밀번호 찾기 답변</label>
										<input type="text"	 name="pwAnswer"  id="pwAnswer" class="margin-bottom form-control" required="required" autocomplete="off" style="margin: 0px;" >
								</div>
								<div  class="col-xs-2" style="margin-top: 32px;"> 				
								</div>
							</div>
									<br>
									<br>
								<div class="row">
									<div align="center">
									<input  type="submit" class="btn btn-reverse button-form"  value="가입하기">
									<a href="#" onclick="returnHome()" class="btn btn-reverse button-form"  id="returnBtn">돌아가기</a>
									</div>
								</div>
								
								<input type="hidden"  name="addressVO.latitude" id="latitude" value="">
								<input type="hidden"  name="addressVO.longitude" id="longitude" value="">
							</form>		
							</div>
							</div>	
							
							
							<div class="col-sm-3"><!-- right -->

							</div>
							</div>
							</div>
	</section>
	<section>
	</section>
	
    
<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
	        center: new daum.maps.LatLng(33.45757984985129, 126.55277187967573), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };
	
	var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
	var mapTypeControl = new daum.maps.MapTypeControl();
	
	// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
	// daum.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
	map.addControl(mapTypeControl, daum.maps.ControlPosition.TOPRIGHT);
	
	// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
	var zoomControl = new daum.maps.ZoomControl();
	map.addControl(zoomControl, daum.maps.ControlPosition.RIGHT);
	////////////////////////////
	
</script>