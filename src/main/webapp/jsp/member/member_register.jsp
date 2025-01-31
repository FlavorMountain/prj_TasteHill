<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member_register.css">
</head>
<body>
	

<div class="login-container">
        <div class="logo">
		<img src="/resources/images/tastehill.png" alt="Logo">
	</div>
        <form method="POST" action="/login">
            <div class="input-group">
                <label for="email">LOGIN EMAIL</label>
                <div id="register-email">
	                <input type="text" id="email" name="email">
	            	<button type="submit" id="email-check">중복 체크</button>
            	 </div>
            </div>
            <div class="input-group">
                <label for="pw">PASSWORD</label>
                <input type="password" id="pw" name="pw">
            </div>
            <div class="input-group">
                <label for="nickname">NICKNAME</label>
                <input type="text" id="nickname" name="nickname">
            </div>
            <button type="submit" class="login-button">REGISTER</button>
        </form>
    </div>
</body>
</html>