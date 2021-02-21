<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 
<!-- location  시작 --> 
	<!-- services와 clusterer, drawing 라이브러리 불러오기 : MAP sdk -->
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98caf95ee9ce0f476e2beb58b89d2a54&libraries=services,clusterer,drawing">
	</script>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=98caf95ee9ce0f476e2beb58b89d2a54"></script>  
	 <!-- 우편번호 api -->
	 <script src="https://ssl.daumcdn.net/dmaps/map_js_init/postcode.v2.js"></script>
<!-- location 끝 -->
 
	<!-- 광태 추가 --><!-- confirm -->

<script>

$(document).ready(function() {
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
	              	// document.getElementById('sample4_roadAddress').value = fullRoadAddr;
	                // document.getElementById('sample4_jibunAddress').value = data.jibunAddress;
	                $("#roadAddress").val(fullAddr);
	                /* $("#jibunAddress").trigger("change", [ data.jibunAddress.toString(), "bar" ]);
	                // trigger 위와 같이 매개변수 전달시 function에서 (event, a,b ) 식으로 event 넣어줘야함. */
	                $("#addressAPIId").val(fullAddr);
	                $("#roadAddress").trigger("change");
	            }
	        }).open();
	});//$("#searchaddress").click
	
	$("#roadAddress").change(function( event,jibun, b) {
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

			  
			    $("#latitudeId").val(center.getLat());
			    $("#longitudeId").val(center.getLng());
			   // alert("center.getLng(): "+center.getLng())
			    $("#addressAPIDongForm").trigger("submit");
		    }
		});   
		
	});//$("#jibunAddress").change 
	
	$("#addressAPIDongForm").submit(function() {
		
	}); 
	
	$("#pagingDivId").on("click","a",function(){
		//alert($(this).attr('id'));
		$.ajax({
	    		type:"get",
	    		url:"${pageContext.request.contextPath}/getMarkerSellerListOnAjax.do",
	    		data:"addressNo="+$("#addressNoId").val()+"&pageNo="+$(this).attr('id'),  
	    		success:function(data){
	    			//alert(data.list[0].memId);
	    			 //alert(data.list.length);
	    			 var strTemp="";
	    			 //alert(data.pb.previousPageGroup);
	    			 for (var i = 0; i < data.list.length; i++) {
	    				 strTemp +="<tr><td rowspan='2'>"+
	    	 				"<a href='${pageContext.request.contextPath}/sellerPageInfo.do?memId="+data.list[i].memId+"'>"+
	    	 				"<img src='${pageContext.request.contextPath}/resources/images/"+data.list[i].sellerImg+"' style='width: 100px;height:100px; margin: 0px;'>"+
	    	 				"</a>"+
	    	 				"</td>"+
	    	 				"<td> <a href='#'>"+data.list[i].memName+"</a> </td>"+
	    	 				"</tr>"+			
	    	 				"<tr><td>"+"별점 : "
	                        +'<span class="star_rating">'; 
	                        for (var j = 0; j < (data.list[i].sellerScore)-((data.list[i].sellerScore)%1); j++) {
	    	 					strTemp +='<a class="on">★</a>';
							}  
							 for (var k = 0; k < 5-((data.list[i].sellerScore)-((data.list[i].sellerScore)%1)); k++) {
								 strTemp +='<a >★</a>'; 
							}
		                      strTemp+='</span>'+data.list[i].sellerScore+"</td></tr>";
						
					}
	    			 var strTempPaging="";
	    			 strTempPaging+='<div class="pageginationContainer" style="text-align: center;"><div class="pagination">';
	    			 if(data.pb.previousPageGroup){
	    				 strTempPaging+='<a id="'+(data.pb.startPageOfPageGroup-1)+'">이전</a>';
	    			 }
	    			 
	    			 for (var i = data.pb.startPageOfPageGroup; i <(data.pb.endPageOfPageGroup+1); i++) {
	    				if(data.pb.nowPage!=i){
							strTempPaging+='<a id="'+i+'">'+i+'</a>';
						}else{
							strTempPaging+='<a id="'+i+'" class="active">'+i+'</a>';  
						}					
					}  
	    			 if(data.pb.nextPageGroup){
	    				 strTempPaging+='<a id="'+(data.pb.endPageOfPageGroup+1)+'">다음</a></div></div>';
	    			 }
	    			 $("#tbodyList").html(strTemp); 
	    			 $("#pagingDivId").html(strTempPaging);
	    		}//callback	
	    	});	//ajax 
	});
	
});//$(document).ready
</script>



