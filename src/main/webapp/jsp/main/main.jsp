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
    </style>
</head>
<body>
		<!-- 검색 바 -->
		<jsp:include page="${searchBar}" />
		 
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
			                <button class="card" onclick="location.href='/detail?seq_route=${route.seq_route}'">
			                    <p class="card-title">${route.title}</p>                               
			                    <img src="${route.photo_url}" alt="${route.title}" width="100px" height="50px">
                                <p class="card-date">등록일:${route.createdAt}</p>
			                </button>
			            </c:if>
			        </c:forEach>
			    </div>
			    <br>
			    <a href="/hotList" class="see-more">더보기 ></a>
			</div>
			
			<!-- My Pinned Route 섹션 -->
			<c:if test="${isLoggedIn}">
				<c:choose>			
					<c:when test="${not empty pinnedRoute}">
					    <div>
					        <h2 class="section-title">📌 My Pinned Route</h2>
					        <div class="pinned-route">
					            <button class="pinned-route-content" onclick="location.href='/detail?seq_route=${pinnedRoute.seq_route}'">
					                
					                <p class="pinned-route-title">${pinnedRoute.title} 📍</p>                            
				                    <img src="${pinnedRoute.photo_url}" alt="${pinnedRoute.title}" width="100px" height="50px">
					                <p class="pinned-route-contents">${pinnedRoute.contents}</p>
					            </button>
					        </div>
					    </div>
					</c:when>
							
					<c:otherwise>
						<h2 class="section-title">📌 My Pinned Route</h2>
						<div class="pinned-route">
				        	<p>등록된 Pinned Route가 없습니다.</p>
				        </div>
				    </c:otherwise>
			    </c:choose>
			  </c:if>
</body>
</html>