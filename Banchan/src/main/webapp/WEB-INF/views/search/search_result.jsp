<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
    
<style type="text/css">
ul.tab {
    margin: 0;
    padding: 0;
    float: left;
    list-style: none;
    height:  32px;
    border-bottom: 1px solid #999;
    border-left: 1px solid #999;
    width: 100%;
}
ul.tab li {
    float: left;
    margin: 0;
    padding: 0;
    height: 31px;
    line-height: 31px;
    border: 1px solid #999;
    border-left: none;
    margin-bottom: -1px;
    overflow: hidden;
    position: relative;
    background:#000;
}
ul.tab li a {
    /* text-decoration: none; */
    color: #e0e0e0;
    display: block;
    font-size: 1.0em;
    padding: 0 20px;
    border: 1px solid #fff;
    outline: none;
}
ul.tab li a:hover {
    background: #ccc;
}
html ul.tab li.active, html ul.tab li.active a:hover  {
    background: #000;
    border-bottom: 1px solid #000;
}
#tabcontainer {
    border: 1px solid #999;
    border-top: none;
    overflow: hidden;
    clear: both;
    float: left; width: 100%;
    background: #fff;
}
.tab_content {
    padding: 20px;
    font-size: 1.2em;
} 
#tab2Container{

    padding: 10px;
    border: 5px solid gray;
    margin: 0; 
}

.pagination {
    display: inline-block;
    text-align: center;
}

.pagination a {
    color: black;
    float: left;
    padding: 8px 16px;
    text-decoration: none;
    transition: background-color .3s;
    font-size: 13px;
}

.pagination a.active {
    background-color: #4CAF50;
    color: white;
}

