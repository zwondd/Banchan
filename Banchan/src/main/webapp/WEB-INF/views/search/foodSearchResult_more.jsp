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
    
    
<section id="recent-list" style="margin-top: 150px;">
	<div class="container">
		<div class="row">
			<div class="tab2Container">
				<div class="col-md-9">
				<h4><i class="fa fa-search" aria-hidden="true"></i>판매 음식 검색 결과 전체보기</h4>
		<c:choose>
			<c:when test="${fn:length(flist)==0 }">
				검색결과없음
			</c:when>
			<c:otherwise>
			<c:forEach items="${flist }" var="food">
				<div class="row" style="vertical-align: middle">
					<div class="col-sm-8 col-md-8 col-sm-push-4">
						<div class="bs-callout callout-success" style="width: 800px;">
								<h3 class="title">
										<a href="foodDetailView.do?foodNo=${food.foodNo }">
									${food.foodName}</a><a style="font-size: 12px"><i class="fa fa-star" style="margin-right: 5px; margin-left: 10px"></i>평점:&nbsp;${food.foodScore}</a></h3> 	
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
	</c:otherwise>
</c:choose>
</div>
</div>
</div>
</div>
</section>
