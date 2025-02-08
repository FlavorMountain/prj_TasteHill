<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>음식점 검색 및 경로 표시</title>
    <script src="https://maps.googleapis.com/maps/api/js?key=${sessionScope.API_KEY}&libraries=places"></script>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/map.css">
</head>
<body>
<div class="container">
    <div id="side-panel">
        <h2>Place Details</h2>
        <div id="place-name"></div>
        <div id="place-rating"></div>
        <div id="place-formatted_address"></div>
        <div id="place-opening_hours"></div>
        <div id="place-photos"></div>
    </div>
    
    <div id="map-container">
        <div class="controls" style="margin-top: 100px;" >
        
            <button class="control-btn" onclick="searchPlaces()">주변 음식점 검색</button>
            <button class="control-btn" onclick="drawRoute()">경로 그리기</button>
        </div>
        <div id="map"></div>
        
        <!-- 순서 변경된 부분 -->
        <div id="selected-list-container">
            <div class="post-title-section">
                <div class="form-group">
                    <input type="text" id="post-title" class="form-control" maxlength="100" 
                     placeholder="제목을 입력해주세요">
                    <span class="error-message" id="title-error"></span>
                </div>
            </div>
            
            <div class="selected-places-section">
                <h3>선택된 음식점 목록</h3>
            </div>
            
			<div class="selected-places-section">
                <ul id="selected-list"></ul>
            </div>
            
            <div class="post-content-section">
                <div class="form-group">
                    <textarea id="post-content" class="description"
                    placeholder="동선에 대해서 설명해주세요"></textarea>
                    <span class="error-message" id="content-error"></span>
                </div>
                <button class="submit-btn" onclick="validateAndSend()">리스트 전송</button>
            </div>
        </div>
    </div>