.pagination a:hover:not(.active) {background-color: #ddd;}
</style>    
    
    
<section id="recent-list" style="margin-top: 100px;">
	<div class="container">
		<div class="row">
				<div class="col-md-9">
				<h4><i class="fa fa-search" aria-hidden="true"></i><b>주부 검색 결과</b></h4>
	<c:choose>
		<c:when test="${fn:length(slist)==0 }">
			&nbsp;&nbsp;&nbsp;<font color="grey">┗ 검색결과없음</font>
			<div style="margin-top: 20px;"></div>
			
		</c:when>
		<c:otherwise>
			<c:choose>
				<c:when test="${fn:length(slist)<=2 && fn:length(slist)>0 }">
					<c:forEach items="${slist }" var="seller">
						<div class="row" style="vertical-align: middle">
							<div class="col-sm-8 col-md-8 col-sm-push-4">
								<div class="bs-callout callout-success" style="width: 800px">
										<h3 class="title" style="width: auto">
								<a href="sellerPageInfo.do?memId=${seller.memId }">
									${seller.memName}</a>&nbsp;
									<span class="star_rating"> 
									<c:forEach begin="1" end="${seller.sellerScore-(seller.sellerScore%1)}">
						    			<a class="on" style="font-size: 16px;">★</a>
									</c:forEach>
									<c:forEach begin="1" end="${5-(seller.sellerScore-(seller.sellerScore%1))}">
						    			<a style="font-size: 16px;">★</a>
						    		</c:forEach> 
						      		</span> &nbsp;
									<a style="font-size: 12px">${seller.sellerScore}</a></h3> 
							 <span class='description' style='color:black;font-size:12px;'>		
								 <table height="81px">  
								<tr> 
									<td><i class='fa fa-user' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 주소&nbsp;</i></td><td><a>${seller.addressVO.addressAPI}</a></td>
								</tr>
								<tr>
									<td><i class='fa fa-calendar' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 소개&nbsp;</i></td><td><a>${seller.sellerInfo}</a></td>
								</tr>		
								<tr>
									<td></td><td></td>
								</tr>			
								</table>
								  </span>
								</div><!-- bs-callout callout-success -->
							</div><!-- /.col-md-8 -->
							<div class="col-sm-4 col-md-4 col-sm-pull-8" style="padding-top: 15px;" >
							<!-- . Agent Box -->
							<div class="tab2img" >
								<a href="sellerPageInfo.do?memId=${seller.memId }"><img alt="Sample images" width="250px" height="150px" src="${pageContext.request.contextPath }/resources/images/${seller.sellerImg}"></a>
							</div>
							</div><!-- /.col-md-4 -->		
						</div><!-- /.row -->
					</c:forEach>
				</c:when>
			<c:otherwise>
				<c:forEach items="${slist }" begin="1" end="2" var="seller">
					<div class="row" style="vertical-align: middle">
						<div class="col-sm-8 col-md-8 col-sm-push-4">
							<div class="bs-callout callout-success" style="width: 800px">
						<h3 class="title" style="width: auto">
								<a href="sellerPageInfo.do?memId=${seller.memId }">
									${seller.memName}</a>&nbsp;
									<span class="star_rating"> 
									<c:forEach begin="1" end="${seller.sellerScore-(seller.sellerScore%1)}">
						    			<a class="on" style="font-size: 16px;">★</a>
									</c:forEach>
									<c:forEach begin="1" end="${5-(seller.sellerScore-(seller.sellerScore%1))}">
						    			<a style="font-size: 16px;">★</a>
						    		</c:forEach> 
						      		</span> &nbsp;
									<a style="font-size: 12px">${seller.sellerScore}</a>
									</h3> 
							 <span class='description' style='color:black;font-size:12px;'>		
								 <table height="81px">  
								<tr> 
									<td><i class='fa fa-user' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 주소&nbsp;</i></td><td><a>${seller.addressVO.addressAPI}</a></td>
								</tr>
								<tr>
									<td><i class='fa fa-calendar' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 소개&nbsp;</i></td><td><a>${seller.sellerInfo}</a></td>
								</tr>		
								<tr>
									<td></td><td></td>
								</tr>			
								</table>
							  </span>
							</div><!-- bs-callout callout-success -->
						</div><!-- /.col-md-8 -->
						<div class="col-sm-4 col-md-4 col-sm-pull-8" style="padding-top: 15px;" >
						<!-- . Agent Box -->
						<div class="tab2img" >
							<a href="sellerPageInfo.do?memId=${seller.memId }"><img alt="Sample images" width="250px" height="150px" src="${pageContext.request.contextPath }/resources/images/${seller.sellerImg}"></a> 
						</div>
						</div><!-- /.col-md-4 -->		
					</div><!-- /.row -->
				</c:forEach>
					<a href="sellerSearchMore.do?kw=${keyword }">검색 결과 더보기..</a>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
</c:choose>
</div>
<hr width="95%" align="left">
<div class="col-md-9">
		<h4><b><i class="fa fa-search" aria-hidden="true"></i>판매음식 검색 결과</b></h4>
		<c:choose>
			<c:when test="${fn:length(flist)==0 }">
				&nbsp;&nbsp;&nbsp;<font color="grey">┗ 검색결과없음</font>
			</c:when>
			<c:otherwise>
				<c:choose>
					<c:when test="${fn:length(flist)<=2 && fn:length(flist)>0}">
					<c:forEach items="${flist }" var="food">
						<div class="row" style="vertical-align: middle">
							<div class="col-sm-8 col-md-8 col-sm-push-4">
								<div class="bs-callout callout-success" style="width: 800px;">
									<h3 class="title">
										<a href="foodDetailView.do?foodNo=${food.foodNo }">
									${food.foodName}</a>
									<span class="star_rating"> 
									<c:forEach begin="1" end="${food.foodScore-(food.foodScore%1)}">
						    			<a class="on" style="font-size: 16px;">★</a>
									</c:forEach>
									<c:forEach begin="1" end="${5-(food.foodScore-(food.foodScore%1))}">
						    			<a style="font-size: 16px;">★</a>
						    		</c:forEach> 
						      		</span> &nbsp;
									<a style="font-size: 12px">${food.foodScore}</a> 	</h3>
							<span class='description' style='color:black;font-size:12px;'>
								<table height="81px">  
										<tr>
											<td><i class='fa fa-user' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 아이디&nbsp;</i></td><td><a href="sellerPageInfo.do?memId=${food.memId }">${food.memId }</a><br></td>
										</tr>
										<tr>
											<td><i class='fa fa-calendar' style="font-weight: bold; margin-right: 5px">&nbsp;음식 상세&nbsp;</i></td><td><a>${food.foodDe}</a></td>
										</tr>								
										</table>
									</span>
								</div><!-- bs-callout callout-success -->
							</div><!-- /.col-md-8 -->
							<div class="col-sm-4 col-md-4 col-sm-pull-8" style="padding-top: 15px;" > 
								<!-- . Agent Box -->
								<div class="tab2img" >
									<a href="foodDetailView.do?foodNo=${food.foodNo }"><img alt="Sample images" width="250px" height="150px" src="${pageContext.request.contextPath }/resources/images/${food.foodMainImg}"></a> 
								</div>
							</div><!-- /.col-md-4 -->
						</div><!-- /.row -->
					</c:forEach>
				</c:when>
				<c:otherwise>
				<c:forEach items="${flist }" begin="1" end="2" var="food">
					<div class="row" style="vertical-align: middle">
						<div class="col-sm-8 col-md-8 col-sm-push-4">
							<div class="bs-callout callout-success" style="width: 800px;">
								<h3 class="title" style="width: auto">
									<a href="foodDetailView.do?foodNo=${food.foodNo }">
									${food.foodName}</a> 	
								<span class="star_rating"> 
									<c:forEach begin="1" end="${food.foodScore-(food.foodScore%1)}">
						    			<a class="on" style="font-size: 16px;">★</a>
									</c:forEach>
									<c:forEach begin="1" end="${5-(food.foodScore-(food.foodScore%1))}">
						    			<a style="font-size: 16px;">★</a>
						    		</c:forEach> 
						      		</span> &nbsp;
									<a style="font-size: 12px">${food.foodScore}</a> </h3>
							<span class='description' style='color:black;font-size:12px;'>
								<table height="81px">  
								<tr>
									<td><i class='fa fa-user' style="font-weight: bold; margin-right: 5px">&nbsp;판매자 아이디&nbsp;</i></td><td><a href="sellerPageInfo.do?memId=${food.memId }">${food.memId }</a><br></td>
								</tr>
								<tr>
									<td><i class='fa fa-calendar' style="font-weight: bold; margin-right: 5px">&nbsp;음식 상세&nbsp;</i></td><td><a>${food.foodDe}</a></td>
								</tr>								
								</table>	
							 </span>				 	
							</div><!-- bs-callout callout-success -->
						</div><!-- /.col-md-8 -->
						<div class="col-sm-4 col-md-4 col-sm-pull-8" style="padding-top: 15px;" >
							<!-- . Agent Box -->
							<div class="tab2img" >
								<a href="foodDetailView.do?foodNo=${food.foodNo }"><img alt="Sample images" width="250px" height="150px" src="${pageContext.request.contextPath }/resources/images/${food.foodMainImg}"></a> 
							</div>
						</div><!-- /.col-md-4 -->
					</div><!-- /.row -->
				</c:forEach>
					<a href="foodSearchMore.do?kw=${keyword }">검색 결과 더보기..</a>
				</c:otherwise>
			</c:choose>
		</c:otherwise>
	</c:choose>
			</div><!-- col-md-9 -->
		</div><!-- row -->
	</div><!-- container -->
</section>
