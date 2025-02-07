<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>TasteHILL</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/header.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/index.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/searchBar.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/route_card.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/resources/css/route_card_list.css">

<style>
</style>
</head>
<body>

	<!-- 검색 바 -->
	<div class="container-fluid py-5 mb-5 hero-header"></div>

	<div class="container mt-5">
		<div class="row justify-content-between">
			<div class="col-lg-2"></div>
			<div class="col-lg-6">
				<div class="position-relative mx-auto">
					<input class="form-control border-1 w-100 py-3 px-4 rounded-pill"
						type="number" placeholder="Search Text">
					<button type="submit"
						class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
						style="top: 0; right: 0; margin-top: 2px;">Search</button>
				</div>
			</div>
			<div class="col-lg-2">
				<div class="position-relative mx-auto">
					<a href="/route"
						class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-3 text-white"
						style="top: 0; right: 0; margin-top: 2px;">동선 작성</a>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 삭제 예정 -->
	<jsp:include page="${searchBar}" />
<body>
	<!-- 네비게이션바 검색 결과 화면 -->
	<div>

<c:if test="${not empty searchRoutes}">
		<c:forEach var="route" items="${searchRoutes}">
			<div class="container mt-5"
				style="padding: 30px; background: color-mix(in srgb, #1a1f24, transparent 96%); border-radius: 15px;">

				<div class="row g-4">

					<div
						class="col-lg-8 col-md-6 content d-flex flex-column justify-content-center order-last order-md-first">
						<h3>${route.title}</h3>
						<p>
							<i class="fa-solid fa-heart" style="color: red;"></i>
							${route.forkCount}
						</p>
						<c:forEach var="routePlace" items="${route.places}"
							varStatus="status">
							<c:if test="${routePlace.place != null}">
								<h4>${routePlace.place.name}</h4>
								<c:if test="${!status.last}"> → </c:if>
							</c:if>
						</c:forEach>
						<p>${route.updatedAt}</p>
						<p>${route.contents}</p>

					</div>

					<div
						class="col-lg-4 col-md-6 order-first order-md-last d-flex align-items-center">
						<div class="img">
							<img src="${route.photo_url}" alt="" class="img-thumbnail"> 
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>

	<c:if test="${not empty searchBarRes}">
			<c:forEach var="place" items="${searchBarRes}">
			<div class="container mt-5"
				style="padding: 30px; background: color-mix(in srgb, #1a1f24, transparent 96%); border-radius: 15px;">

				<div class="row g-4">

					<div
						class="col-lg-8 col-md-6 content d-flex flex-column justify-content-center order-last order-md-first">
						<h3>${place.name}</h3>
						<p>Address: ${place.formatted_address}</p>
						<p>Rating: ${place.rating}</p>

					</div>

					<div
						class="col-lg-4 col-md-6 order-first order-md-last d-flex align-items-center">
						<div class="img">
							<img src="${place.photos.photo_url}" alt="" class="img-thumbnail"> 
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>
	</div>


	<!-- Hot 동선 화면 -->
	<c:if test="${pageType == 'hotList'}">
		<c:forEach var="route" items="${hotRoutes}">
			<div class="container mt-5"
				style="padding: 30px; background: color-mix(in srgb, #1a1f24, transparent 96%); border-radius: 15px;">

				<div class="row g-4">

					<div
						class="col-lg-8 col-md-6 content d-flex flex-column justify-content-center order-last order-md-first">
						<h3>${route.title}</h3>
						<p>
							<i class="fa-solid fa-heart" style="color: red;"></i>
							${route.forkCount}
						</p>
						<c:forEach var="routePlace" items="${route.places}"
							varStatus="status">
							<c:if test="${routePlace.place != null}">
								<h4>${routePlace.place.name}</h4>
								<c:if test="${!status.last}"> → </c:if>
							</c:if>
						</c:forEach>
						<p>${route.updatedAt}</p>
						<p>${route.contents}</p>

					</div>

					<div
						class="col-lg-4 col-md-6 order-first order-md-last d-flex align-items-center">
						<div class="img">
							<img src="${route.photo_url}" alt="" class="img-thumbnail"> 
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>


	<!-- 마이페이지 동선 -->
	<c:if test="${pageType == 'myRoutes'}">
		<c:forEach var="route" items="${myRoutes}">
			<div class="container mt-5"
				style="padding: 30px; background: color-mix(in srgb, #1a1f24, transparent 96%); border-radius: 15px;">

				<div class="row g-4">

					<div
						class="col-lg-8 col-md-6 content d-flex flex-column justify-content-center order-last order-md-first">
						<h3>${route.title}</h3>
						<p>
							<i class="fa-solid fa-heart" style="color: red;"></i>
							${route.forkCount}
						</p>
						<c:forEach var="routePlace" items="${route.places}"
							varStatus="status">
							<c:if test="${routePlace.place != null}">
								<h4>${routePlace.place.name}</h4>
								<c:if test="${!status.last}"> → </c:if>
							</c:if>
						</c:forEach>
						<p>${route.updatedAt}</p>
						<p>${route.contents}</p>
						<input type="button" value="삭제" class="deleteRouteBtn btn border border-secondary rounded-pill px-3 text-primary" data-seq="${route.seq_route}" style="width: 10%">

					</div>

					<div
						class="col-lg-4 col-md-6 order-first order-md-last d-flex align-items-center">
						<div class="img">
							<img src="${route.photo_url}" alt="" class="img-thumbnail"> 
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>



	<!-- 즐겨찾기 동선 -->
	<c:if test="${pageType == 'forkList'}">
		<c:forEach var="route" items="${forkList}">
			<div class="container mt-5"
				style="padding: 30px; background: color-mix(in srgb, #1a1f24, transparent 96%); border-radius: 15px;">

				<div class="row g-4">

					<div
						class="col-lg-8 col-md-6 content d-flex flex-column justify-content-center order-last order-md-first">
						<h3>${route.title}</h3>
						<p>
							<i class="fa-solid fa-heart" style="color: red;"></i>
							${route.forkCount}
						</p>
						<c:forEach var="routePlace" items="${route.places}"
							varStatus="status">
							<c:if test="${routePlace.place != null}">
								<h4>${routePlace.place.name}</h4>
								<c:if test="${!status.last}"> → </c:if>
							</c:if>
						</c:forEach>
						<p>${route.updatedAt}</p>
						<p>${route.contents}</p>

					</div>

					<div
						class="col-lg-4 col-md-6 order-first order-md-last d-flex align-items-center">
						<div class="img">
							<img src="${route.photo_url}" alt="" class="img-thumbnail"> 
						</div>
					</div>
				</div>
			</div>
		</c:forEach>
	</c:if>



