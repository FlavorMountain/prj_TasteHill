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
		

        
		.search-container {
		    display: flex;
		    justify-content: center; /* 가로 정렬 */
		    align-items: center; /* 세로 정렬 */
		    height: 10px; /* 원하는 높이를 설정 */
		    margin-top: 20px; /* 상단 여백 */
		}
		
		.search-container button {
			background-color: rgba(0, 77, 0, 0.8);
            border: none;
            padding: 5px 10px;
            border-radius: 5px;
            cursor: pointer;
        }
        
        .search-container input[type="text"] {
            padding: 5px 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }
        
        .search-bar {
		    display: flex;
		    align-items: center;
		    gap: 30px; /* 입력 필드와 버튼 간 간격 */
		}

		.route-creat{
        	float: right;
        	padding-right: 10%;
		}
		
		.route-creat button{
            height: 30px;
			background-color: rgba(0, 77, 0, 0.8);
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
            margin-left: 3%;
        }

        /* 카드 리스트 */
        .card-list {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 10px;
            justify-content: space-between; /* 양쪽 균등 정렬 */
		    margin: 0 5%; /* 왼쪽, 오른쪽 5% 여백 */
        }

        /* 카드 스타일 */
        .card {
            width: 300px;
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
            justify-content: space-between; /* 양쪽 균등 정렬 */
		    margin: 0 5%; /* 왼쪽, 오른쪽 7% 여백 */
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
        
        .see-more {
        	float: right;
        	color: #004d00;
        	padding-right: 3%;
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
		
			<!-- Hot 동선 섹션 -->
			<div>
			    <h2 class="section-title">❤️ Hot 동선</h2>
			    <div class="card-list">
			     	<c:forEach var="route" items="${hotRoutes}" varStatus="status">
				        <c:if test="${status.index < 4}">
			                <button class="card" onclick="location.href='/detail?seqRoute=${route.seq_route}'">
			                    <p class="card-title">${route.title}</p>                               
			                    <img src="${route.photo_url}" alt="${route.title}" width="100px" height="50px">
                                <p class="card-date">등록일:${route.createdAt}</p>
			                </button>
			            </c:if>
			        </c:forEach>
			    </div>
			    <br>
			    <a href="/main/hotList" class="see-more">더보기 ></a>
			</div>
			
			<!-- My Pinned Route 섹션 -->
			<c:if test="${isLoggedIn}">
				<c:if test="${not empty pinnedRoute}">
				    <div>
				        <h2 class="section-title">📌 My Pinned Route</h2>
				        <div class="pinned-route">
				            <button class="pinned-route-content" onclick="location.href='/detail?seqRoute=${pinnedRoute.seq_route}'">
				                
				                <p class="pinned-route-title">${pinnedRoute.title} 📍</p>                            
			                    <img src="${pinnedRoute.photo_url}" alt="${pinnedRoute.title}" width="100px" height="50px">
				                <p class="pinned-route-contents">${pinnedRoute.contents}</p>
				            </button>
				        </div>
				    </div>
				</c:if>
			</c:if>
			<c:if test="${empty pinnedRoute}">
				<h2 class="section-title">📌 My Pinned Route</h2>
				<div class="pinned-route">
		        	<p>등록된 Pinned Route가 없습니다.</p>
		        </div>
		    </c:if>
</body>
</html>