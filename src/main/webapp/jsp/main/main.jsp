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
        
        .auth-buttons {
		    display: flex;
		    align-items: center;
		    gap: 10px; /* 버튼 간격 */
		}
		.auth-buttons .button {
		    background-color: #004d00;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    border-radius: 5px;
		    cursor: pointer;
		    text-decoration: none; /* 링크 밑줄 제거 */
		}
		.auth-buttons .button:last-child {
		    margin-right: 0; /* 마지막 버튼은 오른쪽 여백 제거 */
		}
    </style>
</head>
<body>
    <!-- 네비게이션 바 -->
	<div class="navbar">
	    <div class="logo">TasteHILL</div>
	    <form method="POST" action="<%=request.getContextPath()%>/main/search" class="search-bar">
            <select name="location">
                <option value="">위치</option>
                <option value="서울">서울</option>
                <option value="부산">부산</option>
            </select>
            <input type="text" name="searchKeyword" placeholder="search place...">
	        <button>🔍</button>
	        <button onclick="location.href='/main/route/rout_create'">새 동선 만들기</button>
	         </form>
	         
	         
	          <!-- 로그인 상태에 따라 버튼 표시 -->
	     <div class="auth-buttons">
	     <c:choose>
            <c:when test="${isLoggedIn}">
                <a href="${pageContext.request.contextPath}/profile">My Page</a>
                <form method="POST" action="${pageContext.request.contextPath}/logout">
                    <button type="submit" class="button">로그아웃</button>
                </form>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/loginPage" class="button">로그인</a>
            </c:otherwise>
        </c:choose>
		</div>	         

	  </div>
	
	   
		<!-- Hot 동선 섹션 -->
		<div>
		    <h2 class="section-title">Hot 동선</h2>
		    <div class="card-list">
		        <c:forEach var="route" items="${seqRoute}">
		            <div class="card">
		                <img src="${route.image}" alt="동선 이미지">
		                <p class="card-title">${route.title}</p>
		                <p class="card-date">등록일: ${route.date}</p>
		            </div>
		        </c:forEach>
		    </div>
		    <a href="/main/hotList" class="see-more">더보기 ></a>
		</div>
		
		<!-- My Pinned Route 섹션 -->
		<div>
		    <h2 class="section-title">My Pinned Route</h2>
		    <div class="pinned-route">
		        <img src="${pinnedRoute.image}" alt="Pinned Route">
		        <div class="pinned-route-content">
		            <p class="pinned-route-title">${pinnedRoute.title} 📍</p>
		            <p class="pinned-route-desc">${pinnedRoute.description}</p>
		        </div>
		    </div>
		</div>
    
메인 페이지
검색바<br>
<a href="/jsp/route/route_list.jsp" >루트 리스트 - 핫동선</a><br>
<a href="/jsp/detail/route_detail.jsp" >루트 상세페이지</a><br>
<a href="/jsp/route/route_create.jsp" >루트 생성 페이지</a><br>
<a href="/jsp/mypage/mypage.jsp" >마이페이지</a>
</body>
</html>