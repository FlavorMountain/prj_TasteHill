<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>TasteHill</title>
<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

</head>

<body>




	<!-- Hero Start -->
	<div class="container-fluid py-5 mb-5 hero-header"></div>
	<!-- Hero End -->


	<div class="container">
		<div class="row justify-content-between">
			<div class="col-lg-2"></div>
			<jsp:include page="../common/searchBar.jsp" />
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
	<div class="container-fluid fruite py-5 mt-4">
		<div class="container py-5">
			<div class="tab-class text-center">
				<div class="row g-4">
					<div class="col-lg-4 text-start">
						<h1>Hot 동선</h1>
					</div>
					<div class="col-lg-4"></div>
					<div class="col-lg-4 text-end pt-3">
						<a href="/hotList">더보기 ></a>
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

</body>

</html>