<div class="container mt-5 d-md-flex justify-content-center">
	${MY_KEY_PAGING_HTML}
</div>
	<script>
		    function toggleSearchResults() {
		        const pageType = '<c:out value="${pageType}" />'; // 서버에서 전달된 pageType 값
		
		        const routeResults = document.getElementById('routeResults');
		        const placeResults = document.getElementById('placeResults');
		        const routeTitle = document.getElementById('routeTitle');
		        const placeTitle = document.getElementById('placeTitle');
		
		        if (pageType === 'searchList') {
		            routeResults.style.display = 'block';
		            routeTitle.style.display = 'block';
		            placeResults.style.display = 'block';
		            placeTitle.style.display = 'block';
		        } else if (pageType === 'hotList') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        } else if (pageType === 'myRoutes') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        } else if (pageType === 'forkList') {
		            routeResults.style.display = 'none';
		            routeTitle.style.display = 'none';
		            placeResults.style.display = 'none';
		            placeTitle.style.display = 'none';
		        }
		    }
		
		    // 페이지 로드 시 초기화
		    window.onload = function () {
		        toggleSearchResults();
		    };
		</script>

	<script>
    // 모든 삭제 버튼에 클릭 이벤트 추가
    document.addEventListener("DOMContentLoaded", function() {
        const deleteButtons = document.querySelectorAll(".deleteRouteBtn");

        deleteButtons.forEach(button => {
            button.addEventListener("click", function(event) {
                event.stopPropagation(); // 부모 div 클릭 이벤트 방지

                const seqRoute = this.getAttribute("data-seq"); // 해당 동선 seq_route 값 가져오기

                if (confirm("정말 삭제하시겠습니까?")) {
                    fetch(`/profile/myroutes/delete?seqRoute=` + seqRoute, {
                        method: "POST",
                    })
                    .then(response => {
                        if (response.redirected) {
                            window.location.href = response.url; // 삭제 후 리디렉션
                        } else {
                            return response.text();
                        }
                    })
                    .catch(error => console.error("삭제 오류:", error));
                }
            });
        });
    });
</script>

</body>
</html>