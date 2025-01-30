<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../index.jsp" %>
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
</head>
<body>

<div id="place-details">
        <h2>Place Details:</h2>
        <p id="place-name"></p>
        <p id="place-rating"></p>
        <p id="place-location"></p>
    </div>

    <div class="controls">
        <button onclick="searchPlaces()">주변 음식점 검색</button>
        <button onclick="drawRoute()">경로 그리기</button>
    </div>
    
    <div id="map" style="width: 100%; height: 500px;"></div>
    
    <div id="selected-list-container">
        <h3>선택된 음식점 목록</h3>
        <ul id="selected-list"></ul>
    </div>
    
    
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>

    <script>
        let map;
        let service;
        let infowindow;
        let selectedPlaces = [];
        let markers = [];
        let currentPolyline = null;

        initMap();
        function initMap() {
            const center = { lat: 37.339, lng: 127.109 }; // 오리역 좌표
            map = new google.maps.Map(document.getElementById("map"), {
                center: center,
                zoom: 15,
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
            infowindow = new google.maps.InfoWindow();
            service = new google.maps.places.PlacesService(map);
        }

        function searchPlaces() {
            if (currentPolyline) {
                currentPolyline.setMap(null);
            }
            markers.forEach(marker => marker.setMap(null));
            markers = [];
            
            const request = {
                location: map.getCenter(),
                radius: 3000, // 검색 반경을 5km로 설정
                type: 'food' // 음식점 검색
/*                 ,keyword: "food" // 추가 키워드로 검색 확장 */
            };
            
            /* console.log(request); */

            service.nearbySearch(request, placesCallback);
        }

        function placesCallback(results, status) {
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
            
            marker.addListener("click", ({ domEvent, latLng }) => {
            	const { target } = domEvent;
            	const placeData = marker.get('placeData');
            	const name = placeData.name;
            	const rating = placeData.rating;
            	const placeId = placeData.place_id;
            	
            	
            	$.ajax({
                     url: '/route/' + placeId,
                     method: 'GET',
                     dataType: 'json',
                     success: function(response) {
                     	infowindow.setContent(
                    		    '<div style="padding:5px;font-size:12px;">' +
                    		    '<strong>' + name + '</strong><br>' +
                    		    '별점: ' + (rating || "없음") + '<br>' +
                    		    '<button onclick="addPlaceToList(\'' + placeId + '\')">선택</button>' +
                    		    '</div>'
                    		);
                        infowindow.open(map, marker);
                        
                        // infowindow가 열린 후, DOM이 준비되면 버튼에 이벤트 리스너를 추가
                        google.maps.event.addListenerOnce(infowindow, 'domready', () => {
                            const selectButton = document.getElementById('selectButton');
                        });
                    	 
                    	 
                    	 
                         console.log(response); // 디버깅용
                         // Response 데이터를 HTML에 표시
                         $('#place-name').text('Name: ' + response.result.name);
                         $('#place-rating').text('Rating: ' + response.result.rating);
                         $('#place-location').text('Location: ' + 
                             response.result.geometry.location.lat + ', ' + 
                             response.result.geometry.location.lng);
                     },
                     
                     error: function(xhr, status, error) {
                         console.error('Error fetching place details:', status, error);
                         alert('Failed to fetch place details.');
                     }
                 });
            	
            });
        }

        
        function addPlaceToList(Id) {
        	console.log(Id + 'asdasdasdasdasdasdasasdsda');
            if (!Id) {
                console.error('placeId가 없습니다');
                return;
            }

            if (selectedPlaces.some(p => p.place_id === Id)) {
                alert("이미 선택된 장소입니다.");
                return;
            }

            // 요청 객체
            var request = {
                placeId: Id,  // Id를 전달
                fields: ['name', 'place_id', 'geometry', 'rating']
            };

            // PlacesService 객체 생성
            var service = new google.maps.places.PlacesService(map);

            // getDetails 메서드 호출
            service.getDetails(request, function(place, status) {
                console.log('Places API Response:', place);  // API 응답 확인
                console.log('Status:', status);  // 응답 상태 확인

                // 상태가 OK인 경우에만 장소 정보를 처리
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    selectedPlaces.push(place);
                    updateSelectedListUI(place);
                } else {
                    alert("선택한 장소 정보를 불러오는데 실패했습니다.");
                    console.error('Places API Error:', status);
                }
            });
        }



        function updateSelectedListUI(place) {
            const list = document.getElementById("selected-list");
            list.innerHTML = "";

            selectedPlaces.forEach((place, index) => {
                console.log(place.name + 'asd');
                const item = document.createElement("li");
                
                item.innerHTML = index + 1 + ": " + (place.name || "이름 없음") + 
                                 " <button onclick=\"removePlace(" + index + ")\">제거</button>";
                list.appendChild(item);
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

            // 시작점과 끝점의 좌표를 가져옵니다
            const origin = selectedPlaces[0].geometry.location;
            const destination = selectedPlaces[selectedPlaces.length - 1].geometry.location;

            // 중간 경유지들의 좌표를 가져옵니다 (첫 번째와 마지막 제외)
            const waypoints = selectedPlaces.slice(1, selectedPlaces.length - 1).map(place => place.geometry.location);

            // 시작점, 중간 경유지들, 끝점의 좌표를 하나의 배열로 합칩니다
            const path = [origin, ...waypoints, destination];

            // Polyline 객체 생성
            currentPolyline = new google.maps.Polyline({
                path: path,
                geodesic: true,  // 지구상의 직선 경로를 따른다고 설정
                strokeColor: '#FF0000',  // 경로 색상
                strokeOpacity: 1.0,  // 경로 불투명도
                strokeWeight: 2  // 경로의 굵기
            });

            // 맵에 경로 표시
            currentPolyline.setMap(map);
        }


    </script>
</body>
</html>
