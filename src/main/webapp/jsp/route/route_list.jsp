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
		
		
		<body>
	    <!-- 네비게이션바 검색 결과 화면 -->
            <h3 class="section-title">검색 결과</h3>
            <div>
            
                
                <c:if test="${empty searchBarRes}">
                    <p>${searchGubunKor} 검색 결과가 없습니다.</p>
                </c:if>
                <c:forEach var="place" items="${searchBarRes}">
                    <div class="result-list-container" onclick="location.href='/searchList2?seqPlace=${place.seq_place}'" style="cursor: pointer;">
                        <div class="left">
                            <p><strong>${place.name}</strong></p>
                            <p class="card-title">주소: ${place.formatted_address}</p>
                            <p class="card-date">평점: ${place.rating}</p>
                        </div>
                        <div class="right">
                            <img src="${place.photos.photo_url}" alt="${place.name} 사진">
                        </div>
                    </div>
                </c:forEach>
            </div>
	        
	
	        <!-- Hot 동선 화면 -->
	        <c:if test="${pageType == 'hotList'}">
	            <h3 class="section-title">❤️ Hot 동선</h3>
	            <c:forEach var="route" items="${hotRoutes}">
	                <div class="result-list-container" onclick="location.href='/detail?seq_route=${route.seq_route}'" style="cursor: pointer;">
	                    <div class="left">
	                        <h4>${route.title}</h4>
	                        <p>좋아요 수: ${route.forkCount}</p>
	                        <br><br><br><br>
	                        <p>업데이트 날짜: ${route.updatedAt}</p>
	                    </div>
	                    <div class="right">
	                        <img src="${route.photo_url}" alt="${route.title} 사진">
	                    </div>
	                </div>
	            </c:forEach>
	        </c:if>
	        
	        <!-- 마이페이지 동선 -->
	        <c:if test="${pageType == 'myRoutes'}">
	            <h3 class="section-title">나의 동선</h3>
	            <c:forEach var="route" items="${myRoutes}">
	                <div class="result-list-container" onclick="location.href='/detail?seq_route=${route.seq_route}'" style="cursor: pointer;">
	                    <div class="left">
	                        <h4>${route.title}</h4>
	                        <p>좋아요 수: ${route.forkCount}</p>
	                        <br><br><br><br>
	                        <p>업데이트 날짜: ${route.updatedAt}</p>
	                    </div>
	                    <div class="right">
	                        <img src="${route.photo_url}" alt="${route.title} 사진">
	                    </div>
	                </div>
	            </c:forEach>
	        </c:if>
	        
	        <!-- 즐겨찾기 동선 -->
	        <c:if test="${pageType == 'forkList'}">
	            <h3 class="section-title">즐겨찾기</h3>
	            <c:forEach var="route" items="${forkList}">
	                <div class="result-list-container" onclick="location.href='/detail?seq_route=${route.seq_route}'" style="cursor: pointer;">
	                    <div class="left">
	                        <h4>${route.title}</h4>
	                        <p>좋아요 수: ${route.forkCount}</p>
	                        <br><br><br><br>
	                        <p>업데이트 날짜: ${route.updatedAt}</p>
	                    </div>
	                    <div class="right">
	                        <img src="${route.photo_url}" alt="${route.title} 사진">
	                    </div>
	                </div>
	            </c:forEach>
	        </c:if>
			     
		
			
		<script>
		    function toggleSearchResults() {
		        const pageType = '<c:out value="${pageType}" />'; // 서버에서 전달된 pageType 값
		
		        const routeResults = document.getElementById('routeResults');
		        const placeResults = document.getElementById('placeResults');
		        const routeTitle = document.getElementById('routeTitle');
		        const placeTitle = document.getElementById('placeTitle');
		
		        if (pageType === 'searchList') {
		            routeResults.style.display = 'block';
		            routeTitle.style.display = 'block';
		            placeResults.style.display = 'block';
		            placeTitle.style.display = 'block';
		        } else if (pageType === 'hotList') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        } else if (pageType === 'myRoutes') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        } else if (pageType === 'forkList') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        }
		    }
		
		    // 페이지 로드 시 초기화
		    window.onload = function () {
		        toggleSearchResults();
		    };
		</script>
</body>
</html>