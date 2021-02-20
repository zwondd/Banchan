<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="tiles"  uri="http://tiles.apache.org/tags-tiles" %>    
<!DOCTYPE html>
<html lang="en"> 
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=0">
    <title>반찬창고 - 내 주변의 엄마음식</title>

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">                            <!-- Bootstrap -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/font-awesom/css/font-awesome.min.css">  <!-- Font Awesome -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/mmenu/jquery.mmenu.all.css" />          <!-- Menu Responsive -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/animate-wow/animate.css">               <!-- Animation WOW -->	
	
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/nouislider/nouislider.min.css">         <!-- Slider Price -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/easydropdown/easydropdown.css">         <!-- Select form Style -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/skill-bars/skill-bars.css">             <!-- Skill Bars -->
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/ui-spinner.css">                               <!-- Spinner -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/vendor/labelauty/labelauty.css">               <!-- Checkbox form Style -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/menu.css">                                     <!-- Include Menu stylesheet -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/custom.css">                                   <!-- Custom Stylesheet -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/media-query.css">                              <!-- Media Query -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/banchan.css"> 				 <!-- 프로젝트 부트스트랩 -->
    <link rel=”stylesheet” href=”http://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css“>  					 <!-- 아이콘 부트스트랩 -->
	<!-- Use Iconifyer to generate all the favicons and touch icons you need: http://iconifier.net -->
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/resources/images/favicon/icon.png" type="image/x-icon" /><!-- 아이콘 --> 
	<!-- 글꼴 -->
	<link href='http://fonts.googleapis.com/earlyaccess/nanumgothic.css' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/earlyaccess/hanna.css' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/earlyaccess/notosanskr.css' rel='stylesheet' type='text/css' />
	<link href='http://fonts.googleapis.com/earlyaccess/jejugothic.css' rel='stylesheet' type='text/css' />
	
	<script src="${pageContext.request.contextPath}/resources/script/modernizr.min.js"></script>	

		
	
<title><tiles:insertAttribute name="title" ignore="true" /></title>
<script src="//code.jquery.com/jquery.min.js"></script>
	


  </head>
  
  <!-- Tiles 적용 부분 -->
  <body class="fixed-header">
<div id="container">
	 <div class="row">
			<div id="header">
				<tiles:insertAttribute name="header" />
			</div><!-- 헤더 -->
	</div>
	<div class="row">
		<div class="col-sm-1">
		</div>
		<div class="col-sm-10">
			<div id="main">
				<tiles:insertAttribute name="main" />
			</div><!-- 메인 -->	
		</div>
		<div class="col-sm-1"	>
			<div id="right">
				<tiles:insertAttribute name="right"/>
			</div><!-- 오른쪽  -->
		</div>
 	</div>
	<div class="row"> 
			<div id="footer">
				<tiles:insertAttribute name="footer" />
			</div><!-- 푸터 -->
	 </div>
</div>


	<script	src="${pageContext.request.contextPath}/resources/script/jquery.min.js"></script>									<!-- jQuery	(necessary for Bootstrap's JavaScript plugins) -->
	<script	src="${pageContext.request.contextPath}/resources/script/jquery-ui.min.js"></script>								<!-- jQuery	UI is a	curated	set	of user	interface interactions,	effects, widgets, and themes -->
	<script	src="${pageContext.request.contextPath}/resources/script/bootstrap.min.js"></script>								<!-- Include all compiled plugins (below), or include individual files as needed -->

	<script	src="${pageContext.request.contextPath}/resources/script/vendor/mmenu/mmenu.min.all.js"></script>					<!-- Menu Responsive -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/animation-wow/wow.min.js"></script>					<!-- Animate Script	-->
	<script src="${pageContext.request.contextPath}/resources/script/vendor/labelauty/labelauty.min.js"></script>				<!-- Checkbox Script -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/parallax/parallax.min.js"></script>					<!-- Parallax Script -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/images-fill/imagesloaded.min.js"></script>			<!-- Loaded	image with ImageFill -->
	<script src="${pageContext.request.contextPath}/resources/script/vendor/images-fill/imagefill.min.js"></script>				<!-- ImageFill Script -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/easydropdown/jquery.easydropdown.min.js"></script>	<!-- Select	list Script	-->
	
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/carousel/responsiveCarousel.min.js"></script>		<!-- Carousel Script -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/noui-slider/nouislider.all.min.js"></script>		<!-- Range Slider -->
	<script	src="${pageContext.request.contextPath}/resources/script/vendor/skill-bars/custom.js"></script>						<!-- Skill Bars	Script -->

	<script	src="${pageContext.request.contextPath}/resources/script/custom.js"></script>		<!-- Custom	Script -->

<!-- ************************************************************ -->
	<script>

		"use strict";

		$(function() {
			$("#accordion").accordion({
				heightStyle: "content"
			});
			$("#toggle h3").click(function() {
				$(this).hasClass('toggle-attive') ? 
				$(this).next().removeClass('toggle-attive') : 
				$(this).next().slideToggle({
					duration: 400,
					easing: 'linear'
				});
			});
		});

	</script>

  </body>
</html>