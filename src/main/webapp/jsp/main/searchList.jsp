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
		<div>
		    <div class="search-container">
			    <div class="search-bar">
			        <form action="/routeList/searchList" method="get">
					    <select name="location">
		            	    <option value="">위치</option>
					        <option value="서울">서울</option>
					        <option value="부산">부산</option>
					    </select>
					    <input type="text" name="query" placeholder="search place...">
					    <button type="submit">🔍</button>
					</form>
			        
			    </div>
		    </div>
		 </div>
		 
		 <div class="route-creat">
		  	<button onclick="location.href='/route'">새 동선 만들기</button>
		 </div> 
		
		<br>
		<br>
		
		
		<!-- 결과 리스트 -->
		<div>
		    <h3 class="section-title">경로 검색 결과</h3>
		    <div class="card-list">
		        <c:if test="${empty searchRoutes}">
		            <p>경로 검색 결과가 없습니다.</p>
		        </c:if>
		
		        <c:forEach var="route" items="${searchRoutes}">
		 			<div class="result-list-container" onclick="location.href='/detail?seqRoute=${route.seq_route}'" style="cursor: pointer;">
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
		
		<br><br><br>
		
		<h3 class="section-title">장소 검색 결과</h3>
		<div class="card-list">
			<c:if test="${empty searchPlaces}">
			    <p>장소 검색 결과가 없습니다.</p>
			</c:if>
			<c:forEach var="place" items="${searchPlaces}">
			    <div class="result-list-container" onclick="location.href='/detail?seqRoute=${route.seq_route}'">
			    	<!-- 왼쪽 영역 -->
		            <div class="left">
			        <p><strong>${place.name}</strong></p>
			        <p class="card-title">주소: ${place.formatted_address}</p>
			        <p class="card-date">평점: ${place.rating}</p>
			        </div>
		        	<!-- 오른쪽 영역 (이미지) -->
	                <div class="right">
			        	<img src="${place.photos.photo_url}" alt="${place.name} 사진">
		        	</div>
			    </div>
			</c:forEach>
		</div>
		
</body>
</html>