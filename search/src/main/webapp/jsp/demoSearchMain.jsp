<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="UTF-8">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1, user-scalable=yes">
	<link rel="shortcut icon" href="./images/favicon.png">
	<link rel="icon" href="./images/favicon.png" sizes="30x30" type="image/x-icon">
	 
	<script src="../js/jquery-3.6.0.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../js/slick.min.js"></script>
 
	<!-- 서울대 도서관 js 추가 -->
	<script src="../js/template-functions.js"></script>
	<script src="../js/common.js"></script>
	
	<!-- 검색어 자동완성 기능 s -->
	<script type="text/javascript" src="../js/jquery-easyui-1.10.17/jquery-ui.js"></script>
	<link rel="stylesheet" href="../css/jquery-ui.css">
	<!-- 검색어 자동완성 기능 e -->
	
	<title>LikeSNU 통합검색</title>
<style type="text/css">
	/* 검색어 자동완성 css */
	.ui-autocomplete {
	  max-height: 200px;
	  overflow-y: auto;
	  /* prevent horizontal scrollbar */
	  overflow-x: hidden;
	  height: auto;
	}
	.ui-menu-item div.ui-state-hover,
	.ui-menu-item div.ui-state-active {
	  color: #ffffff;
	  text-decoration: none;
	  background-color: #183989;
	  border-radius: 0px;
	  -webkit-border-radius: 0px;
	  -moz-border-radius: 0px;
	  background-image: none;
	  border:none;
	}
</style>
</head>
<form name="searchForm" id="searchForm" action="/searchEngine" method="post">
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${searchMap.searchKeyword}" />
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${paginationInfo.recordCountPerPage}">
	<input type="hidden" id="currentPageNum" name="currentPageNum" value="${currentPageNum}">
</form>
<script type="text/javascript">
$(document).ready(function(){
	// 통합검색 엔터
	$("#searchEngineKeyword").keydown(function (key) {
        if (key.keyCode == 13) {
//         	cfn_searchEngine();
        	cfn_searchEngine_ex();
        }
    });	
	
	// 자동완성
	$('#searchEngineKeyword1').autocomplete({
		source: function (request, response) {
			$.ajax({
				url: "/searchSuggester.do",
				type: "GET",
				dataType: "JSON",
				data: { searchKeyword : request.term }, 
				success: function (data) {
					$('#backupKeyword').val($('#searchEngineKeyword').val()); // 검증용으로 저장
					response(data);
					console.log("타나");
				}
				,error : function(){
					// 아무것도 없으면 패스
					console.log('아무것도 없어');
				}
			});
		},
		focus: function (event, ui) {
			//방향키로 자동완성단어 선택 가능하게 만들어줌
			event.preventDefault();
			$(this).autocomplete("search", $(this).val());
			return false;
		},
		select: function (event, ui) {
			cfn_searchEngine(ui.item.value);
		},
		focus: function (event, ui) {
			return false;
		},
		delay: 100,	//autocomplete 딜레간(ms)
		minLength : 1, //최소 글자 수
//			autoFocus: true, // true == 첫 번째 항목에 자동으로 초점이 맞춰짐
		close : function(event){
		}
	});	
});

// html 보여주기 용
function cfn_searchEngine_ex() {
	$('#emptyList').css('display','none');
	$('.viewList').css('display','block');
}

// 통합검색
function cfn_searchEngine(keyword) {
	var searchEngineBackKeyword = $('#searchEngineBackKeyword').val();
	var strKeword = $("#searchEngineKeyword").val();
	if (keyword != null && keyword != '') {
		strKeword = keyword;
	}
	
	if(strKeword != '') {
		var strGoUrl = "/searchEngine.do";
			
		var form = document.createElement("form");
		form.setAttribute("method", "post");  
		form.setAttribute("action", strGoUrl); 				//요청 보낼 주소
		
		var hiddenField = document.createElement("input");
	    hiddenField.setAttribute("type", "hidden");
	    hiddenField.setAttribute("name", "searchKeyword");
	    hiddenField.setAttribute("value", strKeword);

		// 여기서 직전 키워드 저장! 02-15
		if ($("#searchEngineKeyword").val() != searchEngineBackKeyword || strKeword != searchEngineBackKeyword) {
			var hiddenBackField = document.createElement("input");
	    	hiddenBackField.setAttribute("type", "hidden");
	   		hiddenBackField.setAttribute("name", "backSearchKeyword");
	    	hiddenBackField.setAttribute("value", searchEngineBackKeyword);
		}

	    form.appendChild(hiddenField);
		form.appendChild(hiddenBackField);
		document.body.appendChild(form);
	    form.submit();
		document.body.removeChild(form);	
	} else {
		alert("검색어를 입력해주세요.");
	}
}
</script>

