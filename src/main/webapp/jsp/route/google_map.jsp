<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../index.jsp" %>
<%@ taglib prefix="c" 	uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" 	uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" 	uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="x" 	uri="http://java.sun.com/jsp/jstl/xml" %>
<%@ taglib prefix="sql" 	uri="http://java.sun.com/jsp/jstl/sql" %>

<!DOCTYPE html>
<jsp:include page="/../../index.jsp"></jsp:include>

<html>
<head>
    <meta charset="UTF-8">
    <title>음식점 검색 및 경로 표시</title>
<!--     <link rel="stylesheet" href="/resources/css/map.css">-->    <!-- Google Maps API (콜백으로 initMap 설정) -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA06Z3OZN-CwxfhTn9GysGqAMHsSMahDAY&libraries=places&callback=initMap" async defer></script>
</head>
<body>
    <div class="controls">
        <button onclick="searchPlaces()">주변 음식점 검색</button>
        <button onclick="drawRoute()">경로 그리기</button>
    </div>
    
    <div id="map" style="width: 100%; height: 500px;"></div>
    
    <div id="selected-list-container">
        <h3>선택된 음식점 목록</h3>
        <ul id="selected-list"></ul>
    </div>

    <script>
        let map;
        let service;
        let infowindow;
        let selectedPlaces = [];
        let markers = [];
        let currentPolyline = null;

         function initMap() {
            const center = { lat: 37.339, lng: 127.109 }; // 오리역 좌표
            map = new google.maps.Map(document.getElementById("map"), {
                center: center,
                zoom: 15,
                styles: [
                    {
                        "featureType": "poi",
                        "elementType": "labels",
                        "stylers": [
                            {
                                "visibility": "off" // POI 정보 숨기기
                            }
                        ]
                    },
                    {
                        "featureType": "landscape",
                        "elementType": "labels.icon",
                        "stylers": [
                            {
                                "visibility": "off" // 아이콘 숨기기
                            }
                        ]
                    }
                ]
            });
            infowindow = new google.maps.InfoWindow();
            service = new google.maps.places.PlacesService(map);
        }

        
        // 주변 음식점 검색
        function searchPlaces() {
            if (currentPolyline) {
                currentPolyline.setMap(null);
            }
            markers.forEach(marker => marker.setMap(null));
            markers = [];

            const request = {
                location: map.getCenter(),
                radius: "3000",
                type: ["restaurant"] // 음식점 검색
            };

            service.nearbySearch(request, placesCallback);
        }

        // Places API 호출결과 콜백
        function placesCallback(results, status) {
            if (status === google.maps.places.PlacesServiceStatus.OK) {
                results.forEach(place => {
                	// console.log(place);
                    displayPlace(place);
                });
            } else {
                alert("검색 결과를 가져오는데 실패했습니다.");
            }
        }

        // 장소 표시 및 마커 추가
        function displayPlace(place) {
            const marker = new google.maps.Marker({
                map: map,
                position: place.geometry.location,
            });

            markers.push(marker);
			/* console.log(marker); */
            google.maps.event.addListener(marker, "click", () => {
                // const escapedPlace = JSON.stringify(place)
                //     .replace(/'/g, "&#39;")
                //     .replace(/"/g, "&quot;");
                console.log(place);
                console.log(place.place_id);
                console.log(getPlaceDetails(place.place_id));
                
                infowindow.setContent(
                    `<div style="padding:5px;font-size:12px;">
                        <strong>${place.name}</strong><br>
                        별점: ${place.rating || "없음"}<br>
                        <button onclick="addPlaceToListFromClick('${place}')">선택</button>
                    </div>`
                );

                infowindow.open(map, marker);
            });
        }

        // 선택된 장소 리스트에 추가
        function addPlaceToListFromClick(place) {
            addPlaceToList(place);
        }

        function addPlaceToList(place) {
            if (selectedPlaces.some(p => p.place_id === place.place_id)) {
                alert("이미 선택된 장소입니다.");
                return;
            }

            selectedPlaces.push(place);
            updateSelectedListUI();
        }

        // 선택된 장소 리스트에서 제거
        function removePlace(index) {
            selectedPlaces.splice(index, 1);
            updateSelectedListUI();
            if (currentPolyline) {
                currentPolyline.setMap(null);
            }
        }

        // 선택된 장소 UI 업데이트
        function updateSelectedListUI() {
            const list = document.getElementById("selected-list");
            list.innerHTML = "";

            selectedPlaces.forEach((place, index) => {
                const item = document.createElement("li");
                item.innerHTML = `${index + 1}: ${place.name} 
                    <button onclick="removePlace(${index})">제거</button>`;
                list.appendChild(item);
            });
        }

        // 경로 생성
        function drawRoute() {
            if (selectedPlaces.length < 2) {
                alert("2개 이상의 장소를 선택해야 경로가 그려집니다.");
                return;
            }

            if (currentPolyline) {
                currentPolyline.setMap(null);
            }

            const directionsService = new google.maps.DirectionsService();
            const directionsRenderer = new google.maps.DirectionsRenderer({
                map: map,
                suppressMarkers: true,
            });

            const waypoints = selectedPlaces.slice(1, -1).map(place => ({
                location: { placeId: place.place_id },
                stopover: true,
            }));

            const request = {
                origin: { placeId: selectedPlaces[0].place_id },
                destination: {
                    placeId: selectedPlaces[selectedPlaces.length - 1].place_id,
                },
                waypoints: waypoints,
                travelMode: google.maps.TravelMode.DRIVING,
            };

            directionsService.route(request, (result, status) => {
                if (status === google.maps.DirectionsStatus.OK) {
                    directionsRenderer.setDirections(result);
                    currentPolyline = directionsRenderer.getPolyline();
                } else {
                    console.error("Failed to generate route:", status);
                    alert("경로를 생성하는데 실패했습니다.");
                }
            });
        }
    </script>
</body>
</html>
