<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>Fruitables - Vegetable Website Template</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

</head>

<body>



	<!-- Navbar start -->
	
	<!-- Navbar End -->


	<!-- Modal Search Start -->
	<div class="modal fade" id="searchModal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-fullscreen">
			<div class="modal-content rounded-0">
				<div class="modal-header">
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body d-flex align-items-center">
					<div class="input-group w-75 mx-auto d-flex">
						<input type="search" class="form-control p-3"
							placeholder="keywords" aria-describedby="search-icon-1">
						<span id="search-icon-1" class="input-group-text p-3"><i
							class="fa fa-search"></i></span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal Search End -->


	<!-- Hero Start -->
	<div class="container-fluid py-5 mb-5 hero-header"></div>
	<!-- Hero End -->


	<div class="container">
		<div class="row justify-content-between">
			<div class="col-lg-2"></div>
			<div class="col-lg-6">
				<div class="position-relative mx-auto">
					<input class="form-control border-1 w-100 py-3 px-4 rounded-pill"
						type="number" placeholder="Search Text">
					<button type="submit"
						class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
						style="top: 0; right: 0; margin-top: 2px;" >Search</button>
				</div>
			</div>
			<div class="col-lg-2">
				<div class="position-relative mx-auto">
					<a href="/route"
						class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-3 text-white"
						style="top: 0; right: 0; margin-top: 2px;" >동선 작성</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Featurs Section Start -->
	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4">
					<div class="col-lg-4 text-start">
						<h1>Hot 동선</h1>
					</div>

				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="row g-4">
									<c:forEach var="route" items="${hotRoutes}" varStatus="status">
										<c:if test="${status.index < 4}">
											<div class="col-md-6 col-lg-4 col-xl-3">
												<div class="rounded position-relative fruite-item">
													<div class="fruite-img">
														<img src="${route.photo_url}"
															class="img-fluid w-100 rounded-top" alt="">
													</div>
													<div
														class="p-4 border border-secondary border-top-0 rounded-bottom">
														<h5>${route.title}</h5>
														<p>${route.nickname}</p>
														<div class="d-flex justify-content-center flex-lg-wrap">
															<p class="text-dark fs-5 fw-bold mb-1">등록일:${route.createdAt}</p>
															<a href="/detail?seq_route=${route.seq_route}" class="btn border border-secondary rounded-pill px-3 text-primary">
																보러가기 </a>
														</div>
													</div>
												</div>
											</div>
										</c:if>
									</c:forEach>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Featurs Section End -->


	<!-- Fruits Shop Start-->
	<div class="container-fluid fruite py-5">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4">
					<div class="col-lg-4 text-start">
						<h1>나의 즐겨찾기 동선</h1>
					</div>
				</div>
				<div class="tab-content">
					<div id="tab-1" class="tab-pane fade show p-0 active">
						<div class="row g-4">
							<div class="col-lg-12">
								<div class="row g-4">
									<div class="col-lg-6 col-xl-12">
										<div class="p-4 rounded bg-light">
											<div class="row align-items-start">
												<div class="col-6 w-50">
													<img src="${pinnedRoute.photo_url}"
														class="img-thumbnail rounded-circle w-50" alt="">
												</div>
												<div class="col-6">
													<a href="/detail?seq_route=${pinnedRoute.seq_route}"
														class="h3">${pinnedRoute.title}</a>
													<div class="d-flex my-3">
														<c:forEach var="routePlace" items="${pinnedRoute.places}"
															varStatus="status">
															<c:if test="${routePlace.place != null}">
																<h4>${routePlace.place.name}</h4>
																<c:if test="${!status.last}"> → </c:if>
															</c:if>
														</c:forEach>

													</div>
													<h5 class="d-flex">${pinnedRoute.nickname}</h5>
													<div class="d-flex my-3 h5">${pinnedRoute.contents}</div>
												</div>
												<c:if test="${empty pinnedRoute}">
													<h3 style="margin-bottom: 50px; color: #B20000;">즐겨찾기한 동선이 없습니다.</h3>
												</c:if>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Fruits Shop End-->


	



	<!-- Back to Top -->
	<a href="#"
		class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
		class="fa fa-arrow-up"></i></a>


</body>

</html>