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
        <br>
        <div id="social-login">
        	<a href="/login/GOOGLE"><img src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/logo/Google.png" width=50 style="border: 1px solid #bbbbbb;  border-radius:15%;"></a>
			<a href="/login/KAKAO"><img src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/icon_1/Kakao.png" width=50></a>
			<a href="/login/NAVER"><img src="https://test.codemshop.com/wp-content/plugins/mshop-mcommerce-premium-s2/lib/mshop-members-s2/assets/images/social/icon_1/Naver.png" width=50></a><br><p>
		</div>
        <div class="signup">
            <p>회원이 아닙니다. <a href="/registerPage">회원가입</a></p>
        </div>
    </div>
</body>
</html>