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
	<script src="https://kit.fontawesome.com/7a7c0970b6.js" crossorigin="anonymous"></script>
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
        	<input type="hidden" class="seq_route" value="${RVO.seq_route}" >
            <div class="post-title">제목</div>
            <div class="user-nickname">${MVO.nickname}</div>
            <a href="/newchat/${MVO.seqMember}"><i class="fa-solid fa-comment" style="color: #26473c;"></i></a>
            
            <div class="post-actions">
	            <div class = "pin-buttons">
		            <button type="button" class="pin-button">
			            <c:if test="${MVO.pinnedRoute == RVO.seq_route}"><i class="fa-solid fa-star" style="color: yellow;"></i></c:if>
			            <c:if test="${MVO.pinnedRoute != RVO.seq_route}"><i class="fa-solid fa-star"></i></c:if>
		            </button>
		        </div>
		        <div class="fork-buttons">
	                <button type="button" class="like-button">
	                	<c:if test="${not empty FVO.seqRoute}"><i class="fa-solid fa-heart" style="color: red;"></i></c:if>
	                	<c:if test="${empty FVO.seqRoute}"><i class="fa-solid fa-heart"></i></c:if>
	                </button>
                </div>
            </div>
        </div>

        <!-- Restaurant cards -->
        <div class="restaurant-cards">
            <c:forEach items="${RVO.places}" var="place">
                <div class="restaurant-card">
                	<div class="restaurant-img-size">
                		<c:if test="${not empty place.place.photos.photo_url}"><img src="${place.place.photos.photo_url}" alt="${place.place.name}" class="restaurant-image"></c:if>
                    	<c:if test="${empty place.place.photos.photo_url}"><img src="/resources/images/default-img.jpg" alt="${place.place.name}" class="restaurant-image"></c:if>
                    </div>
                    <div class="restaurant-info">
                        <h3>${place.place.name}</h3>
                        <p class="hours">${place.place.rating}</p>
                        <p class="address">${place.place.formatted_address}</p>
                    </div>
                </div>
            </c:forEach>    
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
                        	<c:if test="${empty cvo.profile}">
                            	<img src="/resources/images/tastehill.png" alt="프로필" class="profile-image">
                            </c:if>
                            <c:if test="${not empty cvo.profile}">
                            	<img src="${cvo.profile}" alt="프로필" class="profile-image">
                            </c:if>
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
	let seqRoute     = $(".seq_route").val();
	/* 루트 정보 컨트롤러에 요청하는 부분 */
	 $.ajax({
	        url: "/detail/getRoute/" + ${RVO.seq_route},
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
	
	$("#comment-submit").click( function() {  
	    
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

//pin-button 클릭 이벤트
$(document).on('click', '.pin-button', function() {
    $.ajax({
        url: "/pinroute?seqRoute=" + ${RVO.seq_route},
        method: "GET",
        dataType: "json",
        success: function(response) {
            if(response.message) {
                let newButton = $('<button>', {
                    type: 'button',
                    class: 'pin-button'
                }).append(
                    response.pin ? 
                    $('<i>', {
                        class: 'fa-solid fa-star',
                        style: 'color: yellow;'
                    }) :
                    $('<i>', {
                        class: 'fa-solid fa-star'
                    })
                );
                
                $('.pin-buttons').empty().append(newButton);
            } else {
                alert("로그인 해주세요");
            }
        },
        error: function(error) {
            console.error("에러 발생:", error);
        }
    });
});

// like-button 클릭 이벤트
$(document).on('click', '.like-button', function() {
    $.ajax({
        url: "/forkroute?seqRoute=" + ${RVO.seq_route},
        method: "GET",
        dataType: "json",
        success: function(response) {
            if(response.message) {
                let newButton = $('<button>', {
                    type: 'button',
                    class: 'like-button'
                }).append(
                    response.fork ? 
                    $('<i>', {
                        class: 'fa-solid fa-heart',
                        style: 'color: red;'
                    }) :
                    $('<i>', {
                        class: 'fa-solid fa-heart'
                    })
                );
                
                $('.fork-buttons').empty().append(newButton);
            } else {
                alert("로그인 해주세요");
            }
        },
        error: function(error) {
            console.error("에러 발생:", error);
        }
    });
});

</script>
</body>
</html>