<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
			<div class="row">
				<div class="col-sm-2"><!-- left -->
				
				</div> 
					<div class="col-sm-8">
						<h3 class="title-form"><i class="icon fa fa-map-marker" style="margin-right: 5px; width: inherit;"></i> 위치기반 검색 서비스 </h3>
					<hr>
						<div class="col-sm-6 blog-list blog-detail" style="padding-top: 9px;">		
							<input class="btn btn-reverse" type="button" id="searchaddress" value="주소 찾기">
							<br>
							<input type="text" id="roadAddress" class="margin-bottom form-control" placeholder="검색 주소"  readonly="readonly" value="${addressVO.addressAPI}">
							<br>	
							<div id="map" style="width:100%;height:270px;"></div>
							<span>* 지도를 클릭하시면 거리 계산을 할 수 있어요.!</span><br> 
							<span>* 마우스( 좌클릭: 위치 지정, 우클릭: 소요시간)</span>
						</div><!-- end주소 검색 div  -->
						<div id="sellerTable" class="col-sm-6">
							<h4>판매자 정보</h4> 
							<table class="table table-striped"  >
							<tbody id="tbodyList">	
								<tr>
									<td style="color: red;">지도에서 마커를 클릭하세요! </td>
								</tr>				
							
							</tbody>					
							</table>
							<div class="pagingInfo" id="pagingDivId" style="text-align: center;">
							
							</div>
						</div><!-- end 판매자 리스트  -->						
					</div><!-- <div class="col-sm-8"> -->	
							
							
					<div class="col-sm-2"><!-- right -->
						<form action="${pageContext.request.contextPath}/searchLocationByService.do"
						id="addressAPIDongForm">
							<input type="hidden" id="addressAPIId" name="addressAPI" value="">
							<input type="hidden" id="latitudeId" name="latitude" value="">
							<input type="hidden" id="longitudeId" name="longitude" value="">
						</form>
						<input type="hidden" id="addressNoId" value="">
						
		                     
		                       
					</div>
				</div>
	</div>
	
</section>




