<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member_login.css">
</head>
<body>
	

<div class="login-container">
        <div class="logo">
		<img src="/resources/images/tastehill.png" alt="Logo">
	</div>
        <form method="POST" action="/login">
            <div class="input-group">
                <label for="email">LOGIN EMAIL</label>
                <input type="text" id="email" name="email">
            </div>
            <div class="input-group">
                <label for="pw">PASSWORD</label>
                <input type="password" id="pw" name="pw">
            </div>
            <button type="submit" class="login-button">LOGIN</button>
        </form>
        <div class="signup">
            <p>회원이 아닙니다. <a href="/signup">회원가입</a></p>
        </div>
    </div>
</body>
</html>