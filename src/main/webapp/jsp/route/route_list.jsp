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

        /* 카드 리스트 (결과 전체 컨테이너) */
		.card-list {
		    width: 90%;
		    display: flex;
		    flex-wrap: wrap;
		    gap: 20px;
		    margin-top: 10px;
		    justify-content: space-between; /* 양쪽 균등 정렬 */
		    margin: 0 5%; /* 왼쪽, 오른쪽 5% 여백 */
		}
		
		/* 개별 결과 리스트 컨테이너 (세로 분할) */
		.result-list-container {
		    display: flex;
		    flex-direction: row; /* 가로 정렬 */
		    width: 100%;
		    height: 200px; /* 각 카드 높이 */
		    border: 1px solid #ddd;
		    border-radius: 10px;
		    overflow: hidden;
		    background-color: #f9f9f9;
		    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
		}
		
		/* 왼쪽 영역 */
		.left {
		    flex: 7;
		    text-align: center;
		    padding: 20px;
		    display: flex;
		    flex-direction: column;
		    justify-content: center;
		}
		
		/* 오른쪽 영역 (이미지) */
		.right {
		    flex: 3;
		    text-align: center;
		    display: flex;
		    justify-content: right;
		    align-items: center;
		    padding-right: 1%;
		}
		
		.right img {
		    max-height: 90%;
		    border-radius: 10px;
		    object-fit: cover;
		    adding-right: 50%;
		}

        /* 카드 스타일 */
        .card {
            width: 100%;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            text-align: center;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .card img {
            width: 30%;
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
		                    <c:if test="${not empty route.photo_url}">
		                        <img src="${route.photo_url}" alt="${route.title} 사진">
		                    </c:if>
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
			    <button class="card"  onclick="location.href='/detail?seq_route=${route.seq_route}'">
			        <p><strong>${place.name}</strong></p>
			        <p class="card-title">주소: ${place.formatted_address}</p>
			        <p class="card-date">평점: ${place.rating}</p>
			        <img src="${place.photos.photo_url}" alt="${place.name} 사진">
			    </button>
			</c:forEach>
		</div>
		
</body>
</html>