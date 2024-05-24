<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"      uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form"   uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%--
  /**
  * @Class Name : demoSearch.jsp
  * @Description : 데모 검색 JSP
  * @Modification Information
  *
  *  @author JWK
  *  @since 2024.05.23 UPT
  * 
  */
 --%>
 <fmt:parseNumber var="bookTotalPage" value="${(bookCnt/10) + (1 - (bookCnt/10) % 1) % 1}" type="number"/>
 <fmt:parseNumber var="articleTotalPage" value="${(articleCnt/10 ) + (1 - (articleCnt/10) % 1) % 1}" type="number"/>
 <fmt:parseNumber var="courseTotalPage" value="${(courseCnt/10 ) + (1 - (courseCnt/10) % 1) % 1}" type="number"/>
 <fmt:parseNumber var="collectionTotalPage" value="${(collectionCnt/9) + (1 - (collectionCnt/9) % 1) % 1}" type="number"/>
 <fmt:parseNumber var="mediaTotalPage" value="${(mediaCnt/10) + (1 - (mediaCnt/10) % 1) % 1}" type="number"/>
 
 
 <c:if test="${searchMap.bExtendSearch == true}">
 	<c:if test="${!empty searchMap.tabName && searchMap.tabName == 'book'}">
		<c:set var="bookReTotalPage" value="${paginationInfo.totalPageCount}" />
 	</c:if>
 	<c:if test="${!empty searchMap.tabName && searchMap.tabName == 'article'}">
		<c:set var="articleReTotalPage" value="${paginationInfo.totalPageCount}" />
 	</c:if>
 	<c:if test="${!empty searchMap.tabName && searchMap.tabName == 'course'}">
		<c:set var="courseReTotalPage" value="${paginationInfo.totalPageCount}" />
 	</c:if>
 	<c:if test="${!empty searchMap.tabName && searchMap.tabName == 'collection'}">
		<c:set var="collectionReTotalPage" value="${paginationInfo.totalPageCount}" />
 	</c:if>
 	<c:if test="${!empty searchMap.tabName && searchMap.tabName == 'media'}">
		<c:set var="mediaReTotalPage" value="${paginationInfo.totalPageCount}" />
 	</c:if>
 </c:if>

 
