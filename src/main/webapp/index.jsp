<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">
<script src="https://kit.fontawesome.com/7a7c0970b6.js"
	crossorigin="anonymous"></script>

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="${pageContext.request.contextPath}/fruitables-1.0.0/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
<link href="${pageContext.request.contextPath}/fruitables-1.0.0/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">


<!-- Customized Bootstrap Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="${pageContext.request.contextPath}/resources/css/style.css" rel="stylesheet">
</head>
<body>
	<div class="container-fluid fixed-top shadow-sm">
		<div class="container px-0">
			<nav class="navbar navbar-light bg-white navbar-expand-xl">
				<a href="/main" class="navbar-brand">
				<h1 class="text-primary display-6">TasteHill</h1></a>
				<button class="navbar-toggler py-2 px-3" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
					<span class="fa fa-bars text-primary"></span>
				</button>
				<div class="collapse navbar-collapse bg-white" id="navbarCollapse">
					<div class="navbar-nav mx-auto"></div>
					<c:if test="${not empty sessionScope.SESS_MEMBER_ID}">
					<div class="d-flex m-3 me-0">
						<a href="${pageContext.request.contextPath}/chatroomlist/${sessionScope.SESS_MEMBER_ID}" class="position-relative me-4 my-auto"> <i
							class="fa-solid fa-comment fa-2x"></i> <span
							class="position-absolute bg-secondary rounded-circle d-flex align-items-center justify-content-center text-dark px-1"
							style="top: -5px; left: 15px; height: 20px; min-width: 20px;">3</span>
						</a> <a href="/profile" class="my-auto"> <i class="fas fa-user fa-2x"></i>
						</a> <a href="/logout" class="my-auto"> <i
							class="fa-solid fa-right-from-bracket fa-2x"></i>
						</a>
					</div>
					</c:if>
					<c:if test="${empty sessionScope.SESS_MEMBER_ID}">
						<div class="d-flex m-3 me-0">
						<a href="/loginPage" class="my-auto"> <i
								class="fa-solid fa-right-to-bracket fa-2x"></i>
							</a>
						</div>
					</c:if>
				</div>
			</nav>
		</div>
	</div>
	<main>
		<div id="wrapper">
			<c:choose>
				<c:when test="${not empty content}">
					<jsp:include page="${content}" />
				</c:when>
				<c:otherwise>
					<jsp:include page="/jsp/main/main.jsp" />
				</c:otherwise>
			</c:choose>
		</div>
	</main>
	<!-- Footer Start -->
	<div class="container-fluid bg-dark text-white-50 footer pt-5 mt-5">
		<div class="container py-1">
			<div class="mb-4"
				style="border-bottom: 1px solid rgba(226, 175, 24, 0.5);">
				<div class="row g-4">
					<div class="col-lg-3">
						<a href="#">
							<h1 class="text-primary mb-0">TasteHill</h1>
							<p class="text-secondary mb-0">Hot Restaurant Route for Trip</p>
						</a>
					</div>
					<div class="col-lg-6">
						<div class="position-relative mx-auto"></div>
					</div>
					<div class="col-lg-3">
						<div class="d-flex justify-content-end pt-3">
							<a class="btn btn-outline-secondary btn-md-square rounded-circle"
								href=""> <i class="fab fa-github"></i></a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Footer End -->

	<!-- Copyright Start -->
	<div class="container-fluid copyright bg-dark py-4">
		<div class="container">
			<div class="row">
				<div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
					<span class="text-light"><a href="#"><i
							class="fas fa-copyright text-light me-2"></i>Your Site Name</a>, All
						right reserved.</span>
				</div>
				<div class="col-md-6 my-auto text-center text-md-end text-white">
					<!--/*** This template is free as long as you keep the below authorâs credit link/attribution link/backlink. ***/-->
					<!--/*** If you'd like to use the template without the below authorâs credit link/attribution link/backlink, ***/-->
					<!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
					Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML
						Codex</a> Distributed By <a class="border-bottom"
						href="https://themewagon.com">ThemeWagon</a>
				</div>
			</div>
		</div>
	</div>
	<!-- Copyright End -->
</body>
</html>