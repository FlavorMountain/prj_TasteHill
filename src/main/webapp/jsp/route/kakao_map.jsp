<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="../../index.jsp" %>
<%-- <jsp:include page="../../index.jsp" /> --%>
<html>
<head>
    <meta charset="UTF-8">
    <title>음식점 검색 및 경로 표시</title>
    <link rel="stylesheet" href="/resources/css/map.css">
</head>
<body>
    <div class="controls">
        <button onclick="searchPlaces()">주변 음식점 검색</button>
        <button onclick="drawRoute()">경로 그리기</button>
    </div>
    
    <div id="map"></div>
    
    <div id="selected-list-container">
        <h3>선택된 음식점 목록</h3>
        <ul id="selected-list"></ul>
    </div>
    
    
<!--     <div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	    <ul id="category">
	        <li id="CE7" data-order="0"> 
	            <span class="category_bg cafe"></span>
	            카페
	        </li>  
	        <li id="CS2" data-order="1"> 
	            <span class="category_bg restaurant"></span>
	            식당
	        </li>      
	    </ul>
	</div> -->
    
    <!-- 카카오맵 기능 가져오기 -->
    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=MY_APP_KEY=false&libraries=services"></script>
    <script>
    kakao.maps.load(function () {
        var mapContainer = document.getElementById('map');
        var mapOption = {
        	/* LatLng에 위도, 경도를 넣어서 좌표 입력, 현재 오리역 위경도 입력 */
            center: new kakao.maps.LatLng(37.339, 127.109),
            level: 3
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var ps = new kakao.maps.services.Places();
        var selectedPlaces = [];
        var markers = [];
        var currentPolyline = null;

        window.searchPlaces = function () {
            markers.forEach(marker => marker.setMap(null));
            markers = [];

            if (currentPolyline) {
                currentPolyline.setMap(null);
            }

            /* 해당 부분의 카테고리를 변경해서 여러 장소 검색 기능 */
            ps.categorySearch('FD6', placesCallback, {
                location: map.getCenter(),
                radius: 3000
            });
        };

        function placesCallback(data, status) {
            if (status === kakao.maps.services.Status.OK) {
                displayPlaces(data);
            } else {
                alert('검색 결과를 가져오는데 실패했습니다.');
            }
        }

        /* 여기서 장소 하나씩 나옴 */
        function displayPlaces(places) {
            places.forEach(place => {
            	/* 장소 데이터 json 로그로 확인하기 */
            	console.log(place);
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: new kakao.maps.LatLng(place.y, place.x)
                });

                markers.push(marker);

                /* 생성된 마커를 클릭하면 나올 정보창, 이름, url 등의 정보를 넣음 */
                /* 마커 클릭시 맵 영역 왼쪽부터 1/3까지 영역에 카카오맵 장소 상세 페이지 띄워주기 */
                var infowindow = new kakao.maps.InfoWindow({
                    content: '<div style="padding:5px;font-size:12px;">' +
                        /* place.place_name + */
                        '<br><a href="'+ place.place_url + '" target="_blank">' + place.place_name + '</a>' +
                        '<br><button onclick="addPlaceToList(' +
                        JSON.stringify(place).replace(/"/g, '&quot;') +
                        ')">선택</button>' + '</div>'
                });

                kakao.maps.event.addListener(marker, 'click', function () {
                    infowindow.open(map, marker);
                });
            });
        }

        window.addPlaceToList = function (place) {
            if (selectedPlaces.some(p => p.id === place.id)) {
                alert('이미 선택된 장소입니다.');
                return;
            }

            // console.log('updateSelectedListUI 호출');
            selectedPlaces.push(place);
            updateSelectedListUI();
        };

        window.removePlace = function (index) {
            selectedPlaces.splice(index, 1);
            updateSelectedListUI();
            if (currentPolyline) {
                currentPolyline.setMap(null);
            }
        };

        /* 문제가 되는 부분 */
    function updateSelectedListUI() {
        	
            var list = document.getElementById('selected-list');
            list.innerHTML = '';
            
            selectedPlaces.forEach((place, index) => {
                var idx = index;
            	console.log(idx);
                var name = place.place_name;
            	console.log(name);
                var item = document.createElement('li');
                list.innerHTML = `<li>${index + 1}: ${name} 
                 <button onclick="removePlace(${index})">제거</button></li>`;
                list.appendChild(item);
            });
        } 
        
        // function updateSelectedListUI() {
        //     var list = document.getElementById('selected-list');
        //     list.innerHTML = '';
        //     selectedPlaces.forEach((place, index) => {
        //         var item = document.createElement('li');
        //         var idx = index;
        //         var name = place.place_name;
        //         console.log(name);
        //         var textNode = document.createTextNode(`${name}`);
        //         var button = document.createElement('button');
        //         button.textContent = '제거';
        //         button.onclick = function () {
        //             removePlace(index);
        //         };

        //         item.appendChild(textNode);
        //         item.appendChild(button);
        //         list.appendChild(item);
        //     });
        // }


        window.drawRoute = function () {
            if (selectedPlaces.length < 2) {
                alert('2개 이상의 장소를 선택해야 경로가 그려짐.');
                return;
            }

            if (currentPolyline) {
                currentPolyline.setMap(null);
            }

            var linePath = selectedPlaces.map(place =>
                new kakao.maps.LatLng(place.y, place.x)
            );

            currentPolyline = new kakao.maps.Polyline({
                path: linePath,
                strokeWeight: 5,
                strokeColor: '#FF0000',
                strokeOpacity: 0.7
            });

            currentPolyline.setMap(map);
        };
    });
    </script>
    
    <!-- ajax로 카카오맵에서 넘어온 데이터 컨트롤러로 넘겨주기 -->
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
    $( document ).ready(function() {
    	console.log("test");
    		
/*     		$("#4_string-json-btn").click( function() {  
    		    var uid = $("#uid").val();
    		    var upw = $("#upw").val();
    		    var resturl	= "/restcl/test4/"+uid+"/"+upw;
    		    alert(resturl);
    		    
    		    var sendFormData = $("#4_string-jsonstring-form").serialize();
    		    alert(sendFormData);
    		    
    			  $.ajax({
    					url			: resturl,
    			    	method 		: 'POST' , 
    			    	data 		: sendFormData ,
    			    	//data 		: "uid="+userid+"&upw="+userpw , 			
    			    	//contentType : "application/x-www-form-urlencoded; charset=UTF-8", 
    			    	//dataType 	: "String", 	
    			    	success 	: function(jsonStr) {
    			    					console.log("응답:" + jsonStr) 
    			    					console.log(jsonStr['message']);
    					    			console.log(jsonStr['status']);
    			    				  }   ,
    			    	error 		: function(err) { console.log("에러:" + err) }  
    			    });
    		}); */
    	});
    </script>
</body>
</html>