<script type="text/javaScript">
	$(document).ready(function(){
		// [도서] 10건 보기, 50건 보기, 100건 보기
		$("#pagingSizeBookSelect").change(function(){
			var selectValue = $(this).val();
			$('#recordCountPerPage').val(selectValue);	
			fn_filterSearch('book', '1'); 
		});
		
		// [논문] 10건 보기, 50건 보기, 100건 보기
		$("#pagingSizeArticleSelect").change(function(){
			var selectValue = $(this).val();
			$('#recordCountPerPage').val(selectValue);	
			fn_filterSearch('article', '1'); 
		});
		
		// [강의] 10건 보기, 50건 보기, 100건 보기
		$("#pagingSizeCourseSelect").change(function(){
			var selectValue = $(this).val();
			$('#recordCountPerPage').val(selectValue);	
			fn_filterSearch('course', '1'); 
		});
		
		// [기타자료] 10건 보기, 50건 보기, 100건 보기
		$("#pagingSizeMediaSelect").change(function(){
			var selectValue = $(this).val();
			$('#recordCountPerPage').val(selectValue);	
			fn_filterSearch('media', '1'); 
		});
		
		// [컬렉션] 10건 보기, 50건 보기, 100건 보기
		$("#pagingSizeCollectionSelect").change(function(){
			var selectValue = $(this).val();
			$('#recordCountPerPage').val(selectValue);	
			fn_filterSearch('collection', '1'); 
		});
	});
	
	function fn_tabBlock(){
		event.stopImmediatePropagation(); // 이걸 쓰면 막힌다!
	    alert('<spring:message code="common.preparing"/>');
	    return false;
	}
	
	// 결과 내 재검색을 하는 함수입니다.
	function fn_filterSearch(tab, pagingNum) {
		$(".loading-cover").fadeIn();	// 로딩화면 완료 시 fadeOut됨
		
		var existingTabName = $('#tabName').val();
		var bookTypeArray = []; // 종이책/전자책 체크박스
		var mediaTypeArray = []; // 기타자료 자료유형 체크박스
		var courseTypeArray = []; // 강의 체크박스
		var curiFieldArray = []; // 커리큘럼 체크박스
		var korSubjectFieldArray = []; // 한글 주제 체크박스
		var engSubjectFieldArray = []; // 영문 주제 체크박스
		var form = $('#searchForm');
		var hiddenField = null; 
		
		if (tab == 'book') {
			// 도서 재검색
			$('#orderField').val($('#searchBookOrder').val()); // 정렬 드롭다운
			$('#titleField').val($('#searchBookTitle').val()); // 제목
			$('#authorField').val($('#searchBookAuthor').val()); // 저자
			// 도서 유형(종이책/전자책)
			$('input:checkbox[name="searchBookTypeCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					bookTypeArray.push(item.value);
				}
			});
			// 주제 (한/영)
			$('input:checkbox[name="searchBookKorSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					korSubjectFieldArray.push(item.value);
				}
			});
			$('input:checkbox[name="searchBookEngSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					engSubjectFieldArray.push(item.value);
				}
			});			
			
			$('#startdate').val($('#searchBookStdDate').val()); // 시작기간
			$('#enddate').val($('#searchBookEndDate').val()); // 종료기간
			
			$('#checkField').val(bookTypeArray); // 도서 유형 배열
			$('#korSubjectField').val(korSubjectFieldArray); // 한글 주제 배열
			$('#engSubjectField').val(engSubjectFieldArray); // 영문 주제 배열
			
			$('#tabName').val("book");
			
			// 재검색 시 recordCountPerPage초기화
			if(existingTabName != tab){
				$("#recordCountPerPage").val("10");
			}
			
		} else if (tab == 'article') {
			// 논문 재검색
			$('#orderField').val($('#searchArticleOrder').val()); // 정렬 드롭다운
			$('#titleField').val($('#searchArticleTitle').val()); // 제목
			$('#authorField').val($('#searchArticleAuthor').val()); // 저자
			$('#journalNameField').val($('#searchArticleJournalName').val()); // 학술지 명
			
			// 주제 (한/영)
			$('input:checkbox[name="searchArticleKorSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					korSubjectFieldArray.push(item.value);
				}
			});
			$('input:checkbox[name="searchArticleEngSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					engSubjectFieldArray.push(item.value);
				}
			});		
			
			$('#startdate').val($('#searchArticleStdDate').val()); // 시작기간
			$('#enddate').val($('#searchArticleEndDate').val()); // 종료기간
			
			$('#korSubjectField').val(korSubjectFieldArray); // 한글 주제 배열
			$('#engSubjectField').val(engSubjectFieldArray); // 영문 주제 배열
			
			$('#tabName').val("article");
			
			// 재검색 시 recordCountPerPage초기화
			if(existingTabName != tab){
				$("#recordCountPerPage").val("10");
			}
			
		} else if (tab == 'course') {
			// 강의 재검색
			$('#orderField').val($('#searchCourseOrder').val()); // 정렬 드롭다운
			$('#titleField').val($('#searchCourseTitle').val()); // 제목
			// 주제 (한/영)
			$('input:checkbox[name="searchCourseKorSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					korSubjectFieldArray.push(item.value);
				}
			});
			$('input:checkbox[name="searchCourseEngSubjectCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					engSubjectFieldArray.push(item.value);
				}
			});
			// 강의 구분
			$('input:checkbox[name="searchCourseTypeCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					courseTypeArray.push(item.value);
				}
			});
			// 수강 대상
			$('input:checkbox[name="searchCuriTypeCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					curiFieldArray.push(item.value);
				}
			});
			
			$('#startdate').val($('#searchCourseStdDate').val()); // 시작기간
			$('#enddate').val($('#searchCourseEndDate').val()); // 종료기간
			
			$('#korSubjectField').val(korSubjectFieldArray); // 한글 주제 배열
			$('#engSubjectField').val(engSubjectFieldArray); // 영문 주제 배열
			$('#courseTypeField').val(courseTypeArray); // 강의 구분 배열
			$('#curiTypeCheckField').val(curiFieldArray); // 수강 대상 배열
			
			$('#tabName').val("course");
			
			// 재검색 시 recordCountPerPage초기화
			if(existingTabName != tab){
				$("#recordCountPerPage").val("10");
			}
			
		} else if (tab == 'collection') {
			// 컬렉션 재검색
			$('#orderField').val($('#searchCollectionOrder').val()); // 정렬 드롭다운
			$('#tabName').val("collection");
			
			// 재검색 시 recordCountPerPage초기화
			if(existingTabName != tab){
				$("#recordCountPerPage").val("9");
			}
			
		} else if (tab == 'media') {
			// 기타자료 재검색
			$('#orderField').val($('#searchMediaOrder').val()); // 정렬 드롭다운
			$('#titleField').val($('#searchMediaTitle').val()); // 제목
			$('#authorField').val($('#searchMediaAuthor').val()); // 저자
			// 도서 유형(종이책/전자책)
			$('input:checkbox[name="searchMediaTypeCheck"]').each(function (index, item) {
				if($(item).prop("checked")){
					mediaTypeArray.push(item.value);
				}
			});
			
			$('#startdate').val($('#searchMediaStdDate').val()); // 시작기간
			$('#enddate').val($('#searchMediaEndDate').val()); // 종료기간
			
			$('#checkField').val(mediaTypeArray); // 도서 유형 배열
			
			$('#tabName').val("media");
			
			// 재검색 시 recordCountPerPage초기화
			if(existingTabName != tab){
				$("#recordCountPerPage").val("10");
			}
		}
		
		$('#bExtendSearch').val("true");
		
		// 재검색 시 pageNum 초기화
		if(pagingNum != "1"){
			$('#currentPageNum').val(pagingNum);
		} else {
			$('#currentPageNum').val("1");
		}
		
	    form.submit();
		
	}
	
	// 결과 내 재검색란에 입력된 사항들을 초기화하는 함수입니다. (검색조건 초기화)
	function fn_filterReset(tab) {
		if (tab == 'book') {
			$('#orderField').val('title'); // 정렬 드롭다운
			$('#titleField').val(''); // 제목
			$('#authorField').val(''); // 저자
			$('#searchBookOrder').val('title'); // 정렬 드롭다운
			$('#searchBookTitle').val(''); // 제목
			$('#searchBookAuthor').val(''); // 저자
			$('input:checkbox[name="searchBookTypeCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			$('input:checkbox[name="searchBookSubjectCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			$('#searchBookStdDate').val(''); // 시작기간
			$('#searchBookEndDate').val(''); // 종료기간
			
			$('#startdate').val(''); // 시작기간
			$('#enddate').val(''); // 종료기간
			
			$('#checkField').val(''); // 도서 유형 배열
			$('#korSubjectField').val(''); // 한글 주제 배열
			$('#engSubjectField').val(''); // 영문 주제 배열
			
			$('.searchBookKorSubjectCheck').each(function(index,item){
				$(this).prop("checked", false);
			});
			
			$('.searchBookEngSubjectCheck').each(function(index,item){
				$(this).prop("checked", false);
			});
			
			$('#tabName').val("book");
		} else if (tab == 'article') {
			// 논문 재검색
			$('#orderField').val('article_title'); // 정렬 드롭다운
			$('#titleField').val(''); // 제목
			$('#authorField').val(''); // 저자
			$('#journalNameField').val(''); // 학술지명
			$('#searchArticleOrder').val('article_title'); // 정렬 드롭다운
			$('#searchArticleTitle').val(''); // 제목
			$('#searchArticleAuthor').val(''); // 저자
			$('#searchArticleJournalName').val(''); // 학술지명
			
			$('#searchArticleStdDate').val(''); // 시작기간
			$('#searchArticleEndDate').val(''); // 종료기간
			
// 			$('#subjectField').val('');
			$('#korSubjectField').val(''); // 한글 주제 배열
			$('#engSubjectField').val(''); // 영문 주제 배열
			
			$('.searchArticleKorSubjectCheck').each(function(index,item){
				$(this).prop("checked", false);
			});
			
			$('.searchArticleEngSubjectCheck').each(function(index,item){
				$(this).prop("checked", false);
			});
			
			$('#tabName').val("article");
			
		} else if (tab == 'course') {
			// 강의 재검색
			$('#orderField').val('course_nm'); // 정렬 드롭다운
			$('#titleField').val(''); // 제목			
			$('#searchCourseOrder').val('course_nm'); // 정렬 드롭다운
			$('#searchCourseTitle').val(''); // 제목

			// 주제 (한/영)
			$('input:checkbox[name="searchCourseKorSubjectCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			$('input:checkbox[name="searchCourseEngSubjectCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			// 강의 구분
			$('input:checkbox[name="searchCourseTypeCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			// 수강 대상
			$('input:checkbox[name="searchCuriTypeCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			
			$('#searchCourseStdDate').val(''); // 시작기간
			$('#searchCourseEndDate').val(''); // 종료기간
			
			$('#korSubjectField').val(''); // 한글 주제 배열
			$('#engSubjectField').val(''); // 영문 주제 배열
			$('#courseTypeField').val(''); // 강의 구분 배열
			$('#curiTypeCheckField').val(''); // 수강 대상 배열
			
			$('#tabName').val("course");
		} else if (tab == 'collection') {
			// 컬렉션 재검색
			$('#orderField').val('collection_title'); // 정렬 드롭다운
			$('#searchCollectionOrder').val('collection_title'); // 정렬 드롭다운
			$('#tabName').val("collection");
		} else if (tab == 'media') {
			// 기타자료 재검색
			$('#orderField').val('title'); // 정렬 드롭다운
			$('#titleField').val(''); // 제목
			$('#authorField').val(''); // 저자
			$('#searchMediaOrder').val(''); // 정렬 드롭다운
			$('#searchMediaTitle').val(''); // 제목
			$('#searchMediaAuthor').val(''); // 저자
			$('#searchCourseOrder').val('course_nm'); // 정렬 드롭다운
			$('#searchCourseTitle').val(''); // 제목
			
			// 도서 유형(종이책/전자책)
			$('input:checkbox[name="searchMediaTypeCheck"]').each(function (index, item) {
				$(item).prop("checked", false);
			});
			
			$('#startdate').val($('#searchMediaStdDate').val()); // 시작기간
			$('#enddate').val($('#searchMediaEndDate').val()); // 종료기간
			
			$('#checkField').val(mediaTypeArray); // 도서 유형 배열
			
			$('#tabName').val("media");	
		}
	}
	
	// 전체 체크하기 및 해제하기, 추천 결과에서 가져왔음… 곧 페이징 바꿀 때 변경 필요
	function fn_allCheck(obj){
		var thisId = $(obj).attr("id");
		var checkedYn = $(obj).is(':checked');
		
		if(checkedYn == true) {
			$("[class=showPagingLi]").each(function() {
				$(this).find(".contentsCheckBox").prop("checked", true);
			});
			
		} else {
			$(".contentsCheckBox").prop('checked', false);
		}
	}
	
	// excel 다운로드, 이것도 가져왔음…
	function exportExcel(mode){ 
		var tmpChkCnt = $(".contentsCheckBox:checked").length;	//체크박스 중 체크된 것들 개수 체크
		if(tmpChkCnt == 0){
			cfn_alertToast('<spring:message code="common.excel.download.select" />');
			return false;
		}
	    
	    // 엑셀에 들어갈 컨텐츠 배열
		var excelContents = new Array();
		
		// 체크박스 셀렉팅
		var chks = $(".contentsCheckBox");
		var cnt = 1;
		
		if (mode == 'book') {
			// 체크한 것중 컨텐츠 정보 가져온다.
			for(var chk of chks){
				if(chk.checked){
					var data = new Object();
					var contents = $(chk).next();
				
					data.번호 = cnt;
					data.컨텐츠종류 = "도서";
					data.컨텐츠ID = contents.data("conid");
					data.제목 = contents.data("title").trim();
					data.저자 = contents.data("author");
					data.발행년도 = contents.data("pubdate");
					
					excelContents.push(data);
					cnt++;
				}
			}
		} else if (mode == 'article') {
			// 체크한 것중 컨텐츠 정보 가져온다.
			for(var chk of chks){
				if(chk.checked){
					var data = new Object();
					
					var contents = $(chk).next();
					
					data.번호 = cnt;
					data.컨텐츠종류 = "논문";
					data.컨텐츠ID = contents.data("conid");
					data.제목 = contents.data("title").trim();
					data.저자 = contents.data("author").trim();
					data.발행년도 = contents.data("pubdate");
					
					excelContents.push(data);
					cnt++;
				}
			}
		} else if (mode == 'course') {
			// 체크한 것중 컨텐츠 정보 가져온다.
			for(var chk of chks){
				if(chk.checked){
					var data = new Object();
					
					var contents = $(chk).next();
					
					data.번호 = cnt;
					data.콘텐츠종류 = "강의";
					data.콘텐츠ID = contents.data("conid");
					data.제목 = contents.data("title").trim();
					data.저자 = "";
					data.발행년도 = "";
					
					excelContents.push(data);
					cnt++;
				}
			}
		} else if (mode == 'media') {
			// 체크한 것중 컨텐츠 정보 가져온다.
			for(var chk of chks){
				if(chk.checked){
					var data = new Object();
					
					var contents = $(chk).next();
					
					data.번호 = cnt;
					data.콘텐츠종류 = "기타자료";
					data.콘텐츠ID = contents.data("conid");
					data.제목 = contents.data("title").trim();
					data.저자 = contents.data("author").trim();
					data.발행년도 = contents.data("date").trim();
					
					excelContents.push(data);
					cnt++;
				}
			}
		}
		
		// 엑셀 핸들러 구성
		let excelHandler = {
	        getExcelFileName : function(){
	        	 if (mode == 'book') {
	        		 return '<spring:message code="title.book" />' + '_' + getToday() + '.xlsx';
	        	 } else if (mode == 'article') {
	        		 return '<spring:message code="title.thesis" />' + '_' + getToday() + '.xlsx'; 
	        	 } else if (mode == 'course') {
	        		 return '<spring:message code="title.course" />' + '_' + getToday() + '.xlsx';
	        	 } else if (mode == 'media') {
	        		 return '<spring:message code="title.etcData" />' + '_' + getToday() + '.xlsx';
	        	 }
	        },
	        getSheetName : function(){
	            return mode;
	        },
	        getExcelData : function(){
	            return excelContents;
	        },
	        getWorksheet : function(){
	            return XLSX.utils.json_to_sheet(this.getExcelData());
	        }
		}

		// step 1. workbook 생성
	    var wb = XLSX.utils.book_new();

	    // step 2. 시트 만들기 
	    var newWorksheet = excelHandler.getWorksheet();

	    // step 3. workbook에 새로만든 워크시트에 이름을 주고 붙인다.  
	    XLSX.utils.book_append_sheet(wb, newWorksheet, excelHandler.getSheetName());

	    // step 4. 엑셀 파일 만들기 
	    var wbout = XLSX.write(wb, {bookType:'xlsx',  type: 'binary'});

	    // step 5. 엑셀 파일 내보내기 
	    saveAs(new Blob([s2ab(wbout)],{type:"application/octet-stream"}), excelHandler.getExcelFileName());
	    
	    // 엑셀다운로드 후 체크박스 해제
		$("#ar_ch1all").prop('checked', false);
		$(".contentsCheckBox").prop('checked', false);

	}
	
	function s2ab(s) { 
	    var buf = new ArrayBuffer(s.length); //convert s to arrayBuffer
	    var view = new Uint8Array(buf);  //create uint8array as viewer
	    for (var i=0; i<s.length; i++) view[i] = s.charCodeAt(i) & 0xFF; //convert to octet
	    return buf;    
	}
	
	//오늘 날짜 구하기
	function getToday(){
	    var date = new Date();
	    var year = date.getFullYear();
	    var month = ("0" + (1 + date.getMonth())).slice(-2);
	    var day = ("0" + date.getDate()).slice(-2);
	
	    return year + month + day;
	}
	
	// 페이지 이동 함수
 	function fn_pageMove(pageNo) {
 		var tabName = '${searchMap.tabName}';
		fn_filterSearch(tabName, pageNo);
	} 
	
</script>

<input type="hidden" id="currPageValBook" name="currPageValBook" value="1" />
<input type="hidden" id="currPageValArticle" name="currPageValArticle" value="1" />
<input type="hidden" id="currPageValCourse" name="currPageValCourse" value="1" />
<input type="hidden" id="currPageValCollection" name="currPageValCollection" value="1" />
<input type="hidden" id="currPageValMedia" name="currPageValMedia" value="1" />

<form name="searchForm" id="searchForm" action="/usr/cmn/search/searchEngine.do" method="post">
	<input type="hidden" id="orderField" name="orderField" value="" />
	<input type="hidden" id="titleField" name="titleField" value="" />
	<input type="hidden" id="authorField" name="authorField" value="" />
	<input type="hidden" id="journalNameField" name="journalNameField" value="" />
	<input type="hidden" id="detailAt" name="detailAt" value="${searchMap.detailAt}" />
	
	<input type="hidden" id="detailkeyword1" name="detailkeyword1" value="${searchMap.detailkeyword1}" />
	<input type="hidden" id="detailkeyword2" name="detailkeyword2" value="${searchMap.detailkeyword2}" />
	<input type="hidden" id="detailkeyword3" name="detailkeyword3" value="${searchMap.detailkeyword3}" />
	
	<input type="hidden" id="orAndSelect1" name="orAndSelect1" value="${searchMap.orAndSelect1}" />
	<input type="hidden" id="orAndSelect2" name="orAndSelect2" value="${searchMap.orAndSelect2}" />
	<input type="hidden" id="orAndSelect3" name="orAndSelect3" value="${searchMap.orAndSelect3}" />
	
	<input type="hidden" id="categoryField1" name="categoryField1" value="${searchMap.categoryField1}" />
	<input type="hidden" id="categoryField2" name="categoryField2" value="${searchMap.categoryField2}" />
	<input type="hidden" id="categoryField3" name="categoryField3" value="${searchMap.categoryField3}" />
	
	<input type="hidden" id="startdate" name="startdate" value="" />
	<input type="hidden" id="enddate" name="enddate" value="" />
	
	<input type="hidden" id="checkField" name="checkField" value="" />
	<input type="hidden" id="korSubjectField" name="korSubjectField" value="" />
	<input type="hidden" id="engSubjectField" name="engSubjectField" value="" />
	
	<input type="hidden" id="courseTypeField" name="courseTypeField" value="" />
	<input type="hidden" id="curiTypeCheckField" name="curiTypeCheckField" value="" />
	
	<input type="hidden" id="bExtendSearch" name="bExtendSearch" value="false" />
	<input type="hidden" id="tabName" name="tabName" value="${searchMap.tabName}" />
	<input type="hidden" id="searchKeyword" name="searchKeyword" value="${searchMap.searchKeyword}" />
	
	<input type="hidden" id="recordCountPerPage" name="recordCountPerPage" value="${paginationInfo.recordCountPerPage}">
	<input type="hidden" id="currentPageNum" name="currentPageNum" value="${currentPageNum}">
</form>

<div class="sub sub3-1 sub-search ">
    <div id="sub_bar">
        <div class="inner">
            <div class="location_wrap">
                <strong class="sub_hide">현재 페이지 경로</strong>
                <ul class="location">
                    <li class="home"><a href="/"><spring:message code="button.home"/><!-- 홈 --></a></li>
                    <li><a class="last_bdcrm" href="#link"><spring:message code="title.search.all"/><!-- 통합검색 --></a></li>
                </ul>
            </div>
        </div>
    </div>



    <div id="scontents" class="subcontents_box">
       
        <div class="page_tit"><h2 class="tit"><spring:message code="title.search.all"/><!-- 통합검색 --></h2></div>
		<c:if test="${notFoundRelated == false}">
	        <div class=" tag_subject mb_30"> 
	            <dl class="subcont_Area">
	                <dt><spring:message code="title.related.more"><!-- 연관 검색어 더보기 --></spring:message><i class="xi-angle-right-min"></i> </dt>
	                <dd>
	                	<c:forEach items="${relatedResult}" varStatus="rStatus" var="related"> 
	                		<c:if test="${ rStatus.index < 11 }">
	                			<span class="tag" onclick="cfn_searchEngine('<c:out value="${ SS_LOCALE ne 'en' ? related.topic_label_kor : related.topic_label_eng }"/>'); return false;"><c:out value="${ SS_LOCALE ne 'en' ? related.topic_label_kor : related.topic_label_eng }"/></span>
	                		</c:if>
	                	</c:forEach>
	                </dd>
	            </dl>
        </div>
        </c:if> 
        <div class="content_warp">
            <!-- 추천검색결과 큰 탭 -->
            <div class="search_big_tab">
                <ul class="search_tab">
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch ne 'true' || searchMap.tabName eq ''}">current</c:if>" data-tab="tab-1" id="totalSearchTab"><a class="blue li_tit" href="#link"><spring:message code="title.search.all"/><!-- 통합검색 -->(<fmt:formatNumber value="${totalCnt}" pattern="#,###" />)</a></li>
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'book'}">current</c:if>" data-tab="tab-2" id="totalSearchBookTab"><a class="blue li_tit" href="#link" onclick="fn_filterSearch('book', '1'); return false;"><spring:message code="title.book"/><!-- 도서 -->(<fmt:formatNumber value="${empty bookReCnt ? bookCnt : bookReCnt}" pattern="#,###" />)</a></li>
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'article'}">current</c:if>" data-tab="tab-3" id="totalSearchArticleTab"><a class="blue li_tit" href="#link" onclick="fn_filterSearch('article', '1'); return false;"><spring:message code="title.thesis"/><!-- 논문 -->(<fmt:formatNumber value="${empty articleReCnt ? articleCnt : articleReCnt}" pattern="#,###" />)</a></li>
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'course'}">current</c:if>" data-tab="tab-4" id="totalSearchCourseTab"><a class="blue li_tit"  href="#link" onclick="fn_filterSearch('course', '1'); return false;"><spring:message code="title.course"/><!-- 강의 -->(<fmt:formatNumber value="${empty courseReCnt ? courseCnt : courseReCnt}" pattern="#,###" />)</a></li>
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'media'}">current</c:if>" data-tab="tab-5" id="totalSearchMediaTab"><a class="blue li_tit" href="#link" onclick="fn_filterSearch('media', '1'); return false;"><spring:message code="title.etcData"/><!-- 기타자료 -->(<fmt:formatNumber value="${empty mediaReCnt ? mediaCnt : mediaReCnt}" pattern="#,###" />)</a></li>
                    <li class="tab-link <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'collection'}">current</c:if>" data-tab="tab-6" id="totalSearchLikeSnuTab"><a class="blue li_tit" href="#link" onclick="fn_filterSearch('collection', '1'); return false;"><spring:message code="lib.title.collections"/>(<fmt:formatNumber value="${empty collectionReCnt ? collectionCnt : collectionReCnt}" pattern="#,###" />)</a></li>
                </ul>
            </div>   
 
            <div id="tab-1" class="tab_content1 <c:if test="${searchMap.bExtendSearch ne 'true' || searchMap.tabName eq ''}">current</c:if>">
            
		       	<div class="sub_search_top_tit"> 
		                <span class="search_tit"><spring:message code="title.topic"/><!-- 주제 --></span>
		                <span class="search_tag" style="font-size: 20px; margin-top: 5px;">
		                	<div>
		                		<c:if test="${notFoundWords == false}">
				                	<c:forEach items="${topicResult}" varStatus="tStatus" var="topic">
				                		<c:if test="${ tStatus.index < 5 }">
				                			<span onclick="cfn_goToTopicMain('${topic.topic_id}'); return false;" style="cursor: pointer;" title='<c:out value="${SS_LOCALE ne 'en' ? topic.topic_label_kor : topic.topic_label_eng}"/>'>
				                				<c:if test="${fn:length(SS_LOCALE ne 'en' ? topic.topic_label_kor : topic.topic_label_eng) > 8}"><c:out value="#"/><c:out value="${fn:substring(SS_LOCALE ne 'en' ? topic.topic_label_kor : topic.topic_label_eng, 0, 8)}"/>…</c:if>
				                				<c:if test="${fn:length(SS_LOCALE ne 'en' ? topic.topic_label_kor : topic.topic_label_eng) < 8}"><c:out value="#"/><c:out value="${SS_LOCALE ne 'en' ? topic.topic_label_kor : topic.topic_label_eng}"/></c:if>
				                				<c:if test="${ tStatus.index != 5 }"></c:if>  
				                			</span>
				                		</c:if>
				                	</c:forEach>
			                	</c:if>
			                	<c:if test="${notFoundWords == true}">
			                		<span><spring:message code="info.noResult.msg" /></span>
			                	</c:if> 
		                	</div>
		                </span>
		                <div class="search_wrap2" style="top: 30px;">
		                    <button title="<spring:message code="buttion.universe.view"/>" onclick="cfn_goToLikeSnuMain(''); return false;"><i class="xi-search"></i><spring:message code="buttion.universe.view"/></button> <!-- 지식유니버스로 보기 -->
		                </div>
		        </div><!--sub_search_top_tit-->
                
                <div class="search_book_wrap">
                    <div class="sub_search_tit">
                        <span class="blue_bar"><spring:message code="title.book"/><!-- 도서 -->(<fmt:formatNumber value="${bookCnt}" pattern="#,###" />) </span>
                        <p class="total"><spring:message code="title.page"/><!-- 페이지 --> (<strong class="red">1</strong>/<fmt:formatNumber value="${bookTotalPage}" pattern="#,###" />)</p>
                        <a class="more_view totalSearchBookTab" href="#link" onclick="fn_filterSearch('book', '1'); return false;"><spring:message code="title.more"/></a>
                    </div><!--search_tit-->

                    <ul class="recommended_book_list">
                    	<c:if test="${!empty bookResult}">
	                    	<c:forEach var="book" items="${bookResult}" varStatus="bStatus">
	                    		<c:if test="${ bStatus.index < 10 }">
			                        <li>
			                            <p class="sub_book_liet_img sub_book_liet_img01"> 
			                              <a onclick="cfn_goToBookDetail('<c:out value="${book.mms_id}"/>')"> <c:if test="${!empty book.cover}"><img src='<c:out value="${book.cover}"/>'></c:if></a>
			                            </p>
			                            <div class="sub_book_list_txt">
			                                <h3> <a onclick="cfn_goToBookDetail('<c:out value="${book.mms_id}"/>')"><c:out value="${book.title}"/></a></h3>
	 		                                <c:if test="${book.is_paper_book ne 'false' || book.is_ebook ne 'false'}"><!-- 여부 찾기 -->
					                            <c:choose>
						                           	<c:when test="${book.is_ebook eq 'false' and book.is_paper_book eq 'true'}">
						                           		<p><spring:message code="title.bookType.paper"/></p>
						                           	</c:when>
						                           	<c:when test="${book.is_paper_book eq 'false' and book.is_ebook eq 'true'}">
						                           		<p><spring:message code="title.bookType.ebook"/></p>
						                           	</c:when>				                               	
						                           	<c:otherwise>
						                           		<p><spring:message code="title.bookType.paper"/>/<spring:message code="title.bookType.ebook"/></p>
						                           	</c:otherwise>
					                           	</c:choose>
			                                </c:if>		                               
			                                <p><c:out value="${book.author}"/></p>
				                            <c:if test="${not empty book.ref_course_id && book.ref_course_id ne ''}">
				                            	<span class="green"><spring:message code="title.lectureMaterials" /></span><!-- 강의교재 -->
				                            </c:if>
			                                <span class="year2"><c:out value="${book.publication_date}"/><spring:message code="title.year"/><!-- 년(도) --><c:out value=" / ${book.publisher}" /></span>
			                                <div class="tag_box">
			                                	<c:forEach var="bookTopic" items="${SS_LOCALE ne 'en' ? book.topic_nm_kor : book.topic_nm_eng}" varStatus="btStatus">
			                                    	<c:if test="${btStatus.index < 3}">
			                                    		<a href="#" onclick="cfn_goToTopicMain('${book.topic[btStatus.index]}'); return false;">
			                                    			<span class="tag"><c:out value="#" /><c:out value="${bookTopic}"/></span>
			                                    		</a>
			                                    	</c:if>
			                                    </c:forEach>
			                                </div>
				                            <ul class="share_box">
				                                <button title="<spring:message code="title.share" />" class="mr_30" id="bookColl1_${bStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/book/bookDetail.do?mms_id='/><c:out value='${book.mms_id}'/>" onclick="cfn_shareContents('bookColl1_${bStatus.index}');"><i class="xi-share-alt-o"></i></button>   
												<button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button>                                
												<ul class="more_view_drop1"><!-- 순서대로 컬렉션에 담기 / 이미 읽음 / 관심 없음 / 대출하기 / 알라딘에서 보기 -->
					                                <li><a href="#" onclick="cfn_popUpAddCollection('book', '${book.mms_id}'); fn_eventLogInsert('search_total','book','${book.mms_id}','collection_btn'); return false;" class="basket"><spring:message code="title.add.collection" /></a></li>   
													<li><a href="#" class="read" onclick="cfn_alreadyRead('book', '${book.mms_id}'); fn_eventLogInsert('search_total','book','${book.mms_id}','read_btn'); return false;"><spring:message code="title.already.read" /></a></li>
													<li><a href="#" class="not_interested" onclick="cfn_ignore('book', '${book.mms_id}');return false;"><spring:message code="title.not.interested" /></a></li>
													<li><a href="#" class="loan" onclick="cfn_goToLoan('${book.doc_id}'); fn_eventLogInsert('search_total','book','${book.mms_id}','loan_btn'); return false;"><spring:message code="title.take.loan" /></a></li>
				                                </ul>
											</ul>	
			                            </div>
			                        </li>
		                        </c:if>
							</c:forEach>
						</c:if>
						<c:if test="${empty bookResult}">
							<div class="no_info" style="border: none;">
								<p><spring:message code="info.noResult.msg"/></p>
								<button type="button">
									<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="<spring:message code="title.request.book.hope" />">
										<spring:message code="title.request.book.hope" />
									</a>
								</button>
							</div>	
						</c:if>							
                    </ul><!--recommended_book_list-->
                
                </div><!--search_book_wrap-->

				<!-- 통합검색 결과 논문 부분 -->
                <div class="thesis_wrap">
                	<div class="sub_search_tit ">
                        <span class="blue_bar"><spring:message code="title.thesis"/><!-- 논문 -->(<fmt:formatNumber value="${articleCnt}" pattern="#,###" />)</span>
                        <p class="total"><spring:message code="title.page"/><!-- 페이지 --> (<strong class="red">1</strong>/<fmt:formatNumber value="${articleTotalPage}" pattern="#,###" />)</p>
                        <a class="more_view totalSearchArticleTab" href="#link" onclick="fn_filterSearch('article', '1'); return false;"><spring:message code="title.more"/></a>
                    </div><!-- search_tit -->

                    <ul class="recommended_book_list">
                    	<c:if test="${!empty articleResult}">
	                    	<c:forEach var="article" items="${articleResult}" varStatus="aStatus">
	                    		<c:if test="${ aStatus.index < 10 }">
			                        <li>
			                            <div class="sub_book_list_txt">
			                                <h3>
			                                	<a href="#" onclick="cfn_goToArticleDetail('${article.article_id}');return false;">
			                                		<c:out value="${article.article_title}"/>
			                                	</a>
			                                </h3>
			                                <p><c:if test="${!empty article.publisher_name}"><c:out value="${article.publisher_name}"/> / </c:if><c:out value="${article.all_authors_name}"/></p>
			                                <span class="year2"><c:out value="${article.journal_name}"/>, <c:out value="${article.publication_year}"/></span>
			                                <div class="tag_box">
			                                	<c:forEach var="articleTopic" items="${SS_LOCALE ne 'en' ? article.topic_nm_kor : article.topic_nm_eng}" varStatus="atStatus">
			                                    	<c:if test="${atStatus.index < 3}">
			                                    		<a href="#" onclick="cfn_goToTopicMain('${article.topic[atStatus.index]}'); return false;">
				                                    		<span class="tag"><c:out value="#"/><c:out value="${articleTopic}"/></span>
				                                    	</a>
			                                    	</c:if>
			                                    </c:forEach>
			                                </div>
			                                <ul class="share_box">
			                                	<!-- 공유 -->
			                                    <button title="<spring:message code="title.share"/>" class="mr_30" id="articleColl1_${aStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/article/articleDetail.do?article_id='/><c:out value='${article.article_id}'/>" onclick="cfn_shareContents('articleColl1_${aStatus.index}');"><i class="xi-share-alt-o"></i></button>
			                                    <!-- 더보기 -->
			                                    <button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button>                                
			                                    <ul class="more_view_drop1">
			                                    	<li><a href="#" class="pdf" onclick="fn_getPDF('${article.doi}'); return false;"><c:out value="Get PDF" /></a></li>
				                                    <li><a href="#" class="basket" onclick="cfn_popUpAddCollection('article', '${article.article_id}'); fn_eventLogInsert('search_total','article','${article.article_id}','collection_btn'); return false;"><spring:message code="title.add.collection" /></a></li>
				                                    <li><a href="#" class="read" onclick="cfn_alreadyRead('article', '${article.article_id}'); fn_eventLogInsert('search_total','article','${article.article_id}','read_btn'); return false;"><spring:message code="title.already.read" /></a></li>
				                                    <li><a href="#" class="not_interested" onclick="cfn_ignore('article', '${article.article_id}');return false;"><spring:message code="title.not.interested" /></a></li>
													<c:choose>
														<c:when test="${!empty article.doi}">
															<li><a href="https://doi.org/${article.doi}" class="aladdin" target="_blank" onclick="fn_eventLogInsert('search_total','article','${article.article_id}','source_btn');"><spring:message code="title.view.paper" /></a></li>
														</c:when>
														<c:when test="${empty article.doi}">
															<li><a href="#" class="aladdin" onclick="cfn_alertToast('<spring:message code="common.noSource.msg" />'); fn_eventLogInsert('search_total','article','${article.article_id}','source_btn');"><spring:message code="title.view.paper" /></a></li>
														</c:when>
													</c:choose>
			                                    </ul>
			                            	</ul>
			                            </div>
			                        </li>
		                        </c:if>
	                        </c:forEach>
                        </c:if>
						<c:if test="${empty articleResult}">
							<div class="no_info" style="border: none;">
								<p><spring:message code="info.noResult.msg"/></p>
							</div>	
						</c:if>	                        
                    </ul><!-- recommended_book_list -->
                </div><!-- thesis_wrap -->
                
                <div class="class_wrap tab3-class">
                    <div class="sub_search_tit ">
                        <span class="blue_bar"><spring:message code="title.course"/>(<fmt:formatNumber value="${courseCnt}" pattern="#,###" />)</span> <!-- 강의 -->
                        <p class="total"><spring:message code="title.page"/> (<strong class="red">1</strong>/<fmt:formatNumber value="${courseTotalPage}" pattern="#,###" />)</p> <!-- 페이지 표시 -->
                        <a class="more_view totalSearchCourseTab" href="#link" onclick="fn_filterSearch('course', '1'); return false;"><spring:message code="title.more"/></a> <!-- 더보기 -->
                    </div><!--search_tit-->

                    <ul class="recommended_book_list">
                    	<c:if test="${!empty courseResult}">
	                    	<c:forEach var="course" items="${courseResult}" varStatus="cStatus">
	                    		<c:set var="courseYear" value="${fn:substring(course.reg_dt, 0, 4)}"/>
	                    		<c:if test="${ cStatus.index < 10 }">
			                        <li>
			                            <div class="sub_book_list_txt">
											<h3>
												<c:choose>
							 	                	<c:when test="${SS_LOCALE ne 'en'}">
														<a href="#" onclick="cfn_goToCourseDetail('${course.course_cd}'); return false;">
															<c:out value="${course.course_nm}" /> <!-- 한글 강의명 --> 
														</a>					 	                	
							 	                	</c:when>
							 	                	<c:otherwise>
														<a href="#" onclick="cfn_goToCourseDetail('${course.course_cd}'); return false;">
															<c:out value="${course.course_eng_nm}" /> <!-- 영문 강의명 --> 
														</a>					 	                	
							 	                	</c:otherwise>
							 	                </c:choose>
											</h3>		      
											<span class="year2" style="background: none; border: none;"></span>
											<span class="green red_bg" style="margin-top: 0px;">
												<c:choose>
							 	                	<c:when test="${SS_LOCALE ne 'en'}">
														<c:out value="${course.estbl_coll_kor_nm}" />				 	                	
							 	                	</c:when>
							 	                	<c:otherwise>
														<c:out value="${course.estbl_coll_eng_nm}" />					 	                	
							 	                	</c:otherwise>
							 	                </c:choose>		
											</span>
											<c:if test="${not empty course.estbl_curiclm_type_nm || not empty course.estbl_course_type_nm}">
												<p>
													<c:if test="${not empty course.estbl_curiclm_type_nm}">
														<c:out value="${course.estbl_curiclm_type_nm}" />
													</c:if>
													<c:if test="${not empty course.estbl_course_type_nm}">
													/ <c:out value="${course.estbl_course_type_nm}" />
													</c:if>
												</p>
											</c:if>	
				                            <span class="book_list_txt1" style="display: flex;">
											<c:choose>
								 	            	<c:when test="${SS_LOCALE ne 'en'}">
														<c:if test="${!empty course.course_summary_cn}"><c:out value="${fn:substring(course.course_summary_cn, 0, 100)}" escapeXml="false" />…</c:if>	
								 	            	</c:when>
								 	            	<c:otherwise>
														<c:if test="${!empty course.course_summary_eng_cn}"><c:out value="${fn:substring(course.course_summary_eng_cn, 0, 100)}" escapeXml="false" />…</c:if>               	
								 	            	</c:otherwise>
								 	            </c:choose>				                     
				                            </span>
				                            <div class="tag_box">
												<c:forEach items="${SS_LOCALE ne 'en' ? course.topic_nm_kor : course.topic_nm_eng}" var="courseTopic" varStatus="ctStatus">
													<c:if test="${ctStatus.index < 3}">
														<a href="#" onclick="cfn_goToTopicMain('${course.topic[ctStatus.index]}'); return false;">
															<span class="tag">
																<c:out value="#" /><c:out value="${courseTopic}" />
															</span>
														</a>
													</c:if>
												</c:forEach>
			                            	</div>
			                                <ul class="share_box"><!-- 순서대로 공유하기 / 더보기 / 컬렉션에 담기 / 관심 없음 -->
			                                    <button title="<spring:message code="title.share" />" class="mr_30" id="courseColl2_${cStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/course/courseDetail.do?course_cd='/><c:out value='${course.course_cd}'/>" onclick="cfn_shareContents('courseColl2_${cStatus.index}');"><i class="xi-share-alt-o"></i></button>
												<button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button>
												<ul class="more_view_drop1">
													<li><a href="#" onclick="cfn_popUpAddCollection('course', '${course.course_cd}'); fn_eventLogInsert('search_total','course','${course.course_cd}','collection_btn'); return false;" class="basket"><spring:message code="title.add.collection" /></a></li>
													<li><a href="link" class="not_interested" onclick="cfn_ignore('course', '${course.course_cd}');return false;"><spring:message code="title.not.interested" /></a></li>
												</ul>		                                
			                                </ul>
			                            </div>
			                        </li>
		                        </c:if>
							</c:forEach>
						</c:if>
						<c:if test="${empty courseResult}">
							<div class="no_info" style="border: none;">
								<p><spring:message code="info.noResult.msg"/></p>
							</div>	
						</c:if>							
                    </ul><!--recommended_book_list-->
                </div><!--class_wrap-->

                <div class="tab3-class other_resources">
                    <div class="sub_search_tit ">
                        <span class="blue_bar"><spring:message code="title.etcMedia"/>(<fmt:formatNumber value="${mediaCnt}" pattern="#,###" />)</span>
                        <p class="total"><spring:message code="title.page"/><!-- 페이지 --> (<strong class="red">1</strong>/<fmt:formatNumber value="${mediaTotalPage}" pattern="#,###" />)</p>
                        <a class="more_view totalSearchMediaTab" href="#link" onclick="fn_filterSearch('media', '1'); return false;"><spring:message code="title.more"/></a>
                    </div><!-- search_tit -->

                    <ul class="recommended_book_list">
                    	<c:if test="${!empty mediaResult}">
	                    	<c:forEach var="media" items="${mediaResult}" varStatus="mStatus">
	                    		<c:if test="${ mStatus.index < 3 }">
		                        	<li>
			                            <div class="sub_book_list_txt">
			                                <h3><span><a href="https://snu-primo.hosted.exlibrisgroup.com/permalink/f/177n5ka/82SNU_INST${media.doc_id}" target="_blank" ><c:out value="${media.title}"/></a></span></h3>
			                                <c:if test="${media.local_param_04 != null || media.local_param_06 != null}">
			                                	<c:choose>
			                                		<c:when test="${media.local_param_04 != null}"><span class="book_list_txt1 ellipsis"><c:out value="${fn:substring(media.local_param_04, 0, 100)}"/>…</span></c:when>
			                                		<c:otherwise><span class="book_list_txt1 ellipsis"><c:out value="${fn:substring(media.local_param_06, 0, 100)}"/>…</span></c:otherwise>
			                                	</c:choose>
			                                </c:if>
				                            <c:if test="${media.author != null || media.publisher != null}">
					                            <c:choose>
							                        <c:when test="${media.author != null and media.publisher == null}">
							                        	 <p>
							                        	 	<c:out value="${media.author}"/>
							                        	 </p>
							                        </c:when>
							                        <c:when test="${media.author != null and media.publisher != null}">
							                        	<p><c:out value="${media.author}"/><span class="txt_line"><c:out value="${media.publisher}"/></span></p>
							                        </c:when>				                                	
							                        <c:otherwise>
							                        	<p><c:out value="${media.publisher}"/></p>
							                        </c:otherwise>
					                            </c:choose>
				                            </c:if>
			                                <c:if test="${media.publication_date != null}">
			                                	<span class="year2"><c:out value="${media.publication_date}"/><spring:message code="title.year"/></span>
			                                </c:if>
			                            </div>
		                        	</li>
	                        	</c:if>                       	
	                        </c:forEach>
                        </c:if>
						<c:if test="${empty mediaResult}">
							<div class="no_info" style="border: none;">
								<p><spring:message code="info.noResult.msg"/></p>
								<button type="button">
									<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="<spring:message code="title.request.book.hope" />">
										<spring:message code="title.request.book.hope" />
									</a>
								</button>								
							</div>	
						</c:if>	                         
                    </ul><!-- recommended_book_list -->
                </div><!-- other_resources -->
                
				<!-- 통합검색 결과 컬렉션 부분 -->
                <div class="tab3-class LikeSNU_collec">
                    <div class="sub_search_tit ">
                        <span class="blue_bar"><spring:message code="title.collection"/>(<fmt:formatNumber value="${collectionCnt}" pattern="#,###" />)</span>
                        <p class="total"><spring:message code="title.page"/><!-- 페이지 --> (<strong class="red">1</strong>/<fmt:formatNumber value="${collectionTotalPage}" pattern="#,###" />)</p>
                        <a class="more_view totalSearchLikeSnuTab" href="#link" onclick="fn_filterSearch('collection', '1'); return false;"><spring:message code="title.more"/></a>
                    </div><!-- search_tit -->

                    <div class="sub_card_box ml_20_mn box_h ">
                    	<c:if test="${!empty collectionResult}">
	                    	<c:forEach var="collection" items="${collectionResult}" varStatus="collStatus">
	                    		<c:if test="${collStatus.index < 9}">
			                        <div class="card_box left_card_box">
			                            <h2>
			                            	<a href="#" onclick="cfn_goToCollectionDetail('${collection.collection_id}');return false;">
			                            		<c:out value="${collection.collection_title}"/>
			                            	</a>
			                            </h2>
										<p></p>
			                            <div class="tag_box">
		                                	<c:forEach var="collectionTopic" items="${SS_LOCALE ne 'en' ? collection.topic_name_kor : collection.topic_name_eng}" varStatus="colltStatus">
		                                    	<c:if test="${colltStatus.index < 3}">
		                                    		<a href="#" onclick="cfn_goToTopicMain('${collection.topic[colltStatus.index]}'); return false;">
			                                    		<span class="tag"><c:out value="#" /><c:out value="${collectionTopic}"/></span>
			                                    	</a>
		                                    	</c:if>
		                                    </c:forEach>
			                            </div>                           
			                        </div>
		                        </c:if>
	                        </c:forEach>
                        </c:if>
						<c:if test="${empty collectionResult}">
							<div class="no_info" style="border: none;">
								<p><spring:message code="info.noResult.msg"/></p>
							</div>	
						</c:if>	                        
                    </div><!-- sub_card_box -->
                </div><!-- LikeSNU_collec -->
                
            </div><!-- tab_content1 -->

			<!-- 여기서부터는 탭으로 조회하는 목록! -->
            <!-- 도서탭 -->
            
            <div id="tab-2" class="tab_content1 <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'book'}">current</c:if>">
				<c:choose>
					<c:when test="${SS_LOCALE ne 'en'}">
						<c:set var="title" value="도서" />					 	                	
					</c:when>
					<c:otherwise>
						<c:set var="title" value="Book" />					 	                	
					</c:otherwise>
				</c:choose>	            
                <div class="sub-search-book">
	                <div class="search_book_wrap">
	                    <div class="sub_search_tit">
	                    	<fmt:formatNumber var="commaBookCnt" value="${empty bookReCnt ? bookCnt : bookReCnt}" pattern="#,###" />
	                        <p class="sub_top_tit1">
	                        	<c:out value="'" />${searchMap.searchKeyword}<c:out value="'" /><spring:message code="info.result.msg" /> <span class="red">${title}</span> <spring:message code="info.result.msg2" /> <span class="red">${commaBookCnt}</span><spring:message code="info.result.msg1" />
	                        </p>
	                        <span class="blue_bar"><spring:message code="title.book"/><!-- 도서 -->(<fmt:formatNumber value="${empty bookReCnt ? bookCnt : bookReCnt}" pattern="#,###" />)</span>
	                    </div>
	                        <!-- <a class="more_view" href="#link">더보기</a> -->
                            <div class="page_count mt_15"><spring:message code="title.page"/><!-- 페이지 --> (<em class="f_c_r" id="currPageEmBook">1</em>/<fmt:formatNumber value="${empty bookReTotalPage ? bookTotalPage : bookReTotalPage}" pattern="#,###" />)
                                <div class="tit_btnareaR">
                                	<button type="button" class="Btn btn-success" onclick="fn_popUpMultiAddCollection('book'); return false;"><spring:message code="title.add.collection"/><!-- LikeSNU 컬렉션에 담기 --><i class="xi-plus"></i></button>
                                    <button type="button" class="Btn btn-success" onclick="exportExcel('book');"><spring:message code="button.content.export"/><!-- 엑셀 내보내기 --><i class="xi-share"></i></button>  
                                    <select name="pagingSizeBookSelect" id="pagingSizeBookSelect" class="recommended_sel1 W70" title="페이지 수 선택">
                                       <option value="10" <c:if test="${paginationInfo.recordCountPerPage eq 10}">selected="selected"</c:if>>10<spring:message code="title.count"/></option>
                                       <option value="50" <c:if test="${paginationInfo.recordCountPerPage eq 50}">selected="selected"</c:if>>50<spring:message code="title.count"/></option>
                                       <option value="100" <c:if test="${paginationInfo.recordCountPerPage eq 100}">selected="selected"</c:if>>100<spring:message code="title.count"/></option>
                                   </select>
                              	</div>	
                           	</div>                        
	                    </div><!--search_tit-->
	                    
	                    <div class="search_filter">
	                        <p class="filter_tit"><spring:message code="title.search.result"/><spring:message code="title.filter"/><!-- 검색결과 필터 --></p>
	                        <div class="search_filter_box">
	                            <h3><spring:message code="title.order"/></h3> <!-- 정렬 -->
	                            <select name="searchBookOrder" id="searchBookOrder" class="recommended_sel1" title="<spring:message code="title.order"/>" onchange="fn_filterSearch('book', '1');">
	                                <option value="title"><spring:message code="title.relation"/></option> <!-- 관련도순 -->
	                                <option value="publication_date" <c:if test="${searchMap.orderField eq 'publication_date'}">selected="selected"</c:if> ><spring:message code="title.recent"/></option> <!-- 최신순 -->
	                            </select>
	                            <h3><spring:message code="title.search.re"/></h3> <!-- 결과 내 재검색 -->
	                            <a href="#none" class="filter_o filter_btn"><button style="background: #183989; color: white;" onclick="fn_filterSearch('book', '1');"><spring:message code="button.filter"/><!-- 필터적용 --></button></a>
	                            <a href="#none" class="reset_btn filter_btn"><button onclick="fn_filterReset('book');"><spring:message code="button.init"/><!-- 초기화 --></button></a>
	                            <h3><spring:message code="title.pubYear"/></h3> <!-- 기간 -->
	                            <label for="searchBookStdDate" class="skip"><spring:message code="title.startYear"/></label> <!-- 시작년도 -->
	                            <input type="text" name="searchBookStdDate" id="searchBookStdDate" value="${searchBookReMap.startdate}" class="datePicker form-control" placeholder="<spring:message code="title.startYear"/>" placeholder="<spring:message code="title.startYear"/>">
	                            <label for="searchBookEndDate" class="skip"><spring:message code="title.endYear"/></label> <!-- 종료년도 -->
	                            <input type="text" name="searchBookEndDate" id="searchBookEndDate" value="${searchBookReMap.enddate}" class="datePicker form-control" title="<spring:message code="title.endYear"/>" placeholder="<spring:message code="title.endYear"/>">
	                            <input type="hidden" name="range" value="000000000021">
	                            <h3><spring:message code="table.sj"/></h3> <!-- 제목 -->
	                            <input type="text" name="searchBookTitle" id="searchBookTitle" value="${searchBookReMap.searchBookTitle}" class="form-control" title="<spring:message code="table.sj"/>" placeholder="<spring:message code="table.sj"/>">
	                            <h3><spring:message code="title.author"/></h3> <!-- 저자 -->
	                            <input type="text" name="searchBookAuthor" id="searchBookAuthor" value="${searchBookReMap.searchBookAuthor}" class="form-control" title="<spring:message code="title.author"/>" placeholder="<spring:message code="title.author"/>">
 	                            <h3><spring:message code="title.dataType"/></h3> <!-- 자료유형 -->
	                            <ul class="work_type">
		                        	<c:forEach var="bookAggs" items="${empty bookReAggsResult ? bookAggsResult : bookReAggsResult}" begin="0" varStatus="baStatus">
	 	                          		<c:if test="${baStatus.index == 0}">
		 	                        		<li>
			                            		<input type="checkbox" name="searchBookTypeCheck" id="is_paper_book" value="is_paper_book" <c:if test="${searchBookReMap.is_paper_book == true}">checked="checked"</c:if>>
			                            		<label for="is_paper_book"><strong><spring:message code="title.bookType.paper"/><!-- 종이책/단행본 --> (<c:out value="${bookAggs.is_paper_book[0].is_paper_book}"/>)</strong></label>
			                        		</li>
		                        		</c:if>
	 	                          		<c:if test="${baStatus.index == 1}">
		 	                        		<li>
			                            		<input type="checkbox" name="searchBookTypeCheck" id="is_ebook" value="is_ebook" <c:if test="${searchBookReMap.is_ebook == true}">checked="checked"</c:if>>
			                            		<label for="is_ebook"><strong><spring:message code="title.bookType.ebook"/><!-- 종이책/단행본 --> (<c:out value="${bookAggs.is_ebook[0].is_ebook}"/>)</strong></label>
			                        		</li>
		                        		</c:if>		                        		
		                        	</c:forEach>
		                        </ul>  
 	                            <h3><spring:message code="title.topic"/></h3> <!-- 주제 --> 
	                            <div class="work_type_box">
	                                <ul class="work_type work_type2">
	                                <!-- 왜 forEach를 3번하게 됐냐면… 패싯 이름 > 패싯 안의 내용 > 또 리스트 안의 맵… 이렇게 되어 있어서입니다. bookAggsIn[0]으로도 안 불러지더라고요. -->
	                                <!-- 확인하고, 또 이해하셨으면 이 부분 지워주시면 됩니다~ -->
			                        	<c:forEach var="bookAggs" items="${empty bookReAggsResult ? bookAggsResult : bookReAggsResult}" begin="0" varStatus="baStatus">
		 	                          		<c:if test="${baStatus.index > 1}">
				 	                          	<c:choose>
					 	                          	<c:when test="${SS_LOCALE ne 'en'}">
								 	                    <c:if test="${baStatus.index == 2}">
								 	                    	<c:forEach var="bookAggsIn" items="${bookAggs.first_topic_nm_kor}">
								 	                    		<c:forEach var="bookAggsInFinal" items="${bookAggsIn}" begin="0" varStatus="baInStatus">
												 	                <li>
													                   	<input type="checkbox" name="searchBookKorSubjectCheck" class="searchBookKorSubjectCheck" id="${bookAggsInFinal.key}" value="${bookAggsInFinal.key}" <c:if test="${fn:contains(searchBookReMap.searchBookKorSubjectCheck, bookAggsInFinal.key)}">checked="checked"</c:if>>
													                   	<label for="${bookAggsInFinal.key}"><strong><c:out value="${bookAggsInFinal.key}"/> (<c:out value="${bookAggsInFinal.value}"/>)</strong></label>
													                </li>
										                   		</c:forEach>
										                   	</c:forEach>		
									                    </c:if>                
					 	                          	</c:when>
					 	                          	<c:otherwise>
					 	                          		<c:if test="${baStatus.index == 3}">
					 	                          			<c:forEach var="bookAggsIn" items="${bookAggs.first_topic_nm_eng}">
							 	                    			<c:forEach var="bookAggsInFinal" items="${bookAggsIn}" begin="0" varStatus="baInStatus">
										 	                    	<li>
											                        	<input type="checkbox" name="searchBookEngSubjectCheck" class="searchBookEngSubjectCheck" id="${bookAggsInFinal.key}" value="${bookAggsInFinal.key}" <c:if test="${fn:contains(searchBookReMap.searchBookEngSubjectCheck, bookAggsInFinal.key)}">checked="checked"</c:if>>
											                        	<label for="${bookAggsInFinal.key}"><strong><c:out value="${bookAggsInFinal.key}"/> (<c:out value="${bookAggsInFinal.value}"/>)</strong></label>
											                    	</li>
									                    		</c:forEach>
									                    	</c:forEach>			 	                          				
					 	                          		</c:if>
					 	                          	</c:otherwise>
				 	                          	</c:choose> 
			                        		</c:if>	   
			                        	</c:forEach>      
	                                </ul>
	                            </div> <!--work_type_box-->
	                        </div><!--search_filter_box-->
	                    </div><!--search_filter-->
						
						<c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'book'}">
	                    <ul class="recommended_book_list">
	                    	<div class="recommended_book ml_20_mn">
	                    		<div class="top_recommended_book">
									<ul>
    									<li class="ch_nAll">
    										<!-- 체크 박스 전체! -->
                                        	<input type="checkbox" id="ar_ch1all" class="ml_10" onclick="fn_allCheck(this);">
                                    	</li>
										<li>
	                                        <p class="blue_arrow">
	                                        	<span></span>
	                                        	<spring:message code="title.book"/>
	                                        </p>
                                        </li>
                                	</ul>
                        		</div> <!--top_recommended_book-->	                    	
	                    	</div>
	                    	
							<c:forEach var="book" items="${bookReResult}" begin="0" varStatus="bStatus">
		                        <li class="showPagingLi">
									<div class="ch_n"> 
		                                <input type="checkbox" id="${book.mms_id}" class="ml_5 contentsCheckBox"> 
			                            <input type="hidden" class="excelData" data-conid="<c:out value='${book.mms_id}'/>" data-title="<c:out value='${book.title}'/>" data-author="<c:out value='${book.author}'/>" data-pubdate="<c:out value='${book.publication_date}'/>">
		                            </div>
			                            
		                            <!-- 상단 input은 엑셀 다운로드 -->
		                            <a onclick="cfn_goToBookDetail('<c:out value="${book.mms_id}"/>')"><p class="sub_book_liet_img sub_book_liet_img01"><c:if test="${!empty book.cover}"><img src='<c:out value="${book.cover}"/>'></c:if></p></a>
		                            <div class="sub_book_list_txt">
		                                <h3><a onclick="cfn_goToBookDetail('<c:out value="${book.mms_id}"/>')"><c:out value="${book.title}"/></a></h3>
		                                <c:if test="${book.is_paper_book ne 'false' || book.is_ebook ne 'false'}"><!-- 여부 찾기 -->
			                               	<c:choose>
			                               		<c:when test="${book.is_ebook eq 'false' and book.is_paper_book eq 'true'}">
				                               		<p><spring:message code="title.bookType.paper"/></p>
				                               	</c:when>
				                               	<c:when test="${book.is_paper_book eq 'false' and book.is_ebook eq 'true'}">
				                               		<p><spring:message code="title.bookType.ebook"/></p>
				                               	</c:when>				                               	
				                               	<c:otherwise>
				                               		<p><spring:message code="title.bookType.paper"/>/<spring:message code="title.bookType.ebook"/></p>
				                               	</c:otherwise>
			                           		</c:choose>
		                                </c:if>				                                
		                                <p><c:out value="${book.author}"/></p>
		                                <c:if test="${not empty book.ref_course_id && book.ref_course_id ne ''}">
		                                	<span class="green"><spring:message code="title.lectureMaterials" /></span><!-- 강의교재 -->
		                                </c:if>
		                                <span class="year2"><c:out value="${book.publication_date}"/><spring:message code="title.year"/><!-- 년(도) --><c:out value=" / ${book.publisher}" /></span>
		                                <span class="book_list_txt1 ellipsis">
		                                	<c:if test="${!empty book.description}">${fn:substring(book.description, 0, 100)}…</c:if>
		                                </span>                  
		                                <div class="tag_box">
	                                		<c:forEach var="bookTopic" items="${SS_LOCALE ne 'en' ? book.topic_nm_kor : book.topic_nm_eng}" varStatus="btStatus">
		                                    	<c:if test="${btStatus.index < 3}">
		                                    		<a href="#" onclick="cfn_goToTopicMain('${book.topic[btStatus.index]}'); return false;">
		                                    			<span class="tag"><c:out value="#" /><c:out value="${bookTopic}"/></span>
		                                    		</a>
		                                    	</c:if>
	                                    	</c:forEach>
		                                </div>
			                            <ul class="share_box">
			                                <button title="<spring:message code="title.share" />" class="mr_30" id="bookColl2_${bStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/book/bookDetail.do?mms_id='/><c:out value='${book.mms_id}'/>" onclick="cfn_shareContents('bookColl2_${bStatus.index}');"><i class="xi-share-alt-o"></i></button> 
											<button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button> <!-- 더보기 -->                               
											<ul class="more_view_drop1"><!-- 순서대로 컬렉션에 담기 / 이미 읽음 / 관심 없음 / 대출하기 / 알라딘에서 보기 -->
				                                <li><a href="#" onclick="cfn_popUpAddCollection('book', '${book.mms_id}'); fn_eventLogInsert('search_book','book','${book.mms_id}','collection_btn'); return false;" class="basket"><spring:message code="title.add.collection" /></a></li>   
												<li><a href="#" class="read" onclick="cfn_alreadyRead('book', '${book.mms_id}'); fn_eventLogInsert('search_book','book','${book.mms_id}','read_btn'); return false;"><spring:message code="title.already.read" /></a></li>
												<li><a href="#" class="not_interested" onclick="cfn_ignore('book', '${book.mms_id}'); return false;"><spring:message code="title.not.interested" /></a></li>
												<li><a href="#" class="loan" onclick="cfn_goToLoan('${book.doc_id}'); fn_eventLogInsert('search_book','book','${book.mms_id}','loan_btn'); return false;"><spring:message code="title.take.loan" /></a></li>
			                                </ul>
										</ul>	   
		                            </div>
		                        </li>
							</c:forEach>
							<c:if test="${empty bookReResult}">
								<div class="no_info" style="border: none;">
									<p><spring:message code="info.noResult.msg"/></p>
									<button type="button">
										<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="<spring:message code="title.request.book.hope" />">
											<spring:message code="title.request.book.hope" />
										</a>
									</button>
								</div>		
							</c:if>		
			             	<!-- 페이징 -->
			                <c:if test="${!empty bookReResult}">
								<!-- 페이징 -->
								<div id="paging_div" class="paging_normal">
									<ul class="pagination paging_align"> 
										<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_pageMove" type="image" />
									</ul>
								</div>
			                </c:if>												
	                    </ul><!--recommended_book_list-->
	                    </c:if>
	                </div>
                </div>           
            <!-- 도서탭끝 -->
            
            <!--tab_content1-->
            <!-- 논문탭 -->
            <div id="tab-3" class="tab_content1 tab3-class2 <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'article'}">current</c:if>">
                <div class="sub-search-book">
                	<div class="search_book_wrap">
						<c:choose>
							<c:when test="${SS_LOCALE ne 'en'}">
								<c:set var="title" value="논문" />					 	                	
							</c:when>
							<c:otherwise>
								<c:set var="title" value="Article" />					 	                	
							</c:otherwise>
						</c:choose>	              
	                    <div class="sub_search_tit">           
	                    	<fmt:formatNumber var="commaArticleCnt" value="${empty articleReCnt ? articleCnt : articleReCnt}" pattern="#,###" /> 
	                        <p class="sub_top_tit1">
	                        	<c:out value="'" />${searchMap.searchKeyword}<c:out value="'" /><spring:message code="info.result.msg" /> <span class="red">${title}</span> <spring:message code="info.result.msg2" /> <span class="red">${commaArticleCnt}</span><spring:message code="info.result.msg1" />
	                        </p>
	                        <span class="blue_bar"><spring:message code="title.thesis"/><!-- 논문 -->(<fmt:formatNumber value="${empty articleReCnt ? articleCnt : articleReCnt}" pattern="#,###" />)</span>
	                    </div>
	                    <!-- <a class="more_view" href="#link">더보기</a> -->
                        <div class="page_count mt_15"><spring:message code="title.page"/><!-- 페이지 --> (<em class="f_c_r" id="currPageEmBook">1</em>/<fmt:formatNumber value="${empty articleReTotalPage ? articleTotalPage : articleReTotalPage}" pattern="#,###" />)
                            <div class="tit_btnareaR"> 
                            	<button type="button" class="Btn btn-success" onclick="fn_popUpMultiAddCollection('article'); return false;"><spring:message code="title.add.collection"/><!-- LikeSNU 컬렉션에 담기 --><i class="xi-plus"></i></button>
                                <button type="button" class="Btn btn-success" onclick="exportExcel('article');"><spring:message code="button.content.export"/><!-- 엑셀 내보내기 --><i class="xi-share"></i></button>  
                                <select name="pagingSizeArticleSelect" id="pagingSizeArticleSelect" class="recommended_sel1 W70" title="페이지 수 선택">
                                   <option value="10" <c:if test="${paginationInfo.recordCountPerPage eq 10}">selected="selected"</c:if>>10<spring:message code="title.count"/></option>
                                   <option value="50" <c:if test="${paginationInfo.recordCountPerPage eq 50}">selected="selected"</c:if>>50<spring:message code="title.count"/></option>
                                   <option value="100" <c:if test="${paginationInfo.recordCountPerPage eq 100}">selected="selected"</c:if>>100<spring:message code="title.count"/></option>
                               </select>
                          	</div>	
                        </div>                        
	           		</div><!--search_tit-->			
	                    
                    <!-- 논문 탭 검색결과 필터부분 search_filter-->
                    <div class="search_filter">
                        <p class="filter_tit"><spring:message code="title.search.result"/><spring:message code="title.filter"/><!-- 검색결과 필터 --></p>
                        <div class="search_filter_box"> 
                            <h3><spring:message code="title.order"/></h3> <!-- 정렬 -->
                            <select name="searchArticleOrder" id="searchArticleOrder" class="recommended_sel1" title="<spring:message code="title.order"/>" onchange="fn_filterSearch('article', '1');">
                                <option value="article_title" <c:if test="${(searchMap.orderField eq 'article_title') or (searchMap.orderField eq '')}">selected="selected"</c:if> ><spring:message code="title.relation"/></option> <!-- 관련도순 -->
                                <option value="citation_count_scopus" <c:if test="${searchMap.orderField eq 'citation_count_scopus'}">selected="selected"</c:if> ><spring:message code="title.scopus"/></option> <!-- 피인용순 -->
                                <option value="publication_year" <c:if test="${searchMap.orderField eq 'publication_year'}">selected="selected"</c:if> ><spring:message code="title.recent"/></option> <!-- 최신순 -->
                            </select>
                            <h3><spring:message code="title.search.re"/></h3> <!-- 결과 내 재검색 -->
                            <a href="#none" class="filter_o filter_btn"><button style="background: #183989; color: white;" onclick="fn_filterSearch('article', '1');"><spring:message code="button.filter"/><!-- 필터적용 --></button></a>
                            <a href="#none" class="reset_btn filter_btn"><button onclick="fn_filterReset('article');"><spring:message code="button.init"/><!-- 초기화 --></button></a>
                            <h3><spring:message code="title.pubYear"/></h3> <!-- 기간 -->
                            <label for="searchArticleStdDate" class="skip"><spring:message code="title.startYear"/></label> <!-- 시작년도 -->
                            <input type="text" name="searchArticleStdDate" id="searchArticleStdDate" value="${searchArticleReMap.startdate}" class="datePicker form-control" placeholder="<spring:message code="title.startYear"/>" placeholder="<spring:message code="title.startYear"/>">
                            <label for="searchArticleEndDate" class="skip"><spring:message code="title.endYear"/></label> <!-- 종료년도 -->
                            <input type="text" name="searchArticleEndDate" id="searchArticleEndDate" value="${searchArticleReMap.enddate}" class="datePicker form-control" title="<spring:message code="title.endYear"/>" placeholder="<spring:message code="title.endYear"/>">
                            <input type="hidden" name="range" value="000000000021">
                            <h3><spring:message code="table.sj"/></h3> <!-- 제목 -->
                            <input type="text" name="searchArticleTitle" id="searchArticleTitle" value="${searchArticleReMap.searchArticleTitle}" class="form-control" title="<spring:message code="table.sj"/>" placeholder="<spring:message code="table.sj"/>">
                            <h3><spring:message code="title.author"/></h3> <!-- 저자 -->
                            <input type="text" name="searchArticleAuthor" id="searchArticleAuthor" value="${searchArticleReMap.searchArticleAuthor}" class="form-control" title="<spring:message code="title.author"/>" placeholder="<spring:message code="title.author"/>">
                            <h3><spring:message code="title.journalName"/></h3> <!-- 학술지명 -->
                            <input type="text" name="searchArticleJournalName" id="searchArticleJournalName" value="${searchArticleReMap.searchArticleJournalName}" class="form-control" title="<spring:message code="title.journalName"/>" placeholder="<spring:message code="title.journalName"/>">

                            <h3><spring:message code="title.topic"/></h3> <!-- 주제 --> 
                            <div class="work_type_box">
                                <ul class="work_type work_type2">
		                        	<c:forEach var="articleAggs" items="${empty articleReAggsResult ? articleAggsResult : articleReAggsResult}" begin="0" varStatus="aaStatus">
		 	                          	<c:choose>
			 	                          	<c:when test="${SS_LOCALE ne 'en'}">
						 	                    <c:if test="${aaStatus.index == 0}">
						 	                    	<c:forEach var="articleAggsIn" items="${articleAggs.first_topic_nm_kor}">
						 	                    		<c:forEach var="articleAggsInFinal" items="${articleAggsIn}" begin="0" varStatus="aaInStatus">
										 	                <li>
											                   	<input type="checkbox" name="searchArticleKorSubjectCheck" class="searchArticleKorSubjectCheck" id="${articleAggsInFinal.key}" value="${articleAggsInFinal.key}" <c:if test="${fn:contains(searchArticleReMap.searchArticleKorSubjectCheck, articleAggsInFinal.key)}">checked="checked"</c:if>>
											                   	<label for="${articleAggsInFinal.key}"><strong><c:out value="${articleAggsInFinal.key}"/> (<c:out value="${articleAggsInFinal.value}"/>)</strong></label>
											                </li>
								                   		</c:forEach>
								                   	</c:forEach>		
							                    </c:if>                
			 	                          	</c:when>
			 	                          	<c:otherwise>
			 	                          		<c:if test="${aaStatus.index == 1}">
			 	                          			<c:forEach var="articleAggsIn" items="${articleAggs.first_topic_nm_eng}">
					 	                    			<c:forEach var="articleAggsInFinal" items="${articleAggsIn}" begin="0" varStatus="aaInStatus">
								 	                    	<li>
									                        	<input type="checkbox" name="searchArticleEngSubjectCheck" class="searchArticleEngSubjectCheck" id="${articleAggsInFinal.key}" value="${articleAggsInFinal.key}" <c:if test="${fn:contains(searchArticleReMap.searchArticleEngSubjectCheck, articleAggsInFinal.key)}">checked="checked"</c:if>>
									                        	<label for="${articleAggsInFinal.key}"><strong><c:out value="${articleAggsInFinal.key}"/> (<c:out value="${articleAggsInFinal.value}"/>)</strong></label>
									                    	</li>
							                    		</c:forEach>
							                    	</c:forEach>			 	                          				
			 	                          		</c:if>
			 	                          	</c:otherwise>
		 	                          	</c:choose> 
		                        	</c:forEach>      
                                </ul>
                            </div> <!--work_type_box-->
                        </div><!--search_filter_box-->
                    </div><!--search_filter-->
	                
	                <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'article'}">    
	                    <div class="thesis_wrap"> <!-- 논문탭만 해당 -->
		                    <ul class="recommended_book_list">
			                    <div class="recommended_book ml_20_mn">
		    						<div class="top_recommended_book">
				                        <ul>
					                     	<li class="ch_nAll">
					                       		<input type="checkbox" id="ar_ch1all" class="ml_10" onclick="fn_allCheck(this);">
					                     	</li>
				                            <li>
				                                <p class="blue_arrow">
				                                    <span></span> 
				                                    <spring:message code="title.thesis"/><!-- 논문 -->
				                                </p>
				                            </li>
				                    	</ul>
		                       		</div> <!--top_recommended_book-->
		                   		</div>
		                   	
								<c:if test="${!empty articleReResult}">
									<c:forEach var="article" items="${articleReResult}" begin="0" varStatus="aStatus">
										<li class="showPagingLi">
				                        	<div class="ch_n">
				                        		<input type="checkbox" id="${article.article_id}" class="ml_5 contentsCheckBox">
				                        		<input type="hidden" class="excelData" data-conid="<c:out value='${article.article_id}'/>" data-title="<c:out value='${article.article_title}'/>" data-author="<c:out value='${article.all_authors_name}'/>" data-pubdate="<c:out value='${article.publication_year}'/>">
				                        	</div>		
											<div class="sub_book_list_txt">
												<h3>
													<a href="#" onclick="cfn_goToArticleDetail('${article.article_id}'); return false;">
														<c:out value="${article.article_title}"/>
													</a>
												</h3>
												<p><c:if test="${!empty article.publisher_name}"><c:out value="${article.publisher_name}"/>  / </c:if><c:out value="${article.all_authors_name}"/></p>
												<span class="year2"><c:out value="${article.journal_name}"/>, <c:out value="${article.publication_year}"/></span>
												<div class="tag_box">
													<c:forEach var="articleTopic" items="${SS_LOCALE ne 'en' ? article.topic_nm_kor : article.topic_nm_eng}" varStatus="atStatus">
														<c:if test="${atStatus.index < 3}">
															<a href="#" onclick="cfn_goToTopicMain('${article.topic[atStatus.index]}'); return false;">
																<span class="tag"><c:out value="#" /><c:out value="${articleTopic}"/></span>
															</a>
														</c:if>
													</c:forEach>
												</div>
												<ul class="share_box">
													<button title="<spring:message code="title.share"/>" class="mr_30" id="articleColl1_${aStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/article/articleDetail.do?article_id='/><c:out value='${article.article_id}'/>" onclick="cfn_shareContents('articleColl1_${aStatus.index}');"><i class="xi-share-alt-o"></i></button>
													<button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button>                                
													<ul class="more_view_drop1">
														<li><a href="#" class="pdf" onclick="fn_getPDF('${article.doi}'); return false;"><c:out value="Get PDF" /></a></li>
														<li><a href="#" class="basket" onclick="cfn_popUpAddCollection('article', '${article.article_id}'); fn_eventLogInsert('search_article','article','${article.article_id}','collection_btn'); return false;"><spring:message code="title.add.collection" /></a></li>
														<li><a href="#" class="read" onclick="cfn_alreadyRead('article', '${article.article_id}'); fn_eventLogInsert('search_article','article','${article.article_id}','read_btn');  return false;"><spring:message code="title.already.read" /></a></li>
														<li><a href="#" class="not_interested" onclick="cfn_ignore('article', '${article.article_id}');return false;"><spring:message code="title.not.interested" /></a></li>
														<c:choose>
															<c:when test="${!empty article.doi}">
																<li><a href="https://doi.org/${article.doi}" class="aladdin" target="_blank" onclick="fn_eventLogInsert('search_article','article','${article.article_id}','source_btn'); "><spring:message code="title.view.paper" /></a></li>
															</c:when>
															<c:when test="${empty article.doi}">
																<li><a href="#" class="aladdin" onclick="cfn_alertToast('<spring:message code="common.noSource.msg" />'); fn_eventLogInsert('search_article','article','${article.article_id}','source_btn');" ><spring:message code="title.view.paper" /></a></li>
															</c:when>
														</c:choose>
													</ul>
												</ul>
											</div>
										</li>
									</c:forEach>
								</c:if>	
								<c:if test="${empty articleReResult}">
									<div class="no_info" style="border: none;">
										<p><spring:message code="info.noResult.msg"/></p>
									</div>	
								</c:if>	
								
								<!-- 페이징 -->
								<!-- API 자체 페이징 파라미터 설정 불가하므로 현재 리스트 기준으로 자체 표시 -->
								<c:if test="${!empty articleReResult}">
									<div id="paging_div" class="paging_normal">
										<ul class="pagination paging_align"> 
											<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_pageMove" type="image" />
										</ul>
									</div>
								</c:if>	
		                    </ul><!--recommended_book_list-->
	               		</div><!-- search_book_wrap -->
               		</c:if>
				</div>
			</div>
    		<!-- 논문탭끝 -->
    
    		<!-- 2023-12-30 강의 탭 -->
            <div id="tab-4" class="tab_content1 tab3-class <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'course'}">current</c:if>">
                <div class="sub-search-book">
                	<div class="search_book_wrap">
	                  	<!-- 키워드에 대해 강의 결과가 n건 있습니다. -->
						<c:choose>
							<c:when test="${SS_LOCALE ne 'en'}">
							<c:set var="title" value="강의" />					 	                	
							</c:when>
							<c:otherwise>
							<c:set var="title" value="Course" />					 	                	
							</c:otherwise>
						</c:choose>	               
	                    <div class="sub_search_tit">            
	                    	<fmt:formatNumber var="commaCourseCnt" value="${empty courseReCnt ? courseCnt : courseReCnt}" pattern="#,###" />
	                        <p class="sub_top_tit1">
	                        	<c:out value="'" />${searchMap.searchKeyword}<c:out value="'" /><spring:message code="info.result.msg"/> <span class="red">${title}</span> <spring:message code="info.result.msg2" /> <span class="red">${commaCourseCnt}</span><spring:message code="info.result.msg1" />
                        	</p>
	                        <span class="blue_bar"><spring:message code="title.course"/><!-- 강의 -->(<fmt:formatNumber value="${empty courseReCnt ? courseCnt : courseReCnt}" pattern="#,###" />)</span>
	                    </div>
	                    <!-- <a class="more_view" href="#link">더보기</a> -->
                        <div class="page_count mt_15"><spring:message code="title.page"/><!-- 페이지 --> (<em class="f_c_r" id="currPageEmBook">1</em>/<fmt:formatNumber value="${empty courseReTotalPage ? courseTotalPage : courseReTotalPage}" pattern="#,###" />)
                            <div class="tit_btnareaR">
                            	<button type="button" class="Btn btn-success" onclick="fn_popUpMultiAddCollection('course');  return false;"><spring:message code="title.add.collection"/><!-- LikeSNU 컬렉션에 담기 --><i class="xi-plus"></i></button>
                                <button type="button" class="Btn btn-success" onclick="exportExcel('course');"><spring:message code="button.content.export"/><!-- 엑셀 내보내기 --><i class="xi-share"></i></button>  
                                <select name="pagingSizeCourseSelect" id="pagingSizeCourseSelect" class="recommended_sel1 W70" title="페이지 수 선택">
                                   <option value="10" <c:if test="${paginationInfo.recordCountPerPage eq 10}">selected="selected"</c:if>>10<spring:message code="title.count"/></option>
                                   <option value="50" <c:if test="${paginationInfo.recordCountPerPage eq 50}">selected="selected"</c:if>>50<spring:message code="title.count"/></option>
                                   <option value="100" <c:if test="${paginationInfo.recordCountPerPage eq 100}">selected="selected"</c:if>>100<spring:message code="title.count"/></option>
                               </select>
                          	</div>	
                        </div>                        
	           		</div><!--search_tit-->	                
                
	                    <div class="search_filter">
	                        <p class="filter_tit"><spring:message code="title.search.result"/><spring:message code="title.filter"/><!-- 검색결과 필터 --></p>
	                        <div class="search_filter_box">
	                            <h3><spring:message code="title.order"/></h3><!-- 정렬 -->
	                            <select name="searchCourseOrder" id="searchCourseOrder" class="recommended_sel1" title='<spring:message code="title.order"/>' onchange="fn_filterSearch('course', '1');">
	                                <option value="course_nm" selected="selected"><spring:message code="title.relation"/></option> <!-- 관련도순 -->
	                            </select>
	                            <h3><spring:message code="title.search.re"/></h3> <!--결과 내 재검색 -->
	                            <a href="#none" class="filter_o filter_btn"><button style="background: #183989; color: white;" onclick="fn_filterSearch('course', '1');"><spring:message code="button.filter"/></button></a> <!-- 필터적용 -->
	                            <a href="#none" class="reset_btn filter_btn"><button onclick="fn_filterReset('course');"><spring:message code="button.init"/></button></a> <!-- 초기화 -->
	                            <input type="hidden" name="range" value="000000000021">
	                            <h3><spring:message code="title.course.name"/></h3> <!--강의명 -->
	                            <input type="text" name="searchCourseTitle" id="searchCourseTitle" value="${searchCourseReMap.searchCourseTitle}" class="form-control" title="<spring:message code="title.course.name"/>" placeholder="<spring:message code="title.course.name"/>">
			                    <h3><spring:message code="title.course.target"/></h3> <!-- 수강 대상 -->  
			                    <div class="work_type_box" style="height: 100%;">
	                                <ul class="work_type work_type2">
	                                	<c:forEach var="courseAggs" items="${empty courseReAggsResult ? courseAggsResult[0].estbl_curiclm_type_nm : courseReAggsResult[0].estbl_curiclm_type_nm}" begin="0" varStatus="caStatus">
								 	    	<c:forEach var="courseAggsIn" items="${courseAggs}" begin="0" varStatus="caInStatus">	                                	
												<li>
											   		<input type="checkbox" name="searchCuriTypeCheck" id="${courseAggsIn.key}" value="${courseAggsIn.key}" <c:if test="${fn:contains(searchCourseReMap.searchCuriTypeCheck,courseAggsIn.key)}">checked=checked</c:if>>
											   		<label for="${courseAggsIn.key}"><strong><c:out value="${courseAggsIn.key}"/> (<c:out value="${courseAggsIn.value}"/>)</strong></label>
												</li>	 
											</c:forEach>                                     		
	                                	</c:forEach>
	                                </ul>
	                            </div>			                    
			                    <h3><spring:message code="title.course.class"/></h3> <!-- 교과 구분 -->  
			                    <div class="work_type_box" style="height: 100%;">
	                                <ul class="work_type work_type2"> 
	                                	<c:forEach var="courseAggs" items="${empty courseReAggsResult ? courseAggsResult[1].estbl_course_type_nm : courseReAggsResult[1].estbl_course_type_nm}">
								 	    	<c:forEach var="courseAggsIn" items="${courseAggs}" begin="0" varStatus="caInStatus">	                                	
												<li>
											   		<input type="checkbox" name="searchCourseTypeCheck" id="${courseAggsIn.key}" value="${courseAggsIn.key}" <c:if test="${fn:contains(searchCourseReMap.searchCourseTypeCheck, courseAggsIn.key)}">checked=checked</c:if>>
											   		<label for="${courseAggsIn.key}"><strong><c:out value="${courseAggsIn.key}"/> (<c:out value="${courseAggsIn.value}"/>)</strong></label>
												</li>	 
											</c:forEach>                               		
	                                	</c:forEach>
	                                </ul>
	                            </div>
			                    <h3><spring:message code="title.topic"/></h3> <!-- 주제 -->
	                            <div class="work_type_box">
	                                <ul class="work_type work_type2">
			                        	<c:forEach var="courseAggs" items="${empty courseReAggsResult ? courseAggsResult : courseReAggsResult}" begin="0" varStatus="caStatus">
		 	                          		<c:if test="${caStatus.index > 1}">
				 	                          	<c:choose>
					 	                          	<c:when test="${SS_LOCALE ne 'en'}">
								 	                    <c:if test="${caStatus.index == 2}">
								 	                    	<c:forEach var="courseAggsIn" items="${courseAggs.first_topic_nm_kor}">
								 	                    		<c:forEach var="courseAggsInFinal" items="${courseAggsIn}" begin="0" varStatus="baInStatus">
												 	                <li>
													                   	<input type="checkbox" name="searchCourseKorSubjectCheck" id="${courseAggsInFinal.key}" value="${courseAggsInFinal.key}" <c:if test="${fn:contains(searchCourseReMap.searchCourseKorSubjectCheck, courseAggsInFinal.key)}">checked=checked</c:if>>
													                   	<label for="${courseAggsInFinal.key}"><strong><c:out value="${courseAggsInFinal.key}"/> (<c:out value="${courseAggsInFinal.value}"/>)</strong></label>
													                </li>
										                   		</c:forEach>
										                   	</c:forEach>		
									                    </c:if>                
					 	                          	</c:when>
					 	                          	<c:otherwise>
					 	                          		<c:if test="${caStatus.index == 3}">
					 	                          			<c:forEach var="courseAggsIn" items="${courseAggs.first_topic_nm_eng}">
							 	                    			<c:forEach var="courseAggsInFinal" items="${courseAggsIn}" begin="0" varStatus="caInStatus">
										 	                    	<li>
											                        	<input type="checkbox" name="searchCourseEngSubjectCheck" id="${courseAggsInFinal.key}" value="${courseAggsInFinal.key}" <c:if test="${fn:contains(searchCourseReMap.searchCourseEngSubjectCheck, courseAggsInFinal.key)}">checked=checked</c:if>>
											                        	<label for="${courseAggsInFinal.key}"><strong><c:out value="${courseAggsInFinal.key}"/> (<c:out value="${courseAggsInFinal.value}"/>)</strong></label>
											                    	</li>
									                    		</c:forEach>
									                    	</c:forEach>			 	                          				
					 	                          		</c:if>
					 	                          	</c:otherwise>
				 	                          	</c:choose> 
			                        		</c:if>	   
			                        	</c:forEach>   			                        	   
	                                </ul>
	                            </div> <!--work_type_box-->			                    
	                        </div><!--search_filter_box-->
	                    </div><!--search_filter-->      
                       
                        <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'course'}">
		                    <ul class="recommended_book_list">
			                    <div class="recommended_book ml_20_mn">
		    						<div class="top_recommended_book">
			                            <ul>
				                         	<li class="ch_nAll">
				                           		<input type="checkbox" id="ar_ch1all" class="ml_10" onclick="fn_allCheck(this);">
				                         	</li>
			                                <li>
			                                    <p class="blue_arrow">
			                                        <span></span> 
			                                        <spring:message code="title.course"/><!-- 강의 -->
			                                    </p>
			                                </li>
			                       		</ul>
		                       		</div> <!--top_recommended_book-->
		                       	</div>		           
		                       	<c:if test="${!empty courseReResult}">         
			                    	<c:forEach var="course" items="${courseReResult}" varStatus="cStatus" begin="0">
			                       		<c:set var="courseYear" value="${fn:substring(course.reg_dt, 0, 4)}"/>
				                        <li class="showPagingLi">
				                        	<div class="ch_n">
				                        		<input type="checkbox" id="${course.course_cd}" class="ml_5 contentsCheckBox">
				                        		<input type="hidden" class="excelData" data-conid="<c:out value='${course.course_cd}'/>" data-title="<c:out value='${course.course_nm}'/>">
				                        	</div>
				                            <div class="sub_book_list_txt">
												<h3>
													<c:choose>
								 	                	<c:when test="${SS_LOCALE ne 'en'}">
															<a href="#" onclick="cfn_goToCourseDetail('${course.course_cd}'); return false;">
																<c:out value="${course.course_nm}" /> <!-- 한글 강의명 --> 
															</a>					 	                	
								 	                	</c:when>
								 	                	<c:otherwise>
															<a href="#" onclick="cfn_goToCourseDetail('${course.course_cd}'); return false;">
																<c:out value="${course.course_eng_nm}" /> <!-- 영문 강의명 --> 
															</a>					 	                	
								 	                	</c:otherwise>
								 	                </c:choose>
												</h3>		   
												<span class="year2" style="background: none; border: none;"></span>                         
												<span class="green red_bg" style="margin-top: 0px;">
													<c:choose>
								 	                	<c:when test="${SS_LOCALE ne 'en'}">
															<c:out value="${course.estbl_coll_kor_nm}" />				 	                	
								 	                	</c:when>
								 	                	<c:otherwise>
															<c:out value="${course.estbl_coll_eng_nm}" />					 	                	
								 	                	</c:otherwise>
								 	                </c:choose>		
												</span>
												<c:if test="${not empty course.estbl_curiclm_type_nm || not empty course.estbl_course_type_nm}">
													<p>
														<c:if test="${not empty course.estbl_curiclm_type_nm}">
															<c:out value="${course.estbl_curiclm_type_nm}" />
														</c:if>
														<c:if test="${not empty course.estbl_course_type_nm}">
														/ <c:out value="${course.estbl_course_type_nm}" />
														</c:if>
													</p>
												</c:if>												
					                            <span class="book_list_txt1 ellipsis">
												<c:choose>
									 	            	<c:when test="${SS_LOCALE ne 'en'}">
									 	            		<c:if test="${!empty course.course_summary_cn}"><c:out value="${fn:substring(course.course_summary_cn, 0, 100)}" escapeXml="false" />…</c:if>			 	                	
									 	            	</c:when>
									 	            	<c:otherwise>
															<c:if test="${!empty course.course_summary_eng_cn}"><c:out value="${fn:substring(course.course_summary_eng_cn, 0, 100)}" escapeXml="false" />…</c:if>			 	                	
									 	            	</c:otherwise>
									 	            </c:choose>				                     
					                            </span>
					                            <div class="tag_box">
													<c:forEach items="${SS_LOCALE ne 'en' ? course.topic_nm_kor : course.topic_nm_eng}" var="courseTopic" varStatus="ctStatus">
														<c:if test="${ctStatus.index < 3}">
															<a href="#" onclick="cfn_goToTopicMain('${course.topic[ctStatus.index]}'); return false;">
																<span class="tag">
																	<c:out value="#" /><c:out value="${courseTopic}" />
																</span>
															</a>
														</c:if>
													</c:forEach>
				                            	</div>
				                                <ul class="share_box"> <!-- 순서대로 공유하기 / 더보기 -->
				                                    <button title="<spring:message code="title.share" />" class="mr_30" id="courseColl2_${cStatus.index}" data-clipboard-text="<c:url value='https://${header.host}/usr/course/courseDetail.do?course_cd='/><c:out value='${course.course_cd}'/>" onclick="cfn_shareContents('courseColl2_${cStatus.index}');"><i class="xi-share-alt-o"></i></button>
													<button class="more_view_btn1" title="<spring:message code="title.more"/>"><i class="xi-ellipsis-v"></i></button> <!-- 더보기 -->
													<ul class="more_view_drop1"><!-- 순서대로 컬렉션에 담기 / 관심 없음 -->
														<li><a href="#" onclick="cfn_popUpAddCollection('course', '${course.course_cd}'); fn_eventLogInsert('search_course','course','${course.course_cd}','collection_btn'); return false;" class="basket"><spring:message code="title.add.collection" /></a></li>
														<li><a href="link" class="not_interested" onclick="cfn_ignore('course', '${course.course_cd}'); return false;"><spring:message code="title.not.interested" /></a></li>
													</ul>		                                
				                                </ul>
				                            </div>
				                    	</li>
									</c:forEach>
								</c:if>
								<c:if test="${empty courseReResult}">
									<div class="no_info" style="border: none;">
										<p><spring:message code="info.noResult.msg"/></p>
									</div>	
								</c:if>								
				             	<!-- 페이징 -->
				              	<!-- API 자체 페이징 파라미터 설정 불가하므로 현재 리스트 기준으로 자체 표시 -->
				                <c:if test="${!empty courseReResult}">
	   								<div id="paging_div" class="paging_normal">
										<ul class="pagination paging_align"> 
											<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_pageMove" type="image" />
										</ul>
									</div>
				                </c:if>												
		                    </ul><!--recommended_book_list-->
	                    </c:if>
	            	</div><!--search_book_wrap-->     
	            </div><!--tab_content1 강의탭 tab3-class-->
            
            <!-- 기타자료탭 -->
            <div id="tab-5" class="tab_content1 tab3-class other_resources <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'media'}">current</c:if>">
                <div class="sub-search-book">
                	<div class="search_book_wrap">
	                  	<!-- 키워드에 대해 기타자료 결과가 n건 있습니다. -->
						<c:choose>
							<c:when test="${SS_LOCALE ne 'en'}">
								<c:set var="title" value="기타자료" />					 	                	
							</c:when>
							<c:otherwise>
								<c:set var="title" value="Media" />					 	                	
							</c:otherwise>
						</c:choose>	               
	                    <div class="sub_search_tit">
	                    	<fmt:formatNumber var="commaMediaCnt" value="${empty mediaReCnt ? mediaCnt : mediaReCnt}" pattern="#,###" />            
	                        <p class="sub_top_tit1">
	                        	<c:out value="'" />${searchMap.searchKeyword}<c:out value="'" /><spring:message code="info.result.msg" /> <span class="red">${title}</span> <spring:message code="info.result.msg2" /> <span class="red">${commaMediaCnt}</span><spring:message code="info.result.msg1" />
	                        </p>
	                        <span class="blue_bar"><spring:message code="title.etcMedia"/><!-- 기타자료 -->(<fmt:formatNumber value="${empty mediaReCnt ? mediaCnt : mediaReCnt}" pattern="#,###" />)</span>
	                    </div>
	                    <!-- <a class="more_view" href="#link">더보기</a> -->
                        <div class="page_count mt_15"><spring:message code="title.page"/><!-- 페이지 --> (<em class="f_c_r" id="currPageEmBook">1</em>/<fmt:formatNumber value="${empty mediaReTotalPage ? mediaTotalPage : mediaReTotalPage}" pattern="#,###" />)
                            <div class="tit_btnareaR">
                            	<%-- <button type="button" class="Btn btn-success" onclick="exportExcel('media');"><spring:message code="button.content.export"/><!-- 엑셀 내보내기 --><i class="xi-share"></i></button>   --%>
                                <select name="pagingSizeMediaSelect" id="pagingSizeMediaSelect" class="recommended_sel1 W70" title="페이지 수 선택">
                                   <option value="10" <c:if test="${paginationInfo.recordCountPerPage eq 10}">selected="selected"</c:if>>10<spring:message code="title.count"/></option>
                                   <option value="50" <c:if test="${paginationInfo.recordCountPerPage eq 50}">selected="selected"</c:if>>50<spring:message code="title.count"/></option>
                                   <option value="100" <c:if test="${paginationInfo.recordCountPerPage eq 100}">selected="selected"</c:if>>100<spring:message code="title.count"/></option>
                               </select>
                          	</div>	
                        </div>                        
	           		</div><!--search_tit-->	       
	           		                
	                    <!-- 기타자료 탭 검색결과 필터부분 search_filter-->
	                    <div class="search_filter">
	                        <p class="filter_tit"><spring:message code="title.search.result"/><spring:message code="title.filter"/><!-- 검색결과 필터 --></p>
	                        <div class="search_filter_box"> 
	                            <h3><spring:message code="title.order"/></h3> <!-- 정렬 -->
	                            <select name="searchMediaOrder" id="searchMediaOrder" class="recommended_sel1" title="<spring:message code="title.order"/>" onchange="fn_filterSearch('media', '1');">
	                                <option value="title" <c:if test="${(searchMap.orderField eq 'title') or (searchMap.orderField eq '')}">selected="selected"</c:if> ><spring:message code="title.relation"/></option> <!-- 관련도순 -->
	                                <option value="publication_date" <c:if test="${searchMap.orderField eq 'publication_date'}">selected="selected"</c:if> ><spring:message code="title.recent"/></option> <!-- 최신순 -->
	                            </select>
	                            <h3><spring:message code="title.search.re"/></h3> <!-- 결과 내 재검색 -->
	                            <a href="#none" class="filter_o filter_btn"><button style="background: #183989; color: white;" onclick="fn_filterSearch('media', '1');"><spring:message code="button.filter"/><!-- 필터적용 --></button></a>
	                            <a href="#none" class="reset_btn filter_btn"><button onclick="fn_filterReset('media');"><spring:message code="button.init"/><!-- 초기화 --></button></a>
	                            <h3><spring:message code="title.pubYear"/></h3> <!-- 기간 -->
	                            <label for="searchMediaStdDate" class="skip"><spring:message code="title.startYear"/></label> <!-- 시작년도 -->
	                            <input type="text" name="searchMediaStdDate" id="searchMediaStdDate" value="${searchMediaReMap.startdate}" class="datePicker form-control" placeholder="<spring:message code="title.startYear"/>" placeholder="<spring:message code="title.startYear"/>">
	                            <label for="searchMediaEndDate" class="skip"><spring:message code="title.endYear"/></label> <!-- 종료년도 -->
	                            <input type="text" name="searchMediaEndDate" id="searchMediaEndDate" value="${searchMediaReMap.enddate}" class="datePicker form-control" title="<spring:message code="title.endYear"/>" placeholder="<spring:message code="title.endYear"/>">
	                            <input type="hidden" name="range" value="000000000021">
	                            <h3><spring:message code="table.sj"/></h3> <!-- 제목 -->
	                            <input type="text" name="searchMediaTitle" id="searchMediaTitle" value="${searchMediaReMap.searchMediaTitle}" class="form-control" title="<spring:message code="table.sj"/>" placeholder="<spring:message code="table.sj"/>">
	                            <h3><spring:message code="title.author"/></h3> <!-- 저자 -->
	                            <input type="text" name="searchMediaAuthor" id="searchMediaAuthor" value="${searchMediaReMap.searchMediaAuthor}" class="form-control" title="<spring:message code="title.author"/>" placeholder="<spring:message code="title.author"/>">
 	                            <h3><spring:message code="title.dataType"/></h3> <!-- 자료유형 -->
 	                            <div class="work_type_box">
		                            <ul class="work_type">
			                        	<c:forEach var="mediaAggs" items="${empty mediaReAggsResult ? mediaAggsResult : mediaReAggsResult}" varStatus="maStatus">
			                        		<c:if test="${maStatus.index == 0}"> 
			                        			<c:forEach var="mediaAggsIn" items="${mediaAggs.call_number_prefix}" varStatus="maInStatus">
					                        		<c:forEach var="mediaAggsInFinal" items="${mediaAggsIn}" begin="0" varStatus="maInFStatus">
														<li>
														   <input type="checkbox" name="searchMediaTypeCheck" class="searchMediaTypeCheck" id="${mediaAggsInFinal.key}" value="${mediaAggsInFinal.key}" <c:if test="${fn:contains(searchMediaReMap.searchMediaTypeCheck, mediaAggsInFinal.key)}">checked="checked"</c:if>>
														   <label for="${mediaAggsInFinal.key}"><strong><c:out value="${mediaAggsInFinal.key}"/> (<c:out value="${mediaAggsInFinal.value}"/>)</strong></label>
														</li>
													</c:forEach>
												</c:forEach>
											</c:if>
										</c:forEach>		
			                        </ul>
		                        </div>
	                        </div><!--search_filter_box-->
	                    </div><!--search_filter-->
	                    
	                    <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'media'}">
	                    <ul class="recommended_book_list">
		                    <div class="recommended_book ml_20_mn">
	    						<div class="top_recommended_book">
	                            <ul>
		                         	<li class="ch_nAll">
		                           		<input type="checkbox" id="ar_ch1all" class="ml_10" onclick="fn_allCheck(this);">
		                         	</li>
	                                <li>
	                                    <p class="blue_arrow">
	                                        <span></span> 
	                                        <spring:message code="title.etcMedia"/><!-- 기타자료 -->
	                                    </p>
	                                </li>
	                       		</ul>
	                       		</div> <!--top_recommended_book-->
	                       	</div>		                    
							<c:if test="${!empty mediaReResult}">
								<c:forEach var="media" items="${empty mediaReResult ? mediaResult : mediaReResult}" begin="0" varStatus="mStatus">
									<li class="showPagingLi">
			                        	<div class="ch_n">
			                        		<input type="checkbox" id="${media.mms_id}" class="ml_5 contentsCheckBox">
			                        		<input type="hidden" class="excelData" data-conid="${media.mms_id}" data-title="${media.title}" data-author="${media.author}" data-date="${media.publication_date}">
			                        	</div>									
										<div class="sub_book_list_txt">
			                                <h3><span><a href="https://snu-primo.hosted.exlibrisgroup.com/permalink/f/177n5ka/82SNU_INST${media.doc_id}" target="_blank"><c:out value="${media.title}"/></a></span></h3>
			                                <c:if test="${media.local_param_04 != null || media.local_param_06 != null}">
			                                	<c:choose>
			                                		<c:when test="${media.local_param_04 != null && media.local_param_04 != ''}">
			                                			<span class="book_list_txt1 ellipsis"><c:out value="${fn:substring(media.local_param_04, 0, 100)}"/>…</span>
			                                		</c:when>
			                                		<c:when test="${media.local_param_06 != null && media.local_param_06 != ''}">
			                                			<span class="book_list_txt1 ellipsis"><c:out value="${fn:substring(media.local_param_06, 0, 100)}"/>…</span>
			                                		</c:when>
			                                		<c:otherwise>
			                                		</c:otherwise>
			                                	</c:choose>
			                                </c:if>
				                            <c:if test="${media.author != null || media.publisher != null}">
					                            <c:choose>
							                        <c:when test="${media.author != null and media.publisher == null}">
							                        	 <p>
							                        	 	<c:out value="${media.author}"/>
							                        	 </p>
							                        </c:when>
							                        <c:when test="${media.author != null and media.publisher != null}">
							                        	<p><c:out value="${media.author}"/><span class="txt_line"><c:out value="${media.publisher}"/></span></p>
							                        </c:when>				                                	
							                        <c:otherwise>
							                        	<p><c:out value="${media.publisher}"/></p>
							                        </c:otherwise>
					                            </c:choose>
				                            </c:if>
			                                <c:if test="${media.publication_date != null}">
			                                	<span class="year2"><c:out value="${media.publication_date}"/><spring:message code="title.year"/></span>
			                                </c:if>
										</div>
									</li>
								</c:forEach>
							</c:if>	
							<c:if test="${empty mediaReResult}">
								<div class="no_info" style="border: none;">
									<p><spring:message code="info.noResult.msg"/></p>
									<button type="button">
										<a href="https://lib.snu.ac.kr/using/purchase-textbook/p-guide/" title="<spring:message code="title.request.book.hope" />">
											<spring:message code="title.request.book.hope" />
										</a>
									</button>										
								</div>	
							</c:if>	
							
							<!-- 페이징 -->
							<!-- API 자체 페이징 파라미터 설정 불가하므로 현재 리스트 기준으로 자체 표시 -->
							<c:if test="${!empty mediaReResult}">
   								<div id="paging_div" class="paging_normal">
									<ul class="pagination paging_align"> 
										<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_pageMove" type="image" />
									</ul>
								</div>
							</c:if>	
	                    </ul><!--recommended_book_list-->
	                    </c:if>
	                    
                	</div><!-- search_book_wrap -->
                </div><!--tab_content1-->
    		<!-- 기타자료 탭 끝 -->
    		            
            <!-- 컬렉션 탭 -->
            <div id="tab-6" class="tab_content1 LikeSNU_collec <c:if test="${searchMap.bExtendSearch eq 'true' && searchMap.tabName eq 'collection'}">current</c:if>">
                <div class="sub-search-book">
                
                	<div class="search_book_wrap">
	                  	<!-- 키워드에 대해 컬렉션 결과가 n건 있습니다. -->
						<c:choose>
							<c:when test="${SS_LOCALE ne 'en'}">
								<c:set var="title" value="컬렉션" />					 	                	
							</c:when>
							<c:otherwise>
								<c:set var="title" value="Collection" />					 	                	
							</c:otherwise>
						</c:choose>	               
	                    <div class="sub_search_tit">            
	                    	<fmt:formatNumber var="commaCollectionCnt" value="${empty collectionReCnt ? collectionCnt : collectionReCnt}" pattern="#,###" />
	                        <p class="sub_top_tit1">
	                        	<c:out value="'" />${searchMap.searchKeyword}<c:out value="'" /><spring:message code="info.result.msg" /> <span class="red">${title}</span> <spring:message code="info.result.msg2" /> <span class="red">${commaCollectionCnt}</span><spring:message code="info.result.msg1" />
	                        </p>
	                        <span class="blue_bar"><spring:message code="lib.title.collections"/><!-- SNU 컬렉션 -->(<fmt:formatNumber value="${empty collectionReCnt ? collectionCnt : collectionReCnt}" pattern="#,###" />)</span>
	                    </div>
	                    <!-- <a class="more_view" href="#link">더보기</a> -->
                        <div class="page_count mt_15"><spring:message code="title.page"/><!-- 페이지 --> (<em class="f_c_r" id="currPageEmBook">1</em>/<fmt:formatNumber value="${empty collectionReTotalPage ? collectionTotalPage : collectionReTotalPage}" pattern="#,###" />)
                            <div class="tit_btnareaR">
                                <select name="pagingSizeCollectionSelect" id="pagingSizeCollectionSelect" class="recommended_sel1 W70" title="페이지 수 선택">
                                   <option value="9" <c:if test="${paginationInfo.recordCountPerPage eq 9}">selected="selected"</c:if>>9<spring:message code="title.count"/></option>
                                   <option value="45" <c:if test="${paginationInfo.recordCountPerPage eq 45}">selected="selected"</c:if>>45<spring:message code="title.count"/></option>
                                   <option value="90" <c:if test="${paginationInfo.recordCountPerPage eq 90}">selected="selected"</c:if>>90<spring:message code="title.count"/></option>
                               </select>
                          	</div>	
                        </div>                        
	           		</div><!--search_tit-->	                
                
	                    <div class="search_filter">
	                        <p class="filter_tit"><spring:message code="title.search.result"/><spring:message code="title.filter"/><!-- 검색결과 필터 --></p>
	                        <div class="search_filter_box">
	                            <h3><spring:message code="title.order"/></h3> <!-- 정렬 -->
	                            <select name="searchCollectionOrder" id="searchCollectionOrder" class="recommended_sel1" title="<spring:message code="title.order"/>"  onchange="fn_filterSearch('collection', '1');">
	                                <option value="collection_title" <c:if test="${(searchMap.orderField eq 'collection_title') or (searchMap.orderField eq '')}">selected="selected"</c:if> ><spring:message code="title.relation"/></option> <!-- 관련도순 -->
	                                <option value="reg_dt" <c:if test="${searchMap.orderField eq 'reg_dt'}">selected="selected"</c:if> ><spring:message code="title.recent"/></option> <!-- 최신순 -->
	                            </select>
	                            <h3><spring:message code="title.search.re"/></h3> <!-- 결과 내 재검색 -->
	                            <a href="#none" class="filter_o filter_btn"><button style="background: #183989; color: white;" onclick="fn_filterSearch('collection', '1');"><spring:message code="button.filter"/><!-- 필터적용 --></button></a>
	                            <a href="#none" class="reset_btn filter_btn"><button onclick="fn_filterReset('collection');"><spring:message code="button.init"/><!-- 초기화 --></button></a>
	                        </div><!--search_filter_box-->
	                    </div><!--search_filter-->
	                    
	                    <div class="recommended_book_list">
		                    <div class="recommended_book ml_20_mn">
	    						<div class="top_recommended_book">
	                            <ul>
	                                <li>
	                                    <p class="blue_arrow">
	                                        <span></span> 
	                                        <spring:message code="lib.title.collections"/><!-- SNU 컬렉션 -->
	                                    </p>
	                                </li>
	                       		</ul>
	                       		</div> <!--top_recommended_book-->
	                       	</div>	                    
							<c:if test="${!empty collectionReResult}">
								<div class="sub_card_box ml_20_mn box_h">
									<c:forEach var="collection" items="${empty collectionReResult ? collectionResult : collectionReResult}" varStatus="collStatus">
										<div class="showPagingLi card_box left_card_box">
											<h2>
												<a href="#" onclick="cfn_goToCollectionDetail('${collection.collection_id}'); return false;">
													<c:out value="${collection.collection_title}"/>
												</a>
											</h2>
											<p></p>
											<div class="tag_box">
												<c:forEach var="collectionTopic" items="${SS_LOCALE ne 'en' ? collection.topic_name_kor : collection.topic_name_eng}" varStatus="colltStatus">
													<c:if test="${colltStatus.index < 3}">
														<a href="#" onclick="cfn_goToTopicMain('${collection.topic[colltStatus.index]}'); return false;">
															<span class="tag"><c:out value="#" /><c:out value="${collectionTopic}"/></span>
														</a>
													</c:if>
												</c:forEach>
											</div>
										</div>								
									</c:forEach>
								</div><!-- sub_card_box -->
							</c:if>
							<c:if test="${empty collectionReResult}">
								<div class="no_info" style="border: none;">
									<p><spring:message code="info.noResult.msg"/></p>
								</div>	
							</c:if>	
							
							<!-- 페이징 -->
							<!-- API 자체 페이징 파라미터 설정 불가하므로 현재 리스트 기준으로 자체 표시 -->
							<c:if test="${!empty collectionReResult}">
	  							<div id="paging_div" class="paging_normal">
									<ul class="pagination paging_align"> 
										<ui:pagination paginationInfo="${paginationInfo}" jsFunction="fn_pageMove" type="image" />
									</ul>
								</div>
							</c:if>	
							
	                    </div><!-- sub_card_box -->
	            
	                </div>
                </div><!-- 컬렉션탭끝 -->
			</div><!--content_warp-->    
			
		    <!-- 만족도조사 -->
		    <div id="research-wrap">
		        <div class="research">
		            <div>
		                <span class="hide3"><spring:message code="info.satisfaction.survey" /></span>
		                <span><spring:message code="info.useful.information" /></span>
		                <div class="input-wrap1">
		                    <input type="radio" name="satisfy_point" id="satisfy_point1" value="5" checked="checked"> <label for="satisfy_point1"><spring:message code="info.very.satisfied" /></label>
		                    <input type="radio" name="satisfy_point" id="satisfy_point2" value="4"> <label for="satisfy_point2"><spring:message code="info.satisfied" /></label>
		                    <input type="radio" name="satisfy_point" id="satisfy_point3" value="3"> <label for="satisfy_point3"><spring:message code="info.normal" /></label>
		                    <input type="radio" name="satisfy_point" id="satisfy_point4" value="2"> <label for="satisfy_point4"><spring:message code="info.unsatisfactory" /></label>
		                    <input type="radio" name="satisfy_point" id="satisfy_point5" value="1"> <label for="satisfy_point5"><spring:message code="info.very.unsatisfactory" /></label>
		                </div>
		                <div class="input-wrap2">
		                    <input type="text" name="satisfy_contents" id="satisfy_contents" title="의견 입력" value="" placeholder='<spring:message code="info.your.opinion" />'>
		                    <input type="submit" class="btn" onclick="cfn_insertUserFeed('05', '','${param.searchKeyword}'); return false;" value="<spring:message code="button.opinion.regist" />">
		                </div>
		            </div>
		        </div>
		    </div>
		    <!-- 만족도조사끝 -->			 
        </div>
        
	</div><!--contents_box-->

<%@ include file="/WEB-INF/jsp/egovframework/usr/cmn/accessLogging.jsp" %>