<script>
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = { 
			center: new daum.maps.LatLng(${addressVO.latitude}, ${addressVO.longitude}), // 지도의 중심좌표 
	        level: 4 // 지도의 확대 레벨
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
	
	var imageSrc = 'http://icon-park.com/imagefiles/location_map_pin_orange7.png', // 마커이미지의 주소입니다    
    imageSize = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new daum.maps.Point(17, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage = new daum.maps.MarkerImage(imageSrc, imageSize, imageOption),
	    markerPosition = new daum.maps.LatLng(${addressVO.latitude}, ${addressVO.longitude}); // 마커가 표시될 위치입니다
	
	// 마커를 생성합니다
	var marker = new daum.maps.Marker({
	    position: markerPosition, 
	    image: markerImage // 마커이미지 설정 
	});
	
	// 마커가 지도 위에 표시되도록 설정합니다
	marker.setMap(map);
		
	var imageSrc2 = 'https://www.google.co.kr/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&ved=0ahUKEwiLu5Wih-PXAhWCFpQKHcwQC6QQjBwIBA&url=https%3A%2F%2Fcdn.pixabay.com%2Fphoto%2F2016%2F03%2F08%2F13%2F58%2Flocation-1244030_960_720.png&psig=AOvVaw1GUvAcaHRW25zOproAQnyV&ust=1512019902417179',  // 마커이미지의 주소입니다    
    imageSize2 = new daum.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption2 = {offset: new daum.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
	// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
	var markerImage2 = new daum.maps.MarkerImage(imageSrc2, imageSize2, imageOption2);
	 
	
	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [	
			<c:forEach items="${list}" var="s" >
				{
			        title: '${s.addressNo}', 
			        latlng: new daum.maps.LatLng(${s.latitude}, ${s.longitude})
			    },
			</c:forEach>
	];
	
	for (var i = 0; i < positions.length; i ++) {
	    // 마커를 생성합니다
	    var marker = new daum.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng // 마커의 위치 
	     
	    });
	    var iwContent = '<div style="padding:5px;">주부님 보기</div>'; // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다

	    // 마커에 표시할 인포윈도우를 생성합니다 
	    var infowindow = new daum.maps.InfoWindow({
	        content: iwContent // 인포윈도우에 표시할 내용
	    });

	    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
	    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
	    daum.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    daum.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
	    daum.maps.event.addListener(marker, 'click', makeClickListener(positions[i].title));
	}
 
	
	// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
	function makeOverListener(map, marker, infowindow) {
	    return function() {
	        infowindow.open(map, marker);
	    };
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
	    return function() {
	        infowindow.close();
	    };
	}
	
	// 마커 클릭시 이벤트 입니다
	function makeClickListener(addressNo) {
	    return function() {
	    	$("#addressNoId").val(addressNo);
	    	//alert(addressNo);
	    	$.ajax({
	    		type:"get",
	    		url:"${pageContext.request.contextPath}/getMarkerSellerListOnAjax.do",
	    		data:"addressNo="+addressNo,
	    		success:function(data){
	    			//alert(data.list[0].memId);
	    			 //alert(data.list.length);
	    			 var strTemp="";
	    			 //alert(data.pb.previousPageGroup);
	    			 for (var i = 0; i < data.list.length; i++) {
	    				 strTemp +="<tr><td rowspan='2'>"+
	    	 				"<a href='${pageContext.request.contextPath}/sellerPageInfo.do?memId="+data.list[i].memId+"'>"+
	    	 				"<img src='${pageContext.request.contextPath}/resources/images/"+data.list[i].sellerImg+"' style='width: 100px; height:100px; margin: 0px;'>"+
	    	 				"</a>"+
	    	 				"</td>"+
	    	 				"<td> <a href='#'>"+data.list[i].memName+"</a> </td>"+
	    	 				"</tr>"+			
	    	 				"<tr><td>"+"별점 : "+'<span class="star_rating">';

	    	 				for (var j = 0; j < (data.list[i].sellerScore)-((data.list[i].sellerScore)%1); j++) {
	    	 					strTemp +='<a class="on">★</a>';
							}  
							 for (var k = 0; k < 5-((data.list[i].sellerScore)-((data.list[i].sellerScore)%1)); k++) {
								 strTemp +='<a >★</a>'; 
							}
		                      strTemp+='</span>'+data.list[i].sellerScore+"</td></tr>";
						
					}
	    			 var strTempPaging="";
	    			 strTempPaging+='<div class="pageginationContainer" style="text-align: center;"><div class="pagination">';
	    			 if(data.pb.previousPageGroup){
	    				 strTempPaging+='<a id="'+(data.pb.startPageOfPageGroup-1)+'">이전</a>';
	    			 }
	    			 
	    			 for (var i = data.pb.startPageOfPageGroup; i <(data.pb.endPageOfPageGroup+1); i++) {
						if(data.pb.nowPage!=i){
							strTempPaging+='<a id="'+i+'">'+i+'</a>';
						}else{
							strTempPaging+='<a id="'+i+'" class="active">'+i+'</a>';  
						}					
					}  
	    			 if(data.pb.nextPageGroup){
	    				 strTempPaging+='<a id="'+(data.pb.endPageOfPageGroup+1)+'">다음</a></div></div>';
	    			 }
	    			 $("#tbodyList").html(strTemp); 
	    			 $("#pagingDivId").html(strTempPaging);
	    		}//callback	
	    	});	//ajax
	    	
	    };
	};
//////////////////////////////거리 거리 거리 거리 //////////////////////////////////////////	

var drawingFlag = false; // 선이 그려지고 있는 상태를 가지고 있을 변수입니다
var moveLine; // 선이 그려지고 있을때 마우스 움직임에 따라 그려질 선 객체 입니다
var clickLine // 마우스로 클릭한 좌표로 그려질 선 객체입니다
var distanceOverlay; // 선의 거리정보를 표시할 커스텀오버레이 입니다
var dots = {}; // 선이 그려지고 있을때 클릭할 때마다 클릭 지점과 거리를 표시하는 커스텀 오버레이 배열입니다.

// 지도에 클릭 이벤트를 등록합니다
// 지도를 클릭하면 선 그리기가 시작됩니다 그려진 선이 있으면 지우고 다시 그립니다
daum.maps.event.addListener(map, 'click', function(mouseEvent) {

    // 마우스로 클릭한 위치입니다 
    var clickPosition = mouseEvent.latLng;

    // 지도 클릭이벤트가 발생했는데 선을 그리고있는 상태가 아니면
    if (!drawingFlag) {
    	
    	if( !confirm("선 그리기를 하시겠습니까?") ){
    		return false;
    	}
        // 상태를 true로, 선이 그리고있는 상태로 변경합니다
        drawingFlag = true;
        
        // 지도 위에 선이 표시되고 있다면 지도에서 제거합니다
        deleteClickLine();
        
        // 지도 위에 커스텀오버레이가 표시되고 있다면 지도에서 제거합니다
        deleteDistnce();

        // 지도 위에 선을 그리기 위해 클릭한 지점과 해당 지점의 거리정보가 표시되고 있다면 지도에서 제거합니다
        deleteCircleDot();
    
        // 클릭한 위치를 기준으로 선을 생성하고 지도위에 표시합니다
        clickLine = new daum.maps.Polyline({
            map: map, // 선을 표시할 지도입니다 
            path: [clickPosition], // 선을 구성하는 좌표 배열입니다 클릭한 위치를 넣어줍니다
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다
        });
        
        // 선이 그려지고 있을 때 마우스 움직임에 따라 선이 그려질 위치를 표시할 선을 생성합니다
        moveLine = new daum.maps.Polyline({
            strokeWeight: 3, // 선의 두께입니다 
            strokeColor: '#db4040', // 선의 색깔입니다
            strokeOpacity: 0.5, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
            strokeStyle: 'solid' // 선의 스타일입니다    
        });
    
        // 클릭한 지점에 대한 정보를 지도에 표시합니다
        displayCircleDot(clickPosition, 0);

            
    } else { // 선이 그려지고 있는 상태이면

        // 그려지고 있는 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();

        // 좌표 배열에 클릭한 위치를 추가합니다
        path.push(clickPosition);
        
        // 다시 선에 좌표 배열을 설정하여 클릭 위치까지 선을 그리도록 설정합니다
        clickLine.setPath(path);

        var distance = Math.round(clickLine.getLength());
        displayCircleDot(clickPosition, distance);
    }
});
    
// 지도에 마우스무브 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 선의 위치를 동적으로 보여주도록 합니다
daum.maps.event.addListener(map, 'mousemove', function (mouseEvent) {

    // 지도 마우스무브 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag){
        
        // 마우스 커서의 현재 위치를 얻어옵니다 
        var mousePosition = mouseEvent.latLng; 

        // 마우스 클릭으로 그려진 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
        
        // 마우스 클릭으로 그려진 마지막 좌표와 마우스 커서 위치의 좌표로 선을 표시합니다
        var movepath = [path[path.length-1], mousePosition];
        moveLine.setPath(movepath);    
        moveLine.setMap(map);
        
        var distance = Math.round(clickLine.getLength() + moveLine.getLength()), // 선의 총 거리를 계산합니다
            content = '<div class="dotOverlay distanceInfo">총거리 <span class="number">' + distance + '</span>m</div>'; // 커스텀오버레이에 추가될 내용입니다
        
        // 거리정보를 지도에 표시합니다
        showDistance(content, mousePosition);   
    }             
});                 

