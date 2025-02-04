<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TasteHILL</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/index.css">

    <style>
        /* 네비게이션 바 */
        .navbar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 20px;
            background-color: #f8f9fa;
            border-bottom: 1px solid #ddd;
        }

        .navbar .logo {
            font-size: 24px;
            font-weight: bold;
            color: #004d00;
        }

        .navbar .search-bar {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .navbar input[type="text"] {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }

        .navbar button {
            background-color: #004d00;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }

        /* 섹션 제목 */
        .section-title {
            font-size: 18px;
            font-weight: bold;
            margin: 20px 0 10px;
            color: #004d00;
        }

        /* 카드 리스트 */
        .card-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 10px;
        }

        /* 카드 스타일 */
        .card {
            width: 200px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 100%;
            height: 150px;
            object-fit: cover;
        }

        .card .card-title {
            font-size: 16px;
            font-weight: bold;
            margin: 10px 0;
            color: #333;
        }

        .card .card-date {
            font-size: 14px;
            color: #888;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>

	<!-- 네비게이션 바 -->
	<div class="navbar">
	    <div class="logo">
	    	<a href="/main" style="text-decoration: none; color: inherit;">TasteHILL</a>
	    </div>
	    <div class="search-bar">
	        <select>
	            <option>위치</option>
	            <option>서울</option>
	            <option>부산</option>
	        </select>
	        <input type="text" placeholder="search place...">
	        <button>🔍</button>
	        <button>새 동선 만들기</button>
	  	</div>
	  		
	  	
	  	<a href="${pageContext.request.contextPath}/jsp/mypage/mypage.jsp" class="button">My Page</a>
	</div>
	
<h2>검색 결과</h2>

<h3>경로 검색 결과</h3>
<c:if test="${empty searchRoutes}">
    <p>경로 검색 결과가 없습니다.</p>
</c:if>

<c:forEach var="route" items="${searchRoutes}">
    <div class="route-card">
        <p><strong>${route.title}</strong></p>
        <p>좋아요 수: ${route.forkCount}</p>
        <p>업데이트 날짜: ${route.updatedAt}</p>
        <c:if test="${not empty route.photo_url}">
            <img src="${route.photo_url}" alt="${route.title} 사진">
        </c:if>
    </div>
</c:forEach>

<h3>장소 검색 결과</h3>
<c:if test="${empty searchPlaces}">
    <p>장소 검색 결과가 없습니다.</p>
</c:if>
<c:forEach var="place" items="${searchPlaces}">
    <div class="place-card">
        <p><strong>${place.name}</strong></p>
        <p>주소: ${place.formatted_address}</p>
        <p>평점: ${place.rating}</p>
            <img src="${place.photos.photo_url}" alt="${place.name} 사진">
    </div>
</c:forEach>

	<!-- 홈으로 돌아가는 버튼 -->
	<a href="/home">홈으로</a>
</body>
</html>
