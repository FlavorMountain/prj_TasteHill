<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		<jsp:include page="/jsp/default/header.jsp" />
	</header>
	<main>
        <!-- 각 요청에 따른 동적 컨텐츠 -->
        <jsp:include page="${content}"/>
    </main>
    <footer>
        <!-- 공통 푸터 -->
        <p>Footer content here</p>
    </footer>
</body>
</html>