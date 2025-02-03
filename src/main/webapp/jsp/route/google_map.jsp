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
            <div class="controls">
                <button onclick="searchPlaces()">주변 음식점 검색</button>
                <button onclick="drawRoute()">경로 그리기</button>
            </div>
            <div id="map"></div>
            <div id="selected-list-container">
                <h3>선택된 음식점 목록</h3>
                <ul id="selected-list"></ul>
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

        initMap();
        
        function initMap() {
        	/* 오리역 좌표 */
            const center = { lat: 37.339, lng: 127.109 };
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
                const placeId = placeData.place_id;
                
                $.ajax({
                    url: '/route/' + placeId,
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
                        console.log(response.result.opening_hours);
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

            var service = new google.maps.places.PlacesService(map);

            service.getDetails(request, function(place, status) {
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
    </script>
</body>
</html>