<body>
	<div id="skip">
		<strong class="blind">반복영역 건너뛰기</strong>
		<a href="#gnb">주메뉴 바로가기</a> 
		<a href="#scontents">본문 바로가기</a>
	</div>

	<header class="site-header">
		<div class="container">
			<h1 class="site-logo">
				<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="레이어_1" x="0px" y="0px" viewBox="0 0 283.5 46" style="enable-background:new 0 0 283.5 46;" xml:space="preserve" class="img-to-svg logo-image" src="https://lib.snu.ac.kr/wp-content/themes/snulib/assets/images/site-logo-gradient.svg" alt="서울대학교 중앙도서관">
			<style type="text/css">
			.st0{clip-path:url(#SVGID_00000056409680530663373610000007663023758992609664_);}
			.st1{fill:#183889;}
			.st2{fill:url(#SVGID_00000036934228365575521210000006171272347427093386_);}
		</style>
		<g>
			<defs>
				<rect id="SVGID_1_" width="283.5" height="46"></rect>
			</defs>
			<clipPath id="SVGID_00000142880525647888606890000015267619419192674449_">
				<use xlink:href="#SVGID_1_" style="overflow:visible;"></use>
			</clipPath>
			<g style="clip-path:url(#SVGID_00000142880525647888606890000015267619419192674449_);">
				<path class="st1" d="M65.4,42.5c-0.9,0-1.7-0.2-2.6-0.4v-1.6c0.8,0.5,1.6,0.9,2.6,0.9c0.8,0,1.6-0.3,1.6-1.2c0-1.9-4.4-2-4.4-4.6	c0-1.7,1.7-2.3,3.2-2.3c0.8,0,1.5,0.1,2.3,0.2v1.4c-0.8-0.3-1.5-0.6-2.3-0.6c-0.7,0-1.4,0.3-1.4,1.1c0,1.6,4.5,1.8,4.5,4.5	C68.8,41.8,67.1,42.5,65.4,42.5L65.4,42.5z"></path>
				<path class="st1" d="M70.2,42.3v-8.9h5.5v1.1h-3.9v2.6h3.7v1.1h-3.7v2.9h4v1.1L70.2,42.3L70.2,42.3z"></path>
				<path class="st1" d="M80.6,42.5c-3,0-3.8-2.1-3.8-4.6c0-2.5,0.8-4.6,3.8-4.6s3.8,2.1,3.8,4.6C84.4,40.4,83.6,42.5,80.6,42.5z	 M80.6,34.4c-1.9,0-2,2.2-2,3.5c0,1.3,0.2,3.5,2,3.5c1.9,0,2-2.2,2-3.5C82.6,36.6,82.4,34.4,80.6,34.4z"></path>
				<path class="st1" d="M89.1,42.5c-1.9,0-3.3-0.9-3.3-2.9v-6.2h1.6v6.2c0,1.1,0.5,1.8,1.7,1.8c1.2,0,1.6-0.7,1.6-1.8v-6.2h1.6v6.2	C92.3,41.6,91.1,42.5,89.1,42.5z"></path>
				<path class="st1" d="M94.2,42.3v-8.9h1.6v7.7h3.7v1.1H94.2z"></path>
				<path class="st1" d="M108.7,42.3l-3.8-6.9h0v6.9h-1.4v-8.9h1.9l3.6,6.5h0v-6.5h1.4v8.9H108.7L108.7,42.3z"></path>
				<path class="st1" d="M118.1,42.3l-0.8-2.4h-3.4l-0.8,2.4h-1.6l3.2-8.9h1.9l3.2,8.9H118.1z M115.6,34.9L115.6,34.9l-1.3,3.9h2.6	L115.6,34.9L115.6,34.9z"></path>
				<path class="st1" d="M123.4,34.6v7.7h-1.6v-7.7h-2.3v-1.1h6.3v1.1H123.4L123.4,34.6z"></path>
				<path class="st1" d="M126.6,42.3v-8.9h1.6v8.9H126.6z"></path>
				<path class="st1" d="M133.6,42.5c-3,0-3.8-2.1-3.8-4.6c0-2.5,0.8-4.6,3.8-4.6c3,0,3.8,2.1,3.8,4.6	C137.4,40.4,136.6,42.5,133.6,42.5z M133.6,34.4c-1.9,0-2,2.2-2,3.5c0,1.3,0.2,3.5,2,3.5c1.9,0,2-2.2,2-3.5	C135.6,36.6,135.4,34.4,133.6,34.4z"></path>
				<path class="st1" d="M144.2,42.3l-3.8-6.9h0v6.9H139v-8.9h1.9l3.6,6.5h0v-6.5h1.4v8.9H144.2z"></path>
				<path class="st1" d="M153.6,42.3l-0.8-2.4h-3.4l-0.8,2.4H147l3.2-8.9h1.9l3.2,8.9H153.6L153.6,42.3z M151.1,34.9L151.1,34.9	l-1.3,3.9h2.6L151.1,34.9L151.1,34.9z"></path>
				<path class="st1" d="M156.2,42.3v-8.9h1.6v7.7h3.7v1.1H156.2z"></path>
				<path class="st1" d="M168.6,42.5c-1.9,0-3.2-0.9-3.2-2.9v-6.2h1.6v6.2c0,1.1,0.5,1.8,1.7,1.8c1.2,0,1.6-0.7,1.6-1.8v-6.2h1.6v6.2	C171.8,41.6,170.5,42.5,168.6,42.5L168.6,42.5z"></path>
				<path class="st1" d="M178.9,42.3l-3.8-6.9h0v6.9h-1.4v-8.9h1.9l3.6,6.5h0v-6.5h1.4v8.9H178.9z"></path>
				<path class="st1" d="M182.7,42.3v-8.9h1.6v8.9H182.7z"></path>
				<path class="st1" d="M190,42.3h-1.9l-3.1-8.9h1.6l2.4,7.1h0l2.5-7.1h1.6L190,42.3z"></path>
				<path class="st1" d="M194,42.3v-8.9h5.5v1.1h-3.9v2.6h3.7v1.1h-3.7v2.9h4v1.1L194,42.3L194,42.3z"></path>
				<path class="st1" d="M205.6,42.3l-0.4-1.9c-0.3-1.3-0.4-1.9-2-1.9h-0.6v3.8h-1.6v-8.9h2.8c1.7,0,3,0.5,3,2.3	c0,1.2-0.7,1.8-1.9,2.1v0c1.2,0.3,1.4,0.9,1.7,2l0.6,2.5L205.6,42.3L205.6,42.3z M203.8,34.5h-1.2v2.9h0.6c1.1,0,2-0.3,2-1.5	C205.2,35.1,204.7,34.5,203.8,34.5L203.8,34.5z"></path>
				<path class="st1" d="M210.7,42.5c-0.9,0-1.7-0.2-2.6-0.4v-1.6c0.8,0.5,1.6,0.9,2.6,0.9c0.8,0,1.6-0.3,1.6-1.2c0-1.9-4.4-2-4.4-4.6	c0-1.7,1.7-2.3,3.2-2.3c0.8,0,1.5,0.1,2.3,0.2v1.4c-0.8-0.3-1.5-0.6-2.3-0.6c-0.7,0-1.4,0.3-1.4,1.1c0,1.6,4.5,1.8,4.5,4.5	C214.2,41.8,212.4,42.5,210.7,42.5L210.7,42.5z"></path>
				<path class="st1" d="M215.5,42.3v-8.9h1.6v8.9H215.5z"></path>
				<path class="st1" d="M221.9,34.6v7.7h-1.6v-7.7H218v-1.1h6.3v1.1H221.9L221.9,34.6z"></path>
				<path class="st1" d="M228.7,38.2v4.1h-1.6v-4.1l-3.1-4.8h1.8l2.1,3.2l2.1-3.2h1.8L228.7,38.2L228.7,38.2z"></path>
				<path class="st1" d="M235.5,42.3v-8.9h1.6v7.7h3.7v1.1H235.5z"></path>
				<path class="st1" d="M241.7,42.3v-8.9h1.6v8.9H241.7z"></path>
				<path class="st1" d="M248.1,42.3h-2.9v-8.9h2.9c1.4,0,2.6,0.5,2.6,2.1c0,1.1-0.5,1.7-1.6,2v0c1.3,0.2,2,1,2,2.3	C251.2,41.8,249.9,42.4,248.1,42.3L248.1,42.3z M247.4,34.5h-0.6v2.6h0.6c1,0,1.7-0.2,1.7-1.3C249.1,34.7,248.4,34.5,247.4,34.5	L247.4,34.5z M247.4,38.2h-0.6v3.1h0.6c1.1,0,2.1-0.2,2.1-1.5S248.6,38.2,247.4,38.2z"></path>
				<path class="st1" d="M257.3,42.3l-0.4-1.9c-0.3-1.3-0.4-1.9-2-1.9h-0.6v3.8h-1.6v-8.9h2.8c1.7,0,3,0.5,3,2.3	c0,1.2-0.7,1.8-1.9,2.1v0c1.2,0.3,1.4,0.9,1.7,2l0.6,2.5L257.3,42.3L257.3,42.3z M255.5,34.5h-1.2v2.9h0.6c1.1,0,2-0.3,2-1.5	C256.9,35.1,256.5,34.5,255.5,34.5L255.5,34.5z"></path>
				<path class="st1" d="M265.9,42.3l-0.8-2.4h-3.4l-0.8,2.4h-1.6l3.2-8.9h1.9l3.2,8.9H265.9z M263.4,34.9L263.4,34.9l-1.3,3.9h2.6	L263.4,34.9z"></path>
				<path class="st1" d="M273.1,42.3l-0.4-1.9c-0.3-1.3-0.4-1.9-2-1.9h-0.6v3.8h-1.6v-8.9h2.8c1.7,0,3,0.5,3,2.3	c0,1.2-0.7,1.8-1.9,2.1v0c1.2,0.3,1.4,0.9,1.7,2l0.6,2.5L273.1,42.3L273.1,42.3z M271.3,34.5h-1.2v2.9h0.6c1.1,0,2-0.3,2-1.5	C272.7,35.1,272.3,34.5,271.3,34.5L271.3,34.5z"></path>
				<path class="st1" d="M279.5,38.2v4.1h-1.6v-4.1l-3.1-4.8h1.8l2.1,3.2l2.1-3.2h1.8L279.5,38.2L279.5,38.2z"></path>
				<path class="st1" d="M131.9,21.8h11v5.4h2.6v-7.7h-13.6V21.8L131.9,21.8z M139.6,12.4c0-1-0.3-2-0.9-2.8h2V7.2h-5.1v-2H133v2h-5.1	v2.4h2c-0.5,0.8-0.9,1.8-0.9,2.8c0,2.8,2.4,5.1,5.3,5.1C137.2,17.5,139.6,15.2,139.6,12.4z M131.6,12.4c0-1.5,1.2-2.8,2.7-2.8	s2.7,1.2,2.7,2.8s-1.2,2.8-2.7,2.8S131.6,13.9,131.6,12.4z M122,12.8h-2V5.2h-2.6v21.9h2.6v-12h2v12h2.6V5.2H122V12.8z	 M109.7,19.1v-10h5.2V6.7h-7.9v14.8h5.1c0,0,3-0.1,4.2-0.5v-2.4c-1.2,0.5-4.2,0.5-4.2,0.5L109.7,19.1L109.7,19.1z M69.6,9.8V6.3	h-2.7v3.5c0,2.1-0.5,6.9-5.6,10.5l1.7,1.9c2.7-1.8,4.3-4,5.3-6.2c1,2.2,2.6,4.4,5.3,6.2l1.7-1.9C70.2,16.7,69.6,11.9,69.6,9.8z	 M272.7,9.6c0,0-0.1,3-0.8,5.2h2.6c0.7-2.2,0.8-5.2,0.8-5.2V6.2h-10.9v2.4h8.3L272.7,9.6L272.7,9.6z M94,14.5c3,0,5.4-2.2,5.4-4.9	c0-2.7-2.4-4.9-5.4-4.9c-3,0-5.4,2.2-5.4,4.9C88.6,12.3,91,14.5,94,14.5z M94,7c1.5,0,2.7,1.2,2.7,2.6c0,1.4-1.2,2.6-2.7,2.6	c-1.5,0-2.7-1.2-2.7-2.6C91.2,8.1,92.5,7,94,7z M83.8,17.2h8.8v1.2H87v2.1h11.4v1.1H87v5.4h14.5V25H89.6v-1.1H101v-5.4h-5.7v-1.2	h8.8V15H83.8V17.2z M77.6,11h-4.4v2.4h4.4v13.8h2.6V5.2h-2.6V11z M164.6,10.7c0,0-0.1,4.9-0.8,8.4h2.6c0.7-3.5,0.8-8.4,0.8-8.4	V6.5h-14.8v2.4h12.2L164.6,10.7L164.6,10.7z M230.3,17.1h5.5v-2.4h-11V8.9h11V6.5h-13.6v10.6h5.6v4.5h-8.9V24H239v-2.4h-8.7V17.1z	 M269.3,20.3h-2.6v6.8h14.2v-2.4h-11.6V20.3z M248.5,9.8V6.3h-2.7v3.5c0,2.1-0.5,6.9-5.6,10.5l1.7,1.9c2.7-1.8,4.3-4,5.3-6.2	c1,2.2,2.6,4.4,5.3,6.2l1.7-1.9C249,16.7,248.5,11.9,248.5,9.8z M256.5,11h-4.4v2.4h4.4v13.8h2.6V5.2h-2.6V11z M276.9,18.3v-2.4	c-1.2,0.5-4.2,0.5-4.2,0.5h-3.3v-4.9h-2.6v4.9H263v2.4h9.6C272.7,18.8,275.7,18.8,276.9,18.3z M162.1,13.9h-2.6v7.7H157v-7.7h-2.6	v7.7h-4.8V24h20.2v-2.4h-7.7V13.9z M280.6,10.6V5.2H278v16.4h2.6V13h2.9v-2.4H280.6z M145.5,5.2h-2.6v12.9h2.6V13h2.9v-2.4h-2.9	V5.2z M214.7,5.2H212v12.9h2.6V13h2.7v-2.4h-2.7V5.2z M209.2,11.1c0-2.9-2.6-5.3-5.8-5.3c-3.2,0-5.8,2.4-5.8,5.3	c0,2.9,2.6,5.3,5.8,5.3C206.6,16.4,209.2,14,209.2,11.1z M200.3,11.1c0-1.6,1.4-2.9,3.1-2.9c1.7,0,3.1,1.3,3.1,2.9	c0,1.6-1.4,2.9-3.1,2.9C201.7,14.1,200.3,12.7,200.3,11.1z M176.8,11.7l0.9,2c3.5-0.6,6.1-2,7.5-3.5c1.4,1.5,4,3,7.5,3.5l0.9-2	c-3.6-0.9-5.4-2-6.3-3c-0.3-0.3-0.5-0.6-0.6-0.9h5.5V5.4h-14.1v2.3h5.5c-0.1,0.3-0.3,0.6-0.6,0.9C182.3,9.7,180.5,10.8,176.8,11.7	L176.8,11.7z M208.6,18.3c-3.1,0-5.7,2.3-5.7,5.1c0,2.8,2.5,5.1,5.7,5.1c3.1,0,5.7-2.3,5.7-5.1C214.2,20.6,211.7,18.3,208.6,18.3	L208.6,18.3z M208.6,26.1c-1.7,0-3-1.2-3-2.7c0-1.5,1.4-2.7,3-2.7c1.7,0,3,1.2,3,2.7C211.6,24.9,210.2,26.1,208.6,26.1z	 M175.2,16.7h8.8v1.7c-2.6,0.5-4.5,2.5-4.5,4.9c0,2.8,2.6,5.1,5.8,5.1c3.2,0,5.8-2.3,5.8-5.1c0-2.4-1.9-4.4-4.5-4.9v-1.7h8.8v-2.2	h-20.2L175.2,16.7L175.2,16.7z M188.5,23.4c0,1.5-1.4,2.7-3.2,2.7s-3.2-1.2-3.2-2.7c0-1.5,1.4-2.7,3.2-2.7	C187.1,20.7,188.5,21.9,188.5,23.4z"></path>
				<path class="st1" d="M18,11.7v16.5c0,5.8,3.6,8.5,8.1,8.5c4.5,0,8.1-2.7,8.1-8.5V11.7H18L18,11.7z M32,20.1h-2.4v1.1H32V24h-2.4	v8.2h-2.1l-2.9-2.9l-2.6,2.7L20,30l4.4-4.4l2.3,2.3V16.5h-4.8v-2.4h7.6v3.5H32L32,20.1L32,20.1z"></path>
				
					<linearGradient id="SVGID_00000075154333156631552220000010354881734622271382_" gradientUnits="userSpaceOnUse" x1="324.085" y1="-341.2685" x2="324.085" y2="-389.0744" gradientTransform="matrix(1 0 0 -1 -298 -342)">
					<stop offset="0" style="stop-color:#35B6C3"></stop>
					<stop offset="0.34" style="stop-color:#009CBA"></stop>
					<stop offset="0.71" style="stop-color:#183889"></stop>
					<stop offset="1" style="stop-color:#183889"></stop>
				</linearGradient>
				<path style="fill:url(#SVGID_00000075154333156631552220000010354881734622271382_);" d="M45.8,5.2V0h-4.4c-1.6,0-5.5,0-9.2,1.4	c-2.4,0.9-4.7,2.4-6.2,4.5c-1.4-2.1-3.8-3.6-6.2-4.5C16.2,0,12.4,0,10.7,0H6.3v5.2H0v37.1h9.7c3,0,9.4,0.2,14,3.7l0.1-0.1	c-0.9-2.1-3.8-6.1-15.2-6.1H3.2V7.8h3.1v29.4h1.9c5.4,0.1,12.7,0.8,16.9,7.6l0.1-0.1c-0.2-3.2-3.6-10-15.6-10V7.8h0.2	c8.9,0,11.7,0.9,14.3,2.4l0.1-0.1c-2.6-3.7-8.8-4.8-14.5-4.9V2.6h1.6c2,0,5,0.2,7.9,1.1c1.6,0.5,4.9,1.9,6.9,4.8	c2-2.9,5.4-4.4,6.9-4.8c2.9-0.9,5.9-1.1,7.9-1.1h1.6v2.6C36.8,5.3,30.6,6.4,28,10.1l0.1,0.1c2.6-1.5,5.3-2.4,14.3-2.4h0.2v26.8	c-12,0-15.4,6.9-15.6,10l0.1,0.1c4.3-6.7,11.6-7.5,16.9-7.6h1.9V7.8H49v31.9h-5.5c-11.4,0-14.3,4.1-15.2,6.1l0.1,0.1	c4.7-3.5,11-3.7,14-3.7h9.7V5.2H45.8z"></path>
			</g>
		</g>
		</svg>
			</h1><!-- .site-logo -->
			<a href="/main" class="like-snu-logo"><img src="../images/like_snu_logo_c.png" alt="like snu"></a>
			<button class="btn btn-icon no-spacing site-nav-button d-lg-none" id="site-nav-button" aria-controls="site-navigation" aria-expanded="false">
				<span class="site-nav-open"><svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="currentColor" d="m3.6,6c0-.32.13-.62.35-.85.23-.23.53-.35.85-.35h14.4c.32,0,.62.13.85.35.23.23.35.53.35.85s-.13.62-.35.85c-.23.23-.53.35-.85.35H4.8c-.32,0-.62-.13-.85-.35-.23-.23-.35-.53-.35-.85Zm0,6c0-.32.13-.62.35-.85.23-.22.53-.35.85-.35h7.2c.32,0,.62.13.85.35.22.23.35.53.35.85s-.13.62-.35.85c-.23.22-.53.35-.85.35h-7.2c-.32,0-.62-.13-.85-.35-.23-.23-.35-.53-.35-.85Zm0,6c0-.32.13-.62.35-.85.23-.23.53-.35.85-.35h14.4c.32,0,.62.13.85.35.23.22.35.53.35.85s-.13.62-.35.85-.53.35-.85.35H4.8c-.32,0-.62-.13-.85-.35-.23-.23-.35-.53-.35-.85Z"></path></svg><span class="sr-only">메뉴 열기</span></span>
				<span class="site-nav-close"><svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="currentColor" d="m13.83,12l7.79-7.79c.51-.51.51-1.33,0-1.83-.51-.51-1.33-.51-1.83,0l-7.79,7.79L4.21,2.38c-.51-.51-1.33-.51-1.83,0-.51.51-.51,1.33,0,1.83l7.79,7.79-7.79,7.79c-.51.51-.51,1.33,0,1.83.25.25.58.38.92.38s.66-.13.92-.38l7.79-7.79,7.79,7.79c.25.25.58.38.92.38s.66-.13.92-.38c.51-.51.51-1.33,0-1.83l-7.79-7.79Z"></path></svg><span class="sr-only">메뉴 닫기</span></span>
			</button>
		</div><!-- .container -->
		
		<nav class="site-navigation" id="site-navigation" >
	
			<div class="container p-0">
			
				<nav class="primary-menu" aria-label="주요 메뉴">
					<div id="gnb" class="primary-menu-container">
					<ul id="primary-menu-list" class="menu-wrapper">
						<li id="menu-item-44583" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-44583"><a target="_blank" rel="noopener" href="https://likesnu.snu.ac.kr/main">LikeSNU</a></li>
						<li id="menu-item-266" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-266"><a href="https://lib.snu.ac.kr/find/">자료검색</a><div class="sub-menu-container" style="height: 0px;">
						<div class="menu-desc"><h3>자료검색</h3><p>소장자료 및 전자자료의 검색을 제공합니다.</p></div><ul class="sub-menu">	<li id="menu-item-44588" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-44588"><a href="https://lib.snu.ac.kr/find/search-all/">통합검색</a></li>
						<li id="menu-item-975" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-975"><a target="_blank" rel="noopener" href="https://snu-primo.hosted.exlibrisgroup.com/primo-explore/search?&amp;tab=thesis&amp;search_scope=THESIS&amp;vid=82SNU&amp;lang=ko_KR&amp;mode=advanced&amp;offset=0">학위논문</a></li>
						<li id="menu-item-271" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-271"><a href="https://lib.snu.ac.kr/find/databases/">학술DB</a></li>
						<li id="menu-item-976" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-976"><a target="_blank" rel="noopener" href="https://snu-primo.hosted.exlibrisgroup.com/primo-explore/jsearch?vid=82SNU&amp;lang=ko_KR">온라인저널</a></li>
						<li id="menu-item-273" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-273"><a href="https://lib.snu.ac.kr/find/ebook/">전자책</a></li>
						<li id="menu-item-444" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-444"><a href="https://lib.snu.ac.kr/find/multimedia/">멀티미디어</a></li>
						<li id="menu-item-445" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-445"><a href="https://lib.snu.ac.kr/find/book/">인기·신착 도서</a></li>
						<li id="menu-item-472" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-472"><a href="https://lib.snu.ac.kr/find/collections-page/">컬렉션</a></li>
						<li id="menu-item-977" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-977"><a target="_blank" rel="noopener" href="https://s-space.snu.ac.kr/">서울대 연구업적물 S-Space</a></li>
					</ul>
					</div><!-- .sub-menu-container -->
					</li>
					<li id="menu-item-932" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-932"><a href="https://lib.snu.ac.kr/using/">도서관 서비스</a><div class="sub-menu-container" style="height: 0px;"><div class="menu-desc"><h3>도서관 서비스</h3><p>자료 이용과 도서관 서비스를 안내합니다.</p></div><ul class="sub-menu">	<li id="menu-item-933" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-933"><a href="https://lib.snu.ac.kr/using/userguide-membership/">이용자별 안내/회원제</a></li>
						<li id="menu-item-934" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-934"><a href="https://lib.snu.ac.kr/using/loans-returns-holds-payment/">도서 대출·반납·예약·결제</a></li>
						<li id="menu-item-935" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-935"><a href="https://lib.snu.ac.kr/using/purchase-textbook/">희망·강의도서 신청·조회</a></li>
						<li id="menu-item-12227" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-12227"><a href="https://lib.snu.ac.kr/using/purchase-journal/">학술지 및 전자자료 신청 안내</a></li>
						<li id="menu-item-936" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-936"><a href="https://lib.snu.ac.kr/using/course-reserves/">지정도서 신청·조회</a></li>
						<li id="menu-item-937" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-937"><a href="https://lib.snu.ac.kr/using/thesis/">학위논문</a></li>
						<li id="menu-item-938" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-938"><a href="https://lib.snu.ac.kr/using/proxy/">학외접속</a></li>
						<li id="menu-item-939" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-939"><a href="https://lib.snu.ac.kr/using/mobile/">모바일 서비스</a></li>
						<li id="menu-item-12025" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-12025"><a href="https://lib.snu.ac.kr/using/places-carrel/">시설 예약·신청</a></li>
						<li id="menu-item-941" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-941"><a href="https://lib.snu.ac.kr/using/print/">인쇄·복사/네트워크</a></li>
						<li id="menu-item-942" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-942"><a href="https://lib.snu.ac.kr/using/ill-dds-fric/">상호대차·원문복사·FRIC</a></li>
						<li id="menu-item-943" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-943"><a href="https://lib.snu.ac.kr/using/kjmediaplex/">관정미디어플렉스</a></li>
						<li id="menu-item-14847" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-14847"><a href="https://lib.snu.ac.kr/using/events/">학술행사 동영상</a></li>
					</ul></div><!-- .sub-menu-container --></li>
					<li id="menu-item-946" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-946"><a href="https://lib.snu.ac.kr/research/">학술연구지원</a><div class="sub-menu-container" style="height: 0px;"><div class="menu-desc"><h3>학술연구지원</h3><p>연구활동에 필요한 교육과 안내를 제공합니다.</p></div><ul class="sub-menu">	<li id="menu-item-947" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-947"><a href="https://lib.snu.ac.kr/research/researchsupport/">연구지원 서비스</a></li>
						<li id="menu-item-948" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-948"><a href="https://lib.snu.ac.kr/research/library-instruction/">도서관 이용교육</a></li>
						<li id="menu-item-978" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-978"><a target="_blank" rel="noopener" href="https://libguide.snu.ac.kr/main">Research guides</a></li>
						<li id="menu-item-979" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-979"><a target="_blank" rel="noopener" href="https://libguide.snu.ac.kr/c.php?g=321558&amp;p=2151736">논문작성 가이드</a></li>
						<li id="menu-item-951" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-951"><a href="https://lib.snu.ac.kr/research/research-analysis/">연구업적 분석지원</a></li>
					</ul></div><!-- .sub-menu-container --></li>
					<li id="menu-item-963" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-963"><a href="https://lib.snu.ac.kr/about/">도서관 안내</a><div class="sub-menu-container" style="height: 0px;"><div class="menu-desc"><h3>도서관 안내</h3><p>도서관 운영 정책과 방문 안내입니다.</p></div><ul class="sub-menu">	<li id="menu-item-964" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-964"><a href="https://lib.snu.ac.kr/about/notice-news/">알림·소식</a></li>
						<li id="menu-item-965" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-965"><a href="https://lib.snu.ac.kr/about/calendar/">도서관 일정</a></li>
						<li id="menu-item-966" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-966"><a href="https://lib.snu.ac.kr/about/hour-directions/">이용시간·찾아오는 길</a></li>
						<li id="menu-item-967" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-967"><a href="https://lib.snu.ac.kr/about/libraries/">도서관 소개</a></li>
						<li id="menu-item-968" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-968"><a href="https://lib.snu.ac.kr/about/floor-guide/">층별 시설 안내</a></li>
						<li id="menu-item-969" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-969"><a href="https://lib.snu.ac.kr/about/staff-inquiry/">직원소개·연락처</a></li>
						<li id="menu-item-970" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-970"><a href="https://lib.snu.ac.kr/about/statistics/">도서관 통계</a></li>
						<li id="menu-item-971" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-971"><a href="https://lib.snu.ac.kr/about/pr-visit-tour/">홍보·방문·견학</a></li>
						<li id="menu-item-972" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-972"><a href="https://lib.snu.ac.kr/about/bus-information/">셔틀버스 시간</a></li>
						<li id="menu-item-973" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-973"><a href="https://lib.snu.ac.kr/about/donations/">기증·기부</a></li>
						<li id="menu-item-974" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-974"><a href="https://lib.snu.ac.kr/about/ask-us/">Ask us</a></li>
					</ul></div><!-- .sub-menu-container --></li>
					<li id="menu-item-952" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-has-children menu-item-952"><a href="https://lib.snu.ac.kr/mylibrary/">마이 라이브러리</a><div class="sub-menu-container" style="height: 0px;"><div class="menu-desc"><h3>마이 라이브러리</h3><p>나의 도서·서비스 이용 현황을 확인하세요.</p></div><ul class="sub-menu">	<li id="menu-item-953" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-953"><a href="https://lib.snu.ac.kr/mylibrary/my-info/">개인정보관리</a></li>
						<li id="menu-item-980" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-980"><a target="_blank" rel="noopener" href="https://snu-primo.hosted.exlibrisgroup.com/primo-explore/account?vid=82SNU&amp;section=overview&amp;lang=ko_KR">도서 대출·연장·예약 조회</a></li>
						<li id="menu-item-981" class="menu-item menu-item-type-custom menu-item-object-custom menu-item-981"><a target="_blank" rel="noopener" href="https://snu-primo.hosted.exlibrisgroup.com/primo-explore/favorites?vid=82SNU&amp;lang=ko_KR&amp;section=items">즐겨찾기</a></li>
						<li id="menu-item-956" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-956"><a href="https://lib.snu.ac.kr/mylibrary/my-payment/">온라인 결제·내역 조회</a></li>
						<li id="menu-item-957" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-957"><a href="https://lib.snu.ac.kr/mylibrary/my-purchase/">희망·강의도서 신청 조회</a></li>
						<li id="menu-item-3716" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-3716"><a href="https://lib.snu.ac.kr/using/loans-returns-holds-payment/missing/m-request/">서가에 없는 도서 확인 요청 조회</a></li>
						<li id="menu-item-3717" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-3717"><a href="https://lib.snu.ac.kr/research/library-instruction/library-instruction/workshops/">도서관 이용교육 신청 조회</a></li>
						<li id="menu-item-3719" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-3719"><a href="https://lib.snu.ac.kr/research/researchsupport/research-support/rs-request/">연구지원 서비스 신청 조회</a></li>
						<li id="menu-item-3617" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-3617"><a href="https://lib.snu.ac.kr/mylibrary/other-view/">서비스 신청 조회</a></li>
					</ul></div><!-- .sub-menu-container --></li>
					</ul></div>			</nav><!-- .primary-menu -->
											
				<nav class="header-menu" aria-label="부가적인 메뉴">
					<ul class="menu-wrapper">
						<!-- <li>					
							<a role="button" class="btn btn-no-spacing btn-user-login" id="user-login-button" data-toggle="modal" data-target="#login_modal">로그인</a>
						<li>
							-->
							<li class="menu">					
								<a role="button" class="btn btn-no-spacing btn-user-login login_txt" id="user-login-button" data-toggle="modal" data-target="#login_modal">아이리스닷넷님<i class="im xi-angle-down-min"></i></a>
								<div class="sub hide">
									<h2>아이리스닷넷 님</h2>
									<span class="member_txt">일반회원</span>
									<ul>
										<span class="member_txt2 white">나의 Like SNU</span>
										<li><a href="#None">나의 관심 주제 설정</a></li>
										<li><a href="#None">콘텐츠 이용 내역보기 </a></li>
										<li><a href="#None"> 나의 LikeSUN 컬렉션</a></li>
										<li><a href="#None">내가 팔로우하는 LikeSNU</a></li>
									</ul>
									<a href="#link" class="mypage_btn login_txt3">마이페이지</a>
									<a href="#link" class="logout_btn login_txt3">로그아웃</a>
								</div>
							</li>

							<li>
								<div class="wpml-ls-statics-shortcode_actions wpml-ls wpml-ls-legacy-list-horizontal">
									<ul>
										<li class="wpml-ls-slot-shortcode_actions wpml-ls-item wpml-ls-item-en wpml-ls-first-item wpml-ls-last-item wpml-ls-item-legacy-list-horizontal">
												<a href="https://lib.snu.ac.kr/?lang=en" class="wpml-ls-link">
													<span class="wpml-ls-native" lang="en">ENG</span></a>
										</li>
									</ul>
								</div>
							</li>
							<li class="menu2">
									<a role="button" class="btn btn-icon dropdown-toggle no-arrow btn-no-spacing" id="help-menu-button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
										<svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><path fill="currentColor" d="M11 18h2v-2h-2v2zm1-16C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.41 0-8-3.59-8-8s3.59-8 8-8 8 3.59 8 8-3.59 8-8 8zm0-14c-2.21 0-4 1.79-4 4h2c0-1.1.9-2 2-2s2 .9 2 2c0 2-3 1.75-3 5h2c0-2.25 3-2.5 3-5 0-2.21-1.79-4-4-4z"></path></svg>
										<span class="sr-only">문의</span>
									</a>
									<div class="sub2 hide" aria-labelledby="help-menu-button" >
										<a class="dropdown-item" href="https://lib.snu.ac.kr/about/notice-news/notice">알림·소식</a>
										<a class="dropdown-item" href="https://lib.snu.ac.kr/about/notice-news/suggestion-board">도서관 의견함</a>
										<a class="dropdown-item" href="https://lib.snu.ac.kr/about/notice-news/faq/">자주찾는 질문</a>
										<a class="dropdown-item" href="https://lib.snu.ac.kr/about/notice-news/download-forms/">서식자료실</a>
									</div>
								</div>
							</li>
						</ul>
				</nav><!-- .header-menu -->
			</div><!-- .container -->
		</nav>
	</header>

	<div class="top_search_box">
		<div class="quickmenu">
			<h2>최근 확인한 콘텐츠</h2>
			<ul>
			  <li><a href="#none"><img src="../images/sub_book_list_img01.png"></a></li>
			  <li><a href="#none"><img src="../images/sub_book_list_img02.png"></a></li>
			  <li><a href="#none"><img src="../images/sub_book_list_bank_img.png"></a></li>
			</ul>
			<p class="quick_more_view">
				<span class="red_bg">12건</span>
				<span class="more_btn quick_more_btn">더보기</span>
			</p>
		  </div>

			<!-- 퀵메뉴 오픈 추가 -->
			<div class="quikmenu_open" style="display: none;">

			<p class="quik_open_txt">최근 확인한 컨텐츠</p>
			
			<button class="quik_close_btn" title="퀵메뉴 닫기"><i class="xi-close"></i></button>

			<div class="quik_cont_pd">
				<div class="search_big_tab">
					<ul class="quick_search_tab">
						<li class="tab-link current" data-tab="tab-1-1"><a class="blue li_tit" href="#link">도서</a></li>
						<li class="tab-link" data-tab="tab-2-1"><a class="blue li_tit " href="#link">논문</a></li>
						<li class="tab-link" data-tab="tab-3-1"><a class="blue li_tit " href="#link">강의</a></li>
					</ul>
				</div>

				<div id="tab-1-1" class="quick_tab_content current">
					<div class="search_book_wrap">
						<ul class="recommended_book_list">
							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"> <a href="#"> <img src="../images/sub_book_list_B_img01.png"></a></p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3> <a href="#"> 예약판매 기초에서 응용까지 대화형 GPT: 생성AI</a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"> <a href="#"> <img src="../images/sub_book_list_img02.png"></a> </p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3><a href="#"> [국내도서] 생성형 AI 프롬프트 디자인 </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"><a href="#"> <img src="../images/subject_book_img01.png"></a> </p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3><a href="#"> 물고기는 존재하지않는다. </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"><a href="#"> <img src="../images/subject_book_img02.png"></a></p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3><a href="#"> [국내도서] 예약판매 기초에서 응용까지 대화형 GPT: 생성AI </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"></p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3><a href="#"> [국내도서] 생성형 AI 프롬프트 디자인 </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							
							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"></p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3> <a href="#"> [국내도서] 예약판매 기초에서 응용까지 대화형 GPT: 생성AI </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>

							<li>
								<p class="sub_book_liet_img sub_book_liet_img01"></p>
								<div class="sub_book_list_txt">
									<a href="#link" class="over_underline"><h3><a href="#"> [국내도서] 생성형 AI 프롬프트 디자인 </a></h3></a>
									<p>강건욱 저자(글) /  한영석 감수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>
						</ul><!--recommended_book_list-->
					</div><!--search_book_wrap-->
				</div><!--tab1-->

				<div id="tab-2-1" class="quick_tab_content ">
					<div class="search_book_wrap">
						<ul class="recommended_book_list">
							<li>
								<div class="sub_book_list_txt">
									<h3> <a href="#"> 예비교사의 인공지능 활용 교육에 대한 인식 분석</a></h3>
									<p>한국디지털콘텐츠학회  / 지현경(Hyun-Kyung Chee) ; 홍현미(Hyeonmi Hong)</p>
									<em class="ml_10"><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em> <!-- 논문탭은 ml_10 추가 -->
								</div>
							</li>
							<li>
								<div class="sub_book_list_txt">
									<h3> <a href="#"> 예비교사의 인공지능 활용 교육에 대한 인식 분석</a></h3>
									<p>한국디지털콘텐츠학회  / 지현경(Hyun-Kyung Chee) ; 홍현미(Hyeonmi Hong)</p>
									<em class="ml_10"><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em> 
								</div>
							</li>
							<li>
								<div class="sub_book_list_txt">
									<h3> <a href="#"> 예비교사의 인공지능 활용 교육에 대한 인식 분석</a></h3>
									<p>한국디지털콘텐츠학회  / 지현경(Hyun-Kyung Chee) ; 홍현미(Hyeonmi Hong)</p>
									<em class="ml_10"><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>
						</ul>
					</div><!--search_book_wrap-->
				</div><!--tab2-->

				<div id="tab-3-1" class="quick_tab_content ">
					<div class="search_book_wrap">
						<ul class="recommended_book_list thesis_box">
							<li>
								<div class="sub_book_list_txt">
									<h3><a href="#"> 국어교육학개론</a>  </h3>
									<span class="year2">2023 / 2학기</span>
									<span class="green red_bg">국어국문학과</span>
									<p>김교수</p>
									<em><a href="#" title="담기"  class="dw_s"> <i class="xi-arrow-bottom"></i>  </a> </em>
								</div>
							</li>
						</ul><!--recommended_book_list-->
					</div><!--search_book_wrap-->
				</div><!--tab2-->
			</div><!--quik_cont_pd-->
		</div>

		<div class="top_box top_5menu main1">
			<ul class="menu5_box tabs1">
				<li class="tab-link current "><a class="blue li_tit li_tit01" href="#link">LikeSNU</a></li>
				<li class="tab-link"><a class="blue li_tit li_tit02" href="#link">주제</a></li>
				<li class="tab-link "><a class="blue li_tit li_tit03" href="#link">도서</a></li>
				<li class="tab-link"><a class="blue li_tit li_tit04" href="#link">논문</a></li>
				<li class="tab-link"><a class="blue li_tit li_tit05" href="#link">강의</a></li>
			</ul>
		</div>	
		<div class="top_box search_wrod">
			<span class="tit">인기검색어</span>
			<p class="tit2">
				<span class="search_word_drop">언어모델</span>
				<ul class="sub_menu">
					<span class="sub_menu_tit">인기검색어</span>
					<li><a href="#link"><span class="num">1</span> 언어모델</a></li>
					<li><a href="#link"><span class="num">2</span> 소설</a></li>
					<li><a href="#link"><span class="num">3</span> 쇼펜하우</a></li>
					<li><a href="#link"><span class="num">4</span> 파이썬</a></li>
					<li><a href="#link"><span class="num">5</span> AI</a></li>
					<li><a href="#link"><span class="num">6</span> 쇼펜하우</a></li>
					<li><a href="#link"><span class="num">7</span> 쇼펜하우</a></li>
					<li><a href="#link"><span class="num">8</span> 쇼펜하우</a></li>
					<li><a href="#link"><span class="num">9</span> 쇼펜하우</a></li>
					<li><a href="#link"><span class="num">10</span>쇼펜하우</a></li>
				</ul>
			</p>
		</div> 
		<div class="top_box search_wrap">
	        <input id="searchEngineKeyword" type="text" placeholder='도서, 논문,강의 등 서울대학교의 모든 지식을 검색해보세요.'><!-- 도서, 논문,강의 등 서울대학교의 모든 지식을 검색해보세요. -->
	        <input type="hidden" id="backupKeyword" value=""/> <!-- 검색엔진을 자주 호출하지 않기 위한 검증용 키워드 저장 input -->
	        <input type="hidden" id="searchEngineBackKeyword" value="${searchMap.searchKeyword}"/>
	        <!-- <button title="검색" onclick="cfn_searchEngine(); return false;" value="검색" />-->
	        <button title="검색" onclick="cfn_searchEngine_ex(); return false;" value="검색" />		
		</div>
	</div> <!--top_search_box-->

		<div class="sub sub3-1 sub-search">
			<div id="sub_bar">
				<div class="inner">
					<div class="location_wrap">
						<strong class="sub_hide">현재 페이지 경로</strong>
						<ul class="location">
							<li class="home"><a href="/">홈</a></li>
							<li><a class="last_bdcrm" href="#link">통합검색</a></li>
						</ul>
					</div>
				</div>
			</div>

			<div id="scontents" class="subcontents_box">
				<div class="page_tit"><h2 class="tit">통합검색</h2></div>

				<div class=" tag_subject mb_30"> 
					<dl class="subcont_Area">
						<dt>연관검색 더보기 <i class="xi-angle-right-min"></i> </dt>
						<dd><span class="tag select">#dayoff</span> <span class="tag">#work schedule</span> <span class="tag">#대중문화</span> <span class="tag">#참고문헌</span> <span class="tag">#topic</span>
							<span class="tag">#과학자</span> <span class="tag">#가정법</span> <span class="tag">#프로그래밍</span> <span class="tag">#과학자</span> <span class="tag">#가정법</span> <span class="tag">#프로그래밍</span><span class="tag">#과학자</span> <span class="tag">#가정법</span> <span class="tag">#프로그래밍</span></dd>
					</dl>
				</div>

				<div class="content_warp">
					<!--sub_search_top_tit-->

					<!-- 추천검색결과 큰 탭 -->
					<div class="search_big_tab">
						<ul class="search_tab">
							<li class="tab-link" data-tab="tab-1"><a class="blue li_tit" href="#link">통합검색(232)</a></li>
							<li class="tab-link current" data-tab="tab-2"><a class="blue li_tit " href="#link">도서(122)</a></li>
							<li class="tab-link" data-tab="tab-3"><a class="blue li_tit " href="#link">논문(0)</a></li>
							<li class="tab-link" data-tab="tab-4"><a class="blue li_tit " href="#link">강의(0)</a></li>
							<li class="tab-link" data-tab="tab-5"><a class="blue li_tit " href="#link">기타자료(0)</a></li>
							<li class="tab-link" data-tab="tab-6"><a class="blue li_tit " href="#link">LikeSNU(0)</a></li>
						</ul>
					</div>

					<!-- 도서탭 -->
					<div id="tab-2" class="tab_content1 current">
						<div class="sub-search-book">
						<div class="search_book_wrap">
							<div class="sub_search_tit">
								<%-- <p class="sub_top_tit1">‘<c:out value="${searchMap.searchKeyword}"/>’ 에 대해 <span class="red">도서</span> 결과가 <span class="red">122건</span> 자료가 있습니다. </p> --%>
								<span class="blue_bar">도서(122)</span>
							</div>
							
							<div class="page_count mt_15">페이지 (<em class="f_c_r">1</em>/25) 
								<div class="tit_btnareaR"><button type="button" class="Btn btn-success" onclick="">  LikeSNU컬렉션에 담기 <i class="xi-download"></i></button>
									<button type="button" class="Btn btn-success" onclick=""> EXCEL내보내기 <i class="xi-share"></i></button>
									<select name="recommended_sel" id="recommended_sel2" class="recommended_sel1 W70" title="모든주제 선택">
										<option value="">10건</option>
										<option value="">20건</option>
										<option value="">30건</option>
										<option value="">40건</option>
									</select></div>
							</div><!--search_tit-->

							<div class="search_filter">
								<p class="filter_tit">검색결과 필터</p>
								<div class="search_filter_box">
									<h3>정렬</h3>
									<select name="recommended_sel" id="recommended_sel1" class="recommended_sel1" title="추천도순 선택">
										<option value="">추천도순</option>
										<option value="">추천도순1</option>
										<option value="">추천도순2</option>
										<option value="">추천도순3</option>
									</select>
									<h3>검색</h3>
									<a href="#none" class="filter_o filter_btn"><button>필터적용</button></a>
									<a href="#none" class="reset_btn filter_btn"><button>초기화</button></a>
									<h3>기간</h3>
									<label for="" class="skip">시작년도</label>
									<input type="text" name="rf" value="" class="datePicker form-control" title="시작년도" placeholder="시작년도">
									<label for="" class="skip">종료년도</label>
									<input type="text" name="rt" value="" class="datePicker form-control" title="종료년도" placeholder="종료년도">
									<input type="hidden" name="range" value="000000000021">
									<h3>제목</h3>
									<input type="text" name="title" id="title" value="" class="form-control" title="제목" placeholder="제목">
									<h3>저자</h3>
									<input type="text" name="author" id="author" value="" class="form-control" title="저자" placeholder="저자">
									<h3>자료유형</h3>
									<ul class="work_type">
										<li>
											<input type="checkbox" id="ar_ch3">
											<label for="ar_ch3"><strong>종이책/단행본 (200)</strong></label>
											<!-- <input id="check" name="inc" type="checkbox" value="9"><label for="check" class="check"> 종이책/단행본 (200)</label> -->
										</li>
										<li>
											<input type="checkbox" id="ar_ch3">
											<label for="ar_ch3"><strong>전자책</strong></label>
											<!-- <input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> 전자책</label> -->
										</li>
									</ul>
									<h3>주제</h3>
									<div class="work_type_box">
										<ul class="work_type work_type2">
											<li>
												<input id="check" name="inc" type="checkbox" value="9"><label for="check" class="check"> 딥러닝 (120)</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> 인공지능 (90)</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> AI (120)1</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> AI (120)2</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> AI (120)3</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> AI (120)4</label>
											</li>
											<li>
												<input id="check" name="inc" type="checkbox" value="10"><label for="check" class="check"> AI (120)5</label>
											</li>
										</ul>
									</div> <!--work_type_box-->
								</div><!--search_filter_box-->
							</div><!--search_filter-->

							<ul class="recommended_book_list" id="emptyList">
								<div class="recommended_book ml_20_mn">
									<div class="top_recommended_book">
										<ul>
											<li class="ch_nAll">
												<input type="checkbox" id="ar_ch1all" class="ml_10">
											</li>
											<li>
												<p class="blue_arrow">
													<span></span> 
													도서
												</p>
											</li>
										</ul>
									</div> <!--top_recommended_book-->
								</div>
								
								<li>
									<div class="no_info" style="border: none;">
										<p>검색결과가 존재하지 않습니다.</p>
										<button type="button">
											<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="희망 도서 신청">
												희망 도서 신청
											</a>
										</button>
									</div>
								</li>
								
								<%-- 
								<c:if test="${!empty searchResult}">
									<c:forEach var="result" items="${searchResult}" varStatus="status">
										<c:if test="${status.index < 10}">
											<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
											<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"><img src='<c:out value="${result.cover}"/>'></p></a>
											<div class="sub_book_list_txt">
												<h3><a href="#"><c:out value="${result.title}"/></a></h3>
												<p><c:out value="${result.author}"/></p>
												<span class="year2"><c:out value="${result.publication_date}"/>년</span>
												<ul class="share_box">
													<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
													<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>								
													<ul class="more_view_drop1">
														<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
														<li><a href="link" class="read"> 이미읽음</a></li>
														<li><a href="link" class="not_interested">관심없음</a></li>
														<li><a href="link" class="loan">대출하기</a></li>
														<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
													</ul>
												</ul>
											</div>
										</c:if>
									</c:forEach>
								</c:if>
								<c:if test="${empty searchResult}">
									<div class="no_info" style="border: none;">
										<p>검색결과가 존재하지 않습니다.</p>
										<button type="button">
											<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="희망 도서 신청">
												희망 도서 신청
											</a>
										</button>
									</div>
								</c:if>
								 --%>
							</ul><!--recommended_book_list-->
							
							<ul class="recommended_book_list viewList" style="display: none;">
								<div class="recommended_book ml_20_mn">
									<div class="top_recommended_book">
										<ul>
											<li class="ch_nAll">
												<input type="checkbox" id="ar_ch1all" class="ml_10">
											</li>
											<li>
												<p class="blue_arrow">
													<span></span> 
													키워드검색
												</p>
											</li>
										</ul>
									</div> <!--top_recommended_book-->
								</div>
								
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="${result.title}"/></a></h3>
										<span class="year2"><c:out value=""/></span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
							</ul>
							
							<ul class="recommended_book_list viewList" style="display: none;">
								<div class="recommended_book ml_20_mn">
									<div class="top_recommended_book">
										<ul>
											<li class="ch_nAll">
												<input type="checkbox" id="ar_ch1all" class="ml_10">
											</li>
											<li>
												<p class="blue_arrow">
													<span></span> 
													의미검색
												</p>
											</li>
										</ul>
									</div> <!--top_recommended_book-->
								</div>
								
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="농업의 이해"/></a></h3>
										
										<span class="year2"><c:out value=""/>99120711302591</span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="보통작물"/></a></h3>
										
										<span class="year2"><c:out value=""/>99140298502591</span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="농군"/></a></h3>
										
										<span class="year2"><c:out value=""/>99123453302591</span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="농업재해보험이 농산물 생산에 미치는 영향 분석 "/></a></h3>
										
										<span class="year2"><c:out value=""/>99645284402591</span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
								<li>
									<div class="ch_n"> <input type="checkbox" id="ar_ch1" class="ml_5"> </div>
									<a href="#"><p class="sub_book_liet_img sub_book_liet_img01"></p></a>
									<div class="sub_book_list_txt">
										<h3><a href="#"><c:out value="식용작물학"/></a></h3>
										
										<span class="year2"><c:out value=""/>99123942702591</span>
										<ul class="share_box">
											<button title="공유하기" class="mr_30"><i class="xi-share-alt-o"></i></button>	
											<button class="more_view_btn1" title="더보기"><i class="xi-ellipsis-v"></i></button>
											<ul class="more_view_drop1">
												<li><a href="#link" class="basket">LikeSNU 컬렉션에 담기</a></li>
												<li><a href="link" class="read"> 이미읽음</a></li>
												<li><a href="link" class="not_interested">관심없음</a></li>
												<li><a href="link" class="loan">대출하기</a></li>
												<li><a href="link" class="aladdin">알라딘에서 보기</a></li>
											</ul>
										</ul>
									</div>
								</li>
							</ul>
						</div>
						</div>
					</div>
					<!-- 도서탭끝 -->
					<!--tab_content1-->
				</div><!--content_warp-->
			</div><!--contents_box-->
		</div><!--sub3-1-->
		<div class="section fp-auto-height fp-section fp-table active fp-completely">
		
			<footer class="site-footer" id="site-footer">
				<div class="site-info">
					<div class="container">
						<div class="row">
							<div class="col-lg-9">
								<div class="footer-logo">
									<a href="https://lib.snu.ac.kr/">
										<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 272 40" class="img-to-svg logo-image" src="https://lib.snu.ac.kr/wp-content/themes/snulib/assets/images/site-logo-footer.svg" alt="서울대학교 중앙도서관">
											<path fill="currentColor" d="M15.6,10.2v14.4c0,5,3.2,7.4,7.1,7.4c3.9,0,7.1-2.3,7.1-7.4s0-14.4,0-14.4H15.6z M27.8,17.5h-2.1v1h2.1v2.4  h-2.1V28h-1.8l-2.5-2.5L19,27.7l-1.7-1.7l3.8-3.8l2,2v-9.8H19v-2.1h6.6v3.1h2.2C27.8,15.3,27.8,17.5,27.8,17.5z M39.9,4.5V0H36  c-1.4,0-4.8,0-8,1.2C26,2,23.9,3.3,22.7,5.1l0,0c-1.2-1.8-3.3-3.1-5.4-3.9C14.1,0,10.8,0,9.3,0H5.5v4.5H0v32.3h8.5  c2.6,0,8.1,0.2,12.2,3.2l0.1-0.1c-0.8-1.8-3.3-5.3-13.3-5.3H2.8V6.8h2.7v25.6h1.7c4.6,0.1,11,0.7,14.7,6.6l0.1-0.1  c-0.2-2.7-3.2-8.7-13.6-8.7V6.8h0.1c7.8,0,10.1,0.8,12.4,2L21,8.8c-2.3-3.2-7.6-4.2-12.6-4.3V2.3h1.4c1.7,0,4.4,0.2,6.9,0.9  c1.4,0.4,4.2,1.6,6,4.2l0,0c1.8-2.6,4.7-3.8,6-4.2c2.5-0.8,5.2-0.9,6.9-0.9H37v2.2c-5,0.1-10.3,1-12.6,4.3l0.1,0.1  c2.2-1.3,4.6-2.1,12.4-2.1H37v23.3c-10.4,0-13.4,6-13.6,8.7l0.1,0.1c3.7-5.8,10.1-6.5,14.7-6.6h1.7V6.8h2.7v27.8h-4.8  c-9.9,0-12.5,3.5-13.3,5.3l0.1,0.1c4.1-3,9.6-3.2,12.2-3.2h8.5V4.5H39.9z M122.8,26.2h10.8v5.3h2.6v-7.6h-13.4L122.8,26.2  L122.8,26.2z M130.4,17c0-1-0.3-1.9-0.8-2.7h1.9v-2.3h-5.1v-2h-2.6v2h-5.1v2.3h2c-0.5,0.8-0.8,1.7-0.8,2.7c0,2.8,2.3,5.1,5.2,5.1  C128.1,22,130.4,19.7,130.4,17z M122.5,17c0-1.5,1.2-2.7,2.7-2.7c1.5,0,2.7,1.2,2.7,2.7c0,1.5-1.2,2.7-2.7,2.7  C123.7,19.7,122.5,18.5,122.5,17z M113,17.4h-2V9.9h-2.6v21.6h2.6V19.7h2v11.8h2.6V9.9H113V17.4z M101,23.6v-9.9h5.2v-2.3h-7.7v14.5  h5c0,0,2.9-0.1,4.2-0.5v-2.3c-1.2,0.5-4.2,0.5-4.2,0.5H101z M61.5,14.4V11h-2.7v3.4c0,2-0.5,6.8-5.5,10.4l1.6,1.9  c2.6-1.8,4.2-4,5.2-6.1c1,2.1,2.5,4.4,5.2,6.1l1.6-1.9C62,21.2,61.5,16.5,61.5,14.4z M261.3,14.2c0,0,0,3-0.8,5.1h2.6  c0.7-2.1,0.8-5.1,0.8-5.1v-3.4h-10.7v2.3h8.2L261.3,14.2L261.3,14.2z M85.5,19.1c2.9,0,5.3-2.2,5.3-4.8s-2.4-4.8-5.3-4.8  c-2.9,0-5.3,2.2-5.3,4.8C80.2,16.9,82.6,19.1,85.5,19.1z M85.5,11.7c1.5,0,2.7,1.1,2.7,2.6c0,1.4-1.2,2.6-2.7,2.6s-2.7-1.1-2.7-2.6  C82.8,12.8,84,11.7,85.5,11.7z M75.5,21.7h8.6V23h-5.5v2.1h11.2v1.1H78.6v5.3h14.2v-2.1H81.2v-1.1h11.2V23h-5.6v-1.2h8.6v-2.2H75.5  V21.7z M69.4,15.6H65v2.3h4.4v13.6H72V9.9h-2.6V15.6z M154.9,15.3c0,0-0.1,4.8-0.8,8.3h2.6c0.7-3.5,0.8-8.3,0.8-8.3v-4.1H143v2.3h12  L154.9,15.3L154.9,15.3z M219.6,21.6h5.4v-2.3h-10.8v-5.8H225v-2.3h-13.4v10.4h5.5V26h-8.8v2.3h19.9V26h-8.5V21.6z M258,24.8h-2.6  v6.7h14v-2.3H258V24.8z M237.5,14.4V11h-2.7v3.4c0,2-0.5,6.8-5.5,10.4l1.6,1.9c2.6-1.8,4.2-4,5.2-6.1c1,2.1,2.6,4.4,5.2,6.1l1.6-1.9  C238.1,21.2,237.5,16.5,237.5,14.4z M245.4,15.6H241v2.3h4.4v13.6h2.6V9.9h-2.6V15.6z M265.5,22.8v-2.3c-1.2,0.5-4.2,0.5-4.2,0.5  h-3.2v-4.8h-2.6V21h-3.7v2.3h9.5C261.3,23.3,264.3,23.3,265.5,22.8z M152.5,18.4h-2.6V26h-2.4v-7.6h-2.6V26h-4.8v2.3H160V26h-7.6  V18.4z M269.1,15.2V9.9h-2.6V26h2.6v-8.4h2.9v-2.3H269.1z M136.2,9.9h-2.6v12.7h2.6v-5h2.9v-2.3h-2.9V9.9z M204.3,9.9h-2.6v12.7h2.6  v-5h2.6v-2.3h-2.6V9.9z M198.8,15.7c0-2.9-2.5-5.2-5.7-5.2s-5.7,2.3-5.7,5.2c0,2.9,2.5,5.2,5.7,5.2C196.3,21,198.8,18.6,198.8,15.7z	M190.1,15.7c0-1.6,1.4-2.9,3.1-2.9c1.7,0,3.1,1.3,3.1,2.9s-1.4,2.9-3.1,2.9C191.4,18.6,190.1,17.3,190.1,15.7z M167,16.3l0.9,1.9  c3.4-0.6,6-2,7.4-3.5c1.4,1.5,4,2.9,7.4,3.5l0.9-1.9c-3.6-0.9-5.3-2-6.2-3c-0.3-0.3-0.4-0.6-0.6-0.9h5.4v-2.2h-13.9v2.2h5.4  c-0.1,0.3-0.3,0.6-0.6,0.9C172.4,14.3,170.6,15.4,167,16.3z M198.2,22.8c-3.1,0-5.6,2.2-5.6,5c0,2.8,2.5,5,5.6,5s5.6-2.2,5.6-5  S201.3,22.8,198.2,22.8z M198.2,30.5c-1.7,0-3-1.2-3-2.7s1.3-2.7,3-2.7c1.6,0,3,1.2,3,2.7C201.2,29.3,199.9,30.5,198.2,30.5z	M165.4,21.3h8.6V23c-2.5,0.5-4.4,2.5-4.4,4.9c0,2.8,2.6,5,5.8,5c3.2,0,5.7-2.2,5.7-5c0-2.4-1.9-4.3-4.4-4.9v-1.7h8.6v-2.2h-19.9  L165.4,21.3L165.4,21.3z M178.5,27.8c0,1.5-1.4,2.7-3.2,2.7c-1.8,0-3.2-1.2-3.2-2.7s1.4-2.7,3.2-2.7S178.5,26.3,178.5,27.8z"></path>
										</svg>
									</a>
								</div><!-- .footer-logo -->
								<div class="site-location">
									<div>08826 서울시 관악구 관악로 1 서울대학교 중앙도서관</div>
									<div>대표전화 <a href="tel:02-880-8001">02-880-8001</a>, <a href="tel:02-880-5325">5325</a></div>
									<div>단체명 : 서울대학교 중앙도서관  ㆍ 대표자 : 장덕진 ㆍ 고유번호 :  119-82-08544</div>
								</div><!-- .site-location -->
								<nav aria-label="웹사이트 정책 및 문의" class="policy-menu">
									<a class="font-weight-bold" href="https://lib.snu.ac.kr/privacy/">개인정보 처리방침</a>
									<a href="https://lib.snu.ac.kr/email/">이메일주소 무단수집 거부</a>
									<a href="https://lib.snu.ac.kr/about/libraries/central-library/c-policy/">이용 약관</a>
									<a href="http://helpu.kr/snulib/">원격지원</a>
									<a href="https://lib.snu.ac.kr/about/hour-directions/directions/">찾아오는 길</a>
									<a href="https://lib.snu.ac.kr/about/staff-inquiry/services/">서비스별 연락처</a>	
								</nav><!-- .policy-menu -->
							</div><!-- .col -->
							<div class="col-lg-3">
								<nav aria-label="소셜 미디어 페이지" class="social-menu">
									<a class="instagram" target="_blank" rel="noopener" href="https://www.instagram.com/snulib.official/?hl=ko"><svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M16.5,3h-9C5,3,3,5,3,7.5v9C3,19,5,21,7.5,21h9c2.5,0,4.5-2,4.5-4.5v-9C21,5,19,3,16.5,3z M12,15.7c-2.1,0-3.8-1.7-3.8-3.7 c0-2.1,1.7-3.8,3.8-3.8c2.1,0,3.8,1.7,3.8,3.8C15.8,14.1,14.1,15.7,12,15.7z M16.9,8.2c-0.6,0-1.1-0.5-1.1-1.1S16.3,6,16.9,6 S18,6.5,18,7.1S17.5,8.2,16.9,8.2z"></path></svg><span class="sr-only">인스타그램</span></a><a class="kakaochannel" target="_blank" rel="noopener" href="https://pf.kakao.com/_HAZAxb"><svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M12,2c-5.2,0-9.5,3.9-9.5,8.7c0,3.6,1.5,5.3,3.5,6.8l0,0v4.2c0,0.2,0.2,0.3,0.4,0.2l3.6-2.7l0.1,0c0.6,0.1,1.2,0.2,1.9,0.2
									c5.2,0,9.5-3.9,9.5-8.7S17.2,2,12,2 M8.8,13c0.9,0,1.7-0.6,2-1.4h1.4c-0.3,1.6-1.6,2.7-3.3,2.7c-2,0-3.6-1.5-3.6-3.5
									c0-2.1,1.6-3.5,3.6-3.5c1.7,0,3,1.1,3.3,2.8h-1.4c-0.2-0.9-1-1.5-2-1.5c-1.3,0-2.2,1-2.2,2.2C6.6,12,7.6,13,8.8,13 M17.9,14.1h-1.3
									v-2.8c0-0.7-0.4-1-1-1c-0.7,0-1.1,0.4-1.1,1.2v2.6h-1.3V7.2h1.3v2.6c0.3-0.5,0.8-0.7,1.5-0.7c0.5,0,1,0.2,1.3,0.5
									c0.4,0.4,0.5,0.8,0.5,1.5V14.1z"></path></svg><span class="sr-only">카카오채널</span></a><a class="youtube" target="_blank" rel="noopener" href="https://www.youtube.com/snulib"><svg class="svg-icon" width="24" height="24" aria-hidden="true" role="img" focusable="false" viewBox="0 0 24 24" version="1.1" xmlns="http://www.w3.org/2000/svg"><path d="M21.8,8.001c0,0-0.195-1.378-0.795-1.985c-0.76-0.797-1.613-0.801-2.004-0.847c-2.799-0.202-6.997-0.202-6.997-0.202 h-0.009c0,0-4.198,0-6.997,0.202C4.608,5.216,3.756,5.22,2.995,6.016C2.395,6.623,2.2,8.001,2.2,8.001S2,9.62,2,11.238v1.517 c0,1.618,0.2,3.237,0.2,3.237s0.195,1.378,0.795,1.985c0.761,0.797,1.76,0.771,2.205,0.855c1.6,0.153,6.8,0.201,6.8,0.201 s4.203-0.006,7.001-0.209c0.391-0.047,1.243-0.051,2.004-0.847c0.6-0.607,0.795-1.985,0.795-1.985s0.2-1.618,0.2-3.237v-1.517 C22,9.62,21.8,8.001,21.8,8.001z M9.935,14.594l-0.001-5.62l5.404,2.82L9.935,14.594z"></path></svg><span class="sr-only">유튜브</span></a>				</nav><!-- .social-menu -->
							</div><!-- .col -->
						</div><!-- .row -->
						<div class="copyrights">© 2022 Seoul National University Library. All rights reserved.</div>
					</div><!-- .container -->
				</div><!-- .site-info -->
			</footer><!-- .site-footer -->
		</div>
	</body>
</html>