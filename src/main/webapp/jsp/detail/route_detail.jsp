<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post Detail</title>
        <script src="https://maps.googleapis.com/maps/api/js?key=${sessionScope.API_KEY}&libraries=places"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/route_detail.css">
</head>
<body>
    <div class="container">
        <!-- Map placeholder -->
        <div class="map-container">
            <!-- Map will be inserted here -->
            <div id="map">
            
            
            </div>
        </div>

        <!-- Post header -->
        <div class="post-header">
            <div class="post-title">제목</div>
            <a href="/user/${MVO.seqMember}" class="user-nickname">${MVO.nickname}</a>
            <div class="post-actions">
                <a href="" class="pin-button">📌</a>
                <a href="" class="like-button">❤️</a>
            </div>
        </div>

        <!-- Restaurant cards -->
        <div class="restaurant-cards">
            <!-- <c:forEach items="${restaurants}" var="restaurant">
                <div class="restaurant-card">
                    <img src="${restaurant.image}" alt="${restaurant.name}" class="restaurant-image">
                    <div class="restaurant-info">
                        <h3>${restaurant.name}</h3>
                        <p class="hours">영업시간: ${restaurant.hours}</p>
                        <p class="address">${restaurant.address}</p>
                        <p class="category">${restaurant.category}</p>
                    </div>
                </div>
            </c:forEach>
             -->
            <div class="restaurant-card">
                    <img src="resources/images/tastehill.png" alt="img" class="restaurant-image">
                    <div class="restaurant-info">
                        <h3>짬뽕지존</h3>
                        <p class="hours">영업시간: 10:00 ~ 22:00</p>
                        <p class="address">분당구 원미동 뭐시기</p>
                        <p class="category">중식당</p>
                    </div>
                </div>
                <div class="restaurant-card">
                    <img src="resources/images/tastehill.png" alt="img" class="restaurant-image">
                    <div class="restaurant-info">
                        <h3>짬뽕지존</h3>
                        <p class="hours">영업시간: 10:00 ~ 22:00</p>
                        <p class="address">분당구 원미동 뭐시기</p>
                        <p class="category">중식당</p>
                    </div>
                </div>            
        </div>

        <!-- Post content -->
        <div class="post-content">
            Lorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a tLorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a tLorem Ipsum is simply dummy text of the printing and typesetting industry.
Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
when an unknown printer took a galley of type and scrambled it to make a t
        </div>

        <!-- Comment section -->
        <div class="comment-section">
            <!-- Comment form -->
            <div class="comment-form">
                <textarea id="content" placeholder="댓글을 작성해주세요"></textarea>
            	<button id="comment-submit">댓글 작성</button>
            </div>

            <!-- Comments list -->
            <div class="comments-list">
            
                <c:forEach items="${CLIST}" var="cvo">
                    <div class="comment">
                        <div class="comment-user">
                            <img src="/resources/images/tastehill.png" alt="프로필" class="profile-image">
                            <span class="comment-nickname">${cvo.nickname}</span>
                        </div>
                        <div class="comment-content">
                            ${cvo.contents}
                        </div>
                    </div>
                </c:forEach>
                <!-- 
                    <div class="comment">
                        <div class="comment-user">
                            <img src="resources/images/tastehill.png" alt="프로필" class="profile-image">
                            <span class="comment-nickname">nickname</span>
                        </div>
                        <div class="comment-content">
                            Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                        </div>
                    </div>
                -->
            </div>

            <!-- Pagination -->
            <div class="pagination">
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <a href="?page=${pageNum}" class="page-number ${currentPage == pageNum ? 'active' : ''}">${pageNum}</a>
                </c:forEach>
            </div>
        </div>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script>
	let map;
	let service;
	let currentPolyline = null;
	let res;

function initMap(res) {
	/* 루트VO 첫번째 장소 기준 플레이스 찍기 */
	console.log(res.places[0].place.location.lat);
    const center = { lat: res.places[0].place.location.lat, 
    			     lng: res.places[0].place.location.lng };
    map = new google.maps.Map(document.getElementById("map"), {
        center: center,
        zoom: 16,
        styles: [
            {
                "featureType": "poi",
                "elementType": "labels",
                "stylers": [{ "visibility": "off" }]
            },
            {
                "featureType": "landscape",
                "elementType": "labels.icon",
                "stylers": [{ "visibility": "off" }]
            }
        ]
    });
    service = new google.maps.places.PlacesService(map);
}
	
