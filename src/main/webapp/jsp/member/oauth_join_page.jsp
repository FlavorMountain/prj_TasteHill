<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
<title>회원가입_추가정보</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/member_register.css">
</head>
<body onload="document.loginForm.name.focus();">

<div class="login-container">
        <div class="logo">
		<img src="/resources/images/tastehill.png" alt="Logo">
	</div>
        <form name="loginForm" id="loginForm" action="/oauth_join_process" method="post">
            <div class="input-group">
                <label for="email">LOGIN EMAIL</label>
                <div id="register-email">
	                <input type="text" id="email" name="email" value="${sessionScope.SESS_REGISTER_EMAIL}">
            	 </div>
            </div>
            <div class="input-group">
                <label for="nickname">NICKNAME</label>
                <input type="text" id="nickname" name="nickname">
            </div>
            <button type="button" class="login-button" id = "submitBtn">REGISTER</button>
        </form>
    </div>
</body>
	
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script> 
$(function() { 
	
	$("#submitBtn").click(  function(){
		var email = $("#email").val().trim();
		var nickname   = $("#nickname").val().trim();
        if (email === "") {
            alert("이메일을 입력하세요");
            $("#email").focus();
        } else if (nickname === "") {
            alert("닉네임을 입력하세요");
            $("#nickname").focus();
        } else {
            $("#loginForm").submit(); 
        }
	});
	
	
}); 
</script>			
</body>
</html>