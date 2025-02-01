<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>TasteHILL</title>
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/header.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/css/index.css">
    
    <script src="https://maps.googleapis.com/maps/api/js?key=${sessionScope.API_KEY}&libraries=places"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/map.css">

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

        /* Pinned Route 카드 */
        .pinned-route {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            background-color: #f9f9f9;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .pinned-route img {
            width: 120px;
            height: 120px;
            border-radius: 10px;
            object-fit: cover;
        }

        .pinned-route-content {
            flex: 1;
        }

        .pinned-route-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            color: #004d00;
        }

        .pinned-route-desc {
            font-size: 14px;
            color: #555;
        }
    </style>
</head>
<body>
	<!-- 헤더 -->
<!-- 	<div class="header"> -->
<!-- 		<a href="/" class="header-logo">TasteHILL</a> <a href="/mypage" -->
<!-- 			class="header-mypage">MyPage</a> -->
<!-- 	</div> -->


	<!-- 네비게이션 바 -->
	<div class="navbar">
	    <div class="logo">TasteHILL</div>
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
	
	<!-- HotList -->
	<h2>Hot 동선 리스트</h2>
	<div class="card-list">
   
    <c:forEach var="route" items="${hotRoutes}">
        <div class="card">
            <img src="${route.image}" alt="동선 이미지">
            <p class="card-title">${route.title}</p>
            <p class="card-date">등록일: ${route.date}</p>
        </div>
    </c:forEach>
	</div>

	<!-- 홈으로 돌아가는 버튼 -->
	<a href="/home">홈으로</a>
</body>
</html>
