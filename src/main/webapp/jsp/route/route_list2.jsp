<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TasteHILL</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/index.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/searchBar.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/route_card.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/route_card_list.css">

    <style>
		
    </style>
</head>
<body>
		<!-- 검색 바 -->
		${MY_KEY_PAGING_HTML}
		<jsp:include page="${searchBar}" />
		 
		 <div class="route-creat">
		  	<button onclick="location.href='/route'">새 동선 만들기</button>
		 </div> 
		
		<br>
		<br>
		
			/**
	 * @param url 			: 페이징 적용 대상 주소  (서블릿주소) /myboard
	 * @param currentPage 	: 현재 페이지
	 * @param totRecord 	: 젠체 게시물수
	 * @param blockCount 	: 한 블럭의 게시물 수
	 * @param blockPage  	: 한화면에 보여질 블럭 수
	 **/
		
		
		<!-- 결과 리스트 -->
		<div>
		    <h3 class="section-title">경로 검색 결과</h3>
		    <div class="card-list">
		        <c:if test="${empty searchRoutes}">
		            <p>경로 검색 결과가 없습니다.</p>
		        </c:if>
		
		        <c:forEach var="route" items="${searchRoutes}">
		 			<div class="result-list-container" onclick="location.href='/detail?seq_route=${route.seq_route}'" style="cursor: pointer;">
    		                <!-- 왼쪽 영역 -->
		                <div class="left">
		                    <h4>${route.title}</h4>
		                    <p>좋아요 수: ${route.forkCount}</p>
		                    <p>업데이트 날짜: ${route.updatedAt}</p>
		                </div>
		
		                <!-- 오른쪽 영역 (이미지) -->
		                <div class="right">
		                    <img src="${route.photo_url}" alt="${route.title} 사진">
		                </div>
		            </div>
		        </c:forEach>
		    </div>
		</div>
		
</body>
</html>