function displayPlace(place) {
/*   	console.log(place.location);
	console.log(place.location); */ 
 
 	var myLatlng = new google.maps.LatLng(place.location.lat, place.location.lng);
    const marker = new google.maps.Marker({
        map: map,
        position: myLatlng
    });
}

function markingPlace(results) {
        results.forEach(places => {
        	/* const placeClone = JSON.parse(JSON.stringify(place)); */
        	/* console.log(place); */
        	displayPlace(places.place);
        });
}

$( document ).ready(function() {
	
	/* 루트 정보 컨트롤러에 요청하는 부분 */
	 $.ajax({
	        url: "/detail/getRoute/" + ${seqRoute},
	        method: "GET",
	        dataType: "json",
	        success: function(response) {
	            /* console.log("경로 데이터:", response.places); */
	            res = JSON.parse(JSON.stringify(response));
	            /* console.log(res); */
	            initMap(res);
	            markingPlace(res.places);
	        },
	        error: function(error) {
	            console.error("에러 발생:", error);
	        }
	    });
	 
	 
	//$("#emp-btn").click( function() {
		
		/*
	    $.ajax({
	    	url  		: "/restctl/blist" ,
	    	method 		: 'POST' , 
	    	data 		: "uid=값&upw=값", 			
	    	//dataType 	: "json", 	
	    	success 	: function(obj) { 
	    					console.log("응답:" + obj);
	    					console.log("------------- $().map(function(i,v){})----------------");
	    					
	    					$("#empDiv").empty();
	    					var htmlStr = "<table class=blueTable>";
	    					htmlStr += "<tr><th>번호</th><th>제목</th><th>글쓴이</th></tr>";
	    					$(obj).map(function(i,v){ 
	    						//console.log(i + "," + v["bseq"] + "," + v.title + "," + v.regid);
	    						htmlStr += "<tr>";
	    						htmlStr += "<td>"+v.bseq+"</td>";
	    						htmlStr += "<td><a href='/myboard'>"+v.title+"</a></td>";
	    						htmlStr += "<td>"+v.regid+"</td>";
	    						htmlStr += "</tr>";
	    					});
	    					htmlStr += "</table>";
	    					$("#empDiv").html(htmlStr);
	    					
	    				  }   ,
	    	error 		: function(err) { console.log("에러:" + err) }  
	    });
	*/
	    
	
	$("#comment-submit").click( function() {  
	    seqRoute     = 1;
	    contents     = $("#content").val();
	    jsonObj = {"seqRoute" : seqRoute, "contents" : contents} 
	    jsonStr = JSON.stringify(jsonObj);
	    $.ajax({
	    	url  		: "/comments/insert" ,
	    	method 		: "POST" , 
	    	data 		:  jsonStr ,
	    	contentType : "application/json; charset=UTF-8", 
	    	dataType 	: "json",
	    	success: function(obj) {    //{"message":"okmap","status":"200"}
	    	    // 기존 댓글 목록 비우기
	    	    $(".comments-list").empty();
	    	    console.log("댓글 목록:", obj.clist); // 댓글 목록만 확인
	    	    
	    	    // 받아온 댓글 목록으로 새로 구성
	    	    obj.clist.forEach(function(cvo) {
	    	    	var newComment = '<div class="comment">';
	    	    	newComment += '<div class="comment-user">';
	    	    	newComment += '<img src="/resources/images/tastehill.png" alt="프로필" class="profile-image">';
	    	    	newComment += '<span class="comment-nickname">' + cvo.nickname + '</span>';
	    	    	newComment += '</div>';
	    	    	newComment += '<div class="comment-content">' + cvo.contents + '</div>';
	    	    	newComment += '</div>';

	    	        // 댓글 목록에 새로운 댓글 추가
	    	        $(".comments-list").append(newComment);
	    	    });
	    	    
	    	    // 입력 필드 초기화
	    	    $("#content").val("");
	    	},
	    	error : function(err) { console.log("에러:" + err) }  
	    });
	});
	

	
});

</script>
</body>
</html>