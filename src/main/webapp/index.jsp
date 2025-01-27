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
</head>
<body>
	<header>
		<jsp:include page="/jsp/common/header.jsp" />
	</header>
	<main>
		<c:choose>
			<c:when test="${not empty content}">
				<jsp:include page="${content}" />
			</c:when>
			<c:otherwise>
				<jsp:include page="/jsp/main/main.jsp" />
			</c:otherwise>
		</c:choose>
	</main>
	<footer>
		<!-- 공통 푸터 -->
		<p>Footer content here</p>
	</footer>
</body>
</html>