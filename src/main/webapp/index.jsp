<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/index.css">
<script src="https://kit.fontawesome.com/7a7c0970b6.js" crossorigin="anonymous"></script>
</head>
<body>
	<header>
		<jsp:include page="/jsp/common/header.jsp" />
	</header>
	<main>
	<div id ="wrapper">
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
	<footer>
	    <div class="footer">
	        <div class="footer-title">TasteHill</div>
	        <a href="https://github.com/FlavorMountain/prj_TasteHill" class="footer-git-link">
	            <i class="fa-brands fa-github"></i>
	        </a>
	    </div>
	</footer>
</body>
</html>