// 지도에 마우스 오른쪽 클릭 이벤트를 등록합니다
// 선을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면 선 그리기를 종료합니다
daum.maps.event.addListener(map, 'rightclick', function (mouseEvent) {
 
    // 지도 오른쪽 클릭 이벤트가 발생했는데 선을 그리고있는 상태이면
    if (drawingFlag) {
        
        // 마우스무브로 그려진 선은 지도에서 제거합니다
        moveLine.setMap(null);
        moveLine = null;  
        
        // 마우스 클릭으로 그린 선의 좌표 배열을 얻어옵니다
        var path = clickLine.getPath();
    
        // 선을 구성하는 좌표의 개수가 2개 이상이면
        if (path.length > 1) {

            // 마지막 클릭 지점에 대한 거리 정보 커스텀 오버레이를 지웁니다
            if (dots[dots.length-1].distance) {
                dots[dots.length-1].distance.setMap(null);
                dots[dots.length-1].distance = null;    
            }

            var distance = Math.round(clickLine.getLength()), // 선의 총 거리를 계산합니다
                content = getTimeHTML(distance); // 커스텀오버레이에 추가될 내용입니다
                
            // 그려진 선의 거리정보를 지도에 표시합니다
            showDistance(content, path[path.length-1]);  
             
        } else {

            // 선을 구성하는 좌표의 개수가 1개 이하이면 
            // 지도에 표시되고 있는 선과 정보들을 지도에서 제거합니다.
            deleteClickLine();
            deleteCircleDot(); 
            deleteDistnce();

        }
        
        // 상태를 false로, 그리지 않고 있는 상태로 변경합니다
        drawingFlag = false;          
    }  
});    