</div>

    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <script>
        let map;
        let service;
        let infowindow;
        let selectedPlaces = [];
        let markers = [];
        let currentPolyline = null;

         /* function getPlaceDetail(){
       	 $.ajax({
       	        url: "/route/getRoute/" + ${RVO.seq_route},
       	        method: "GET",
       	        dataType: "json",
       	        success: function(response) {
       	            res = JSON.parse(JSON.stringify(response));
       	            initMap(res);
       	            markingPlace(res.places);
       	        },
       	        error: function(error) {
       	            console.error("에러 발생:", error);
       	        }
       	    });
        }  */
        
        initMap();
        
        function initMap() {
        	/* 오리역 좌표 */
            const center = { lat: 37.339, lng: 127.109 };
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
            
            // 맵 클릭 이벤트에 사이드패널 닫기 추가
            google.maps.event.addListener(map, 'click', function() {
                closeSidePanel();
            });
            
            infowindow = new google.maps.InfoWindow();
            service = new google.maps.places.PlacesService(map);
        }
        
       

        function searchPlaces() {
/*             if (currentPolyline) {
                currentPolyline.setMap(null);
            }
            markers.forEach(marker => marker.setMap(null));
            markers = []; */
            
            const request = {
                location: map.getCenter(),
                rankBy: google.maps.places.RankBy.DISTANCE,
                keyword: 'restaurant OR cafe OR bakery OR food'
            };

            service.nearbySearch(request, placesCallback);
        }

        function placesCallback(results, status) {
        	/* console.log(results); */
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                results.forEach(place => displayPlace(place));
            } else {
                alert("검색 결과를 가져오는데 실패했습니다.");
            }
        }

        function displayPlace(place) {
            const marker = new google.maps.Marker({
                map: map,
                position: place.geometry.location,
            });
            
            marker.set('placeData', place);
            markers.push(marker);
            /* console.log(markers); */
            
            marker.addListener("click", ({ domEvent, latLng }) => {
                const { target } = domEvent;
                const placeData = marker.get('placeData');
                const placeId = placeData.place_id;
                
                $.ajax({
                    url: '/place/' + placeId,
                    method: 'GET',
                    dataType: 'json',
                    success: function(response) {
                        infowindow.setContent(
                            '<div style="padding:5px;font-size:12px;">' +
                            '<strong>' + response.result.name + '</strong><br>' +
                            '별점: ' + (response.result.rating || "없음") + '<br>' +
                            '<button onclick="addPlaceToList(\'' + placeId + '\')">선택</button>' +
                            '</div>'
                        );
                        infowindow.open(map, marker);
                        
                        // 사이드패널 내용 업데이트
                        $('#place-name').html('<h3>' + response.result.name + '</h3>');
                        $('#place-rating').html('<p><strong>평점:</strong> ' + 
                            (response.result.rating ? response.result.rating + ' / 5.0' : '평점 없음') + '</p>');
                        $('#place-formatted_address').html('<p><strong>주소:</strong><br>' + 
                            response.result.formatted_address + '</p>');
                        //console.log(response.result.opening_hours);
                        if (response.result.opening_hours && response.result.opening_hours.weekday_text) {
                            let openingHoursHTML = '<p><strong>영업시간:</strong><br>';
                            response.result.opening_hours.weekday_text.forEach(day => {
                                openingHoursHTML += day.weekday_text + '<br>';
                            });
                            openingHoursHTML += '</p>';
                            $('#place-opening_hours').html(openingHoursHTML);
                        } else {
                            $('#place-opening_hours').html('<p><strong>영업시간:</strong><br>정보 없음</p>');
                        }
                        
                        if (response.result.photos && response.result.photos.length > 0) {
                            let photoHTML = '<div><strong>사진:</strong><br>';
                            response.result.photos.forEach(img => {
                                photoHTML += '<img src="' + img.photo_url + 
                                    '" alt="장소 사진" class="place-photo">';
                            });
                            photoHTML += '</div>';
                            $('#place-photos').html(photoHTML);
                        } else {
                            $('#place-photos').html('<p><strong>사진:</strong><br>사진 없음</p>');
                        }
                        
                        openSidePanel();
                    },
                    error: function(xhr, status, error) {
                        console.error('Error fetching place details:', status, error);
                        alert('장소 정보를 가져오는데 실패했습니다.');
                    }
                });
            });
        }

        function openSidePanel() {
            document.getElementById('side-panel').classList.add('active');
        }

        function closeSidePanel() {
            document.getElementById('side-panel').classList.remove('active');
        }

        function addPlaceToList(Id) {
        	console.log('addPlace 호출!');
            if (!Id) {
                console.error('placeId가 없습니다');
                return;
            }

            if (selectedPlaces.some(p => p.place_id === Id)) {
                alert("이미 선택된 장소입니다.");
                return;
            }

            var request = {
                placeId: Id,
                fields: ['name', 'place_id', 'geometry', 'rating']
            };

            
            $.ajax({
    	        url: "/place/" + Id,
    	        method: "GET",
    	        dataType: "json",
    	        success: function(response) {
    	            res = JSON.parse(JSON.stringify(response));
/*     	            console.log(res); */
    	            selectedPlaces.push(res);
    	            updateSelectedListUI(res); 
    	        },
    	        error: function(error) {
    	            console.error("에러 발생:", error);
    	        }
    	    });
            
         
        }
        
        function updateSelectedListUI(place) {
            const list = document.getElementById("selected-list");
            list.innerHTML = "";

            selectedPlaces.forEach((place, index) => {
            	console.log(place);
                const item = document.createElement("li");
                item.setAttribute("data-place-id", place.result.place_id);
                
                // 장소 정보를 포함하는 div 생성
                const placeInfo = document.createElement("div");
                placeInfo.className = "place-info";
                
                // 장소 번호와 이름
                const nameElement = document.createElement("div");
                nameElement.className = "place-name";
                nameElement.textContent = (index + 1) + ". " + (place.result.name || "이름 없음");
                // 장소 상세 정보
                const detailsElement = document.createElement("div");
                detailsElement.className = "place-details";
                detailsElement.innerHTML = 
                    (place.result.rating ? '<div>평점: ' + place.result.rating + '</div>' : '') +
                    '<button onclick="removePlace(' + index + ')" class="remove-btn">제거</button>';
                
                    const photoElement = document.createElement("div");
                    photoElement.className = "place-photo";  

                    if (place.result.photos && place.result.photos.length > 0) {
                        const photoUrl = place.result.photos[0].photo_url; 
                        photoElement.innerHTML = '<img src="' + photoUrl + '" alt="장소 이미지" height = "300" width="400">';
                    } else {
                        photoElement.innerHTML = "<div>이미지 없음</div>"; 
                    }


                
                // 요소들을 조립
                placeInfo.appendChild(nameElement);
                placeInfo.appendChild(detailsElement);
                placeInfo.appendChild(photoElement);
                item.appendChild(placeInfo);
                list.appendChild(item);
            });
        }
        
        function sendSelectedList() {
            const listItems = document.querySelectorAll("#selected-list li");
            const selectedData = {
                places: [],
                title: document.getElementById("post-title").value.trim(),
                contents: document.getElementById("post-content").value.trim()
            };
            
            listItems.forEach(item => {
                selectedData.places.push({
                    place_id: item.getAttribute("data-place-id"),
                    name: item.textContent.replace(/제거$/, '').trim()
                });
            });

            /* console.log(selectedData); */

            // 로딩 상태 표시
            const submitBtn = document.querySelector('.submit-btn');
            submitBtn.textContent = '저장 중...';
            submitBtn.disabled = true;

            fetch("/route/insertRoute", {
                method: "POST",
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(selectedData)
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url; // 서버에서 보낸 redirect 주소로 이동
                } else {
                    throw new Error('리다이렉트되지 않았습니다.');
                }
            })
            .catch(error => {
                console.error("전송 중 오류 발생:", error);
                alert("저장 중 오류가 발생했습니다. 다시 시도해주세요.");
                submitBtn.textContent = '리스트 전송';
                submitBtn.disabled = false;
            });
        }


        function removePlace(index) {
            selectedPlaces.splice(index, 1);
            updateSelectedListUI();
            if (currentPolyline) {
                currentPolyline.setMap(null);
                currentPolyline = null;
            }
        }

        function drawRoute() {
            if (selectedPlaces.length < 2) {
                alert("2개 이상의 장소를 선택해야 경로가 그려집니다.");
                return;
            }

            if (currentPolyline) {
                currentPolyline.setMap(null);
            }

            const origin = selectedPlaces[0].geometry.location;
            const destination = selectedPlaces[selectedPlaces.length - 1].geometry.location;
            const waypoints = selectedPlaces.slice(1, selectedPlaces.length - 1).map(place => place.geometry.location);
            const path = [origin, ...waypoints, destination];

            currentPolyline = new google.maps.Polyline({
                path: path,
                geodesic: true,
                strokeColor: '#FF0000',
                strokeOpacity: 1.0,
                strokeWeight: 2
            });

            currentPolyline.setMap(map);
        }
        
        // 글작성하고 유효성 검사하는 부분
        function validateForm() {
            let isValid = true;
            const title = document.getElementById("post-title").value.trim();
            const content = document.getElementById("post-content").value.trim();
            const selectedPlacesCount = document.querySelectorAll("#selected-list li").length;
            
            // 제목 검사
            if (title === "") {
                document.getElementById("title-error").textContent = "제목을 입력해주세요.";
                isValid = false;
            } else if (title.length < 2) {
                document.getElementById("title-error").textContent = "제목은 2자 이상이어야 합니다.";
                isValid = false;
            } else {
                document.getElementById("title-error").textContent = "";
            }
            
            // 내용 검사
            if (content === "") {
                document.getElementById("content-error").textContent = "내용을 입력해주세요.";
                isValid = false;
            } else if (content.length < 10) {
                document.getElementById("content-error").textContent = "내용은 10자 이상이어야 합니다.";
                isValid = false;
            } else {
                document.getElementById("content-error").textContent = "";
            }
            
            // 선택된 장소 검사
            if (selectedPlacesCount === 0) {
                alert("최소 1개 이상의 장소를 선택해주세요.");
                isValid = false;
            }
            
            return isValid;
        }

        // 입력 필드 이벤트 리스너 추가
        document.getElementById("post-title").addEventListener("input", function() {
            if (this.value.trim().length >= 2) {
                document.getElementById("title-error").textContent = "";
            }
        });

        document.getElementById("post-content").addEventListener("input", function() {
            if (this.value.trim().length >= 10) {
                document.getElementById("content-error").textContent = "";
            }
        });
        
     // 유효성 검사 후 전송하는 함수
        function validateAndSend() {
            if (validateForm()) {
                sendSelectedList();
            }
        }
    </script>
</body>
</html>