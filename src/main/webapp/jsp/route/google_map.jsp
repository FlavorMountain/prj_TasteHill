<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>음식점 검색 및 경로 표시</title>
<script
	src="https://maps.googleapis.com/maps/api/js?key=${sessionScope.API_KEY}&libraries=places"></script>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/map.css">
</head>
<body>
	<div class="container" style="margin-top: 130px;">
		<div id="side-panel"
			class="border border-primary rounded ">
			<div class="vesitable-img">
			</div>
			<div class = "select-place-btn">
			
			</div>
			<div class="p-4 rounded-bottom">
				<h4 id="place-name"></h4>
				<p id="place-rating" class="text-dark fs-5 fw-bold mb-0"></p>
				<p id="place-formatted_address"></p>
				<p id="place-opening_hours"></p>
				<div class="d-flex justify-content-between flex-lg-wrap">
					
					<!-- 
					<a href="#"
						class="btn border border-secondary rounded-pill px-3 text-primary">
						<i class="fa fa-shopping-bag me-2 text-primary"></i> Add to cart</a>
						 -->
					</div>
					
				<div id="place-photos"></div>
			</div>
		</div>

		<div id="map-container position-relative">
			<div class="controls position-relative" >
				<button class="control-btn position-absolute end-0 my-2 text-white bg-primary rounded border-0 py-2 px-2" onclick="searchPlaces()" style="margin-right: 5%">주변 음식점</button>
				<button class="control-btn position-absolute end-0 my-2 text-white bg-primary rounded border-0 px-2 py-2" onclick="drawRoute()" style="margin-right: 14%">경로 그리기</button>
			</div>
			<div id="map"></div>

			<!-- 순서 변경된 부분 -->

			<div id="selected-list-container">
				<div class="post-title-section">
					<div class="form-group">
						<div class="post-header mt-4 w-25">
							<input type="text" class="form-control p-3"
								placeholder="제목을 입력해주세요" id="post-title"
								aria-describedby="search-icon-1">
						</div>
					</div>
				</div>

				<div class="container-fluid fruite mt-3">
					<div class="container">
						<div class="tab-class text-center">
							<div class="tab-content">
								<div id="tab-1" class="tab-pane fade show p-0 active">
									<div class="row g-4">
										<div class="col-lg-12">
											<div class="row g-4" id="selected-list"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="post-content-section mt-3">
					<div class="form-group">
						<textarea id="post-content"
							class="description form-control border-1" cols="30" rows="8"
							placeholder="동선에 대해서 설명해주세요" spellcheck="false"></textarea>

					</div>
					<div class="justify-content-center mt-3" style="display: flex;">
						<button
							class="submit-btn btn btn-primary border-0 border-secondary py-3 px-4 rounded-3 text-white w-25"
							onclick="validateAndSend()">동선 저장</button>
					</div>
				</div>
			</div>
		</div>

		<!-- Post content -->
		<div class="post-content h5">${RVO.contents}</div>
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
                            '</div>'
                        );
                        infowindow.open(map, marker);
                        $('.select-place-btn').html('<button onclick="addPlaceToList(\'' + placeId + '\')" class="text-white bg-primary px-3 py-1 rounded position-absolute border-0" style="top: 10px; right: 10px;">동선 추가</button>');
                        
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
                            $('.vesitable-img').html('<img src="'+ response.result.photos[0].photo_url +'"class="img-fluid w-100 rounded-top" alt="">');
                            let photoHTML = '<div><strong>사진:</strong><br>';
                            response.result.photos.forEach(img => {
                                photoHTML += '<img src="' + img.photo_url + 
                                    '" alt="장소 사진" class="place-photo mx-1 my-1 border-1" style="width: 100%; border-color: #dee2e6	">';
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
        	/*console.log('addPlace 호출!');*/
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
        	

            $('#selected-list').empty();
            
            selectedPlaces.forEach((place, index) => {
            	/*console.log(place);*/
            	let element = '<div class="col-md-6 col-lg-4 col-xl-3">'
				element += '<div class="rounded position-relative fruite-item">'
				element += 	'<div class="fruite-img">'
					if (place.result.photos && place.result.photos.length > 0) {
                        const photoUrl = place.result.photos[0].photo_url; 
                        element += '<img src="' + photoUrl + '" class="img-fluid w-100 rounded-top">'
                        
                    } else {
                        const photoUrl = "/resources/images/tastehill.png"; 
                        element += '<img src="' + photoUrl + '" class="img-fluid w-100 rounded-top">'
                    }
				
				element += '</div>'
				element += 	'<div class="p-4 border border-secondary border-top-0 rounded-bottom">'
				element += 		'<h5 style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">' + place.result.name +'</h5>'
				element += 			'<p>평점: ' + place.result.rating + '</p>'
				element += 			'<div class="d-flex justify-content-center flex-lg-wrap">'
				element += 				'<p class="text-dark fs-10 fw-bold mb-1" style="white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">'+ place.result.formatted_address+'</p>'
				element += 				'</div>'
				element += 				'<button onclick="removePlace(0)"  class="remove-btn btn border border-secondary rounded-pill px-3 text-primary"> 삭제 </button>'
				element += 				'</div>'
				element += 			'</div>'
				element += 		'</div>'
            	
             
		        $('#selected-list').append(element);
            });
        }
        
        function sendSelectedList() {
            const listItems = document.querySelectorAll("#selected-list li");
            const selectedData = {
                places: [],
                title: document.getElementById("post-title").value.trim(),
                contents: document.getElementById("post-content").value.trim()
            };
            console.log(selectedPlaces);
            selectedPlaces.forEach(item => {
                selectedData.places.push({
                    place_id: item.place_id,
                    name: item.name
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
       
     // 유효성 검사 후 전송하는 함수
        function validateAndSend() {
    	 	console.log(selectedPlaces);
                sendSelectedList();        }
    </script>
</body>
</html>