// 클릭으로 그려진 선을 지도에서 제거하는 함수입니다
function deleteClickLine() {
    if (clickLine) {
        clickLine.setMap(null);    
        clickLine = null;        
    }
}

// 마우스 드래그로 그려지고 있는 선의 총거리 정보를 표시하거
// 마우스 오른쪽 클릭으로 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 생성하고 지도에 표시하는 함수입니다
function showDistance(content, position) {
    
    if (distanceOverlay) { // 커스텀오버레이가 생성된 상태이면
        
        // 커스텀 오버레이의 위치와 표시할 내용을 설정합니다
        distanceOverlay.setPosition(position);
        distanceOverlay.setContent(content);
        
    } else { // 커스텀 오버레이가 생성되지 않은 상태이면
        
        // 커스텀 오버레이를 생성하고 지도에 표시합니다
        distanceOverlay = new daum.maps.CustomOverlay({
            map: map, // 커스텀오버레이를 표시할 지도입니다
            content: content,  // 커스텀오버레이에 표시할 내용입니다
            position: position, // 커스텀오버레이를 표시할 위치입니다.
            xAnchor: 0,
            yAnchor: 0,
            zIndex: 3  
        });      
    }
}

// 그려지고 있는 선의 총거리 정보와 
// 선 그리가 종료됐을 때 선의 정보를 표시하는 커스텀 오버레이를 삭제하는 함수입니다
function deleteDistnce () {
    if (distanceOverlay) {
        distanceOverlay.setMap(null);
        distanceOverlay = null;
    }
}

// 선이 그려지고 있는 상태일 때 지도를 클릭하면 호출하여 
// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 표출하는 함수입니다
function displayCircleDot(position, distance) {

    // 클릭 지점을 표시할 빨간 동그라미 커스텀오버레이를 생성합니다
    var circleOverlay = new daum.maps.CustomOverlay({
        content: '<span class="dot"></span>',
        position: position,
        zIndex: 1
    });

    // 지도에 표시합니다
    circleOverlay.setMap(map);

    if (distance > 0) {
        // 클릭한 지점까지의 그려진 선의 총 거리를 표시할 커스텀 오버레이를 생성합니다
        var distanceOverlay = new daum.maps.CustomOverlay({
            content: '<div class="dotOverlay">거리 <span class="number">' + distance + '</span>m</div>',
            position: position,
            yAnchor: 1,
            zIndex: 2
        });

        // 지도에 표시합니다
        distanceOverlay.setMap(map);
    }

    // 배열에 추가합니다
    dots.push({circle:circleOverlay, distance: distanceOverlay});
}

// 클릭 지점에 대한 정보 (동그라미와 클릭 지점까지의 총거리)를 지도에서 모두 제거하는 함수입니다
function deleteCircleDot() {
    var i;

    for ( i = 0; i < dots.length; i++ ){
        if (dots[i].circle) { 
            dots[i].circle.setMap(null);
        }

        if (dots[i].distance) {
            dots[i].distance.setMap(null);
        }
    }

    dots = [];
}

// 마우스 우클릭 하여 선 그리기가 종료됐을 때 호출하여 
// 그려진 선의 총거리 정보와 거리에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {

    // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
    var walkkTime = distance / 67 | 0;
    var walkHour = '', walkMin = '';

    // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
    if (walkkTime > 60) {
        walkHour = '<span class="number">' + Math.floor(walkkTime / 60) + '</span>시간 '
    }
    walkMin = '<span class="number">' + walkkTime % 60 + '</span>분'

    // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
    var bycicleTime = distance / 227 | 0;
    var bycicleHour = '', bycicleMin = '';

    // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
    if (bycicleTime > 60) {
        bycicleHour = '<span class="number">' + Math.floor(bycicleTime / 60) + '</span>시간 '
    }
    bycicleMin = '<span class="number">' + bycicleTime % 60 + '</span>분'

    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="dotOverlay distanceInfo" style="background-color: black;">';
    content += '    <li style="color: white;">';
    content += '        <span class="label">총거리</span><span class="number"><font color="white">' + distance + ' </font></span>m';
    content += '    </li>';
    content += '    <li style="color: white;">';
    content += '        <span class="label">도보</span><font color="white">' + walkHour + walkMin+' </font>';
    content += '    </li>';
    content += '    <li style="color: white;">';
    content += '        <span class="label">자전거</span><font color="white">' + bycicleHour + bycicleMin+' </font>';
    content += '    </li>';
    content += '</ul>';

    return content;
}

</script>
