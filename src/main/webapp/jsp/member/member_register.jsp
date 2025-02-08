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
	

<div class="login-container" style="margin-top: 200px;">
        <div class="logo">
		<img src="/resources/images/tastehill.png" alt="Logo">
	</div>
        <form method="POST" action="/register" id="register-from">
            <div class="input-group">
                <label for="email">LOGIN EMAIL</label>
                <div id="register-email">
	                <input type="text" id="email" name="email">
	            	<button type="button" id="email-check">중복 체크</button>
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
            <button type="button" class="login-button" id="submitBtn">REGISTER</button>
        </form>
    </div>
    	
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script> 
$(function() { 
    let isEmailChecked = false;
    $("#email-check").click(function() {
        var email = $("#email").val().trim();

        if (email === "") {
            alert("이메일을 입력하세요");
            $("#email").focus();
            return;
        }

        // AJAX 요청을 사용하여 이메일 중복 확인
        $.ajax({
            type: "POST",  // 또는 "GET" (서버 구현 방식에 따라 다름)
            url: "/emailcheck",
            contentType: "application/json",
            data: JSON.stringify({ email: email }), // JSON 형식으로 전송
            success: function(response) {
                if (response.exists) {
                    alert("사용 가능한 이메일입니다."); 
                    isEmailChecked = true;   // 중복 확인 완료
                } else {
                    alert("이미 사용 중인 이메일입니다.");
                    isEmailChecked = false;  // 중복된 이메일이므로 false
                }
            },
            error: function(xhr, status, error) {
                alert("이메일 확인 중 오류가 발생했습니다.");
                console.error("Error:", error);
            }
        });
    });
    
    $("#email").on("input", function() {
        isEmailChecked = false;
    });
    
    $("#submitBtn").click(  function(){

        if (!isEmailChecked) {
            alert("이메일 중복 체크를 해주세요.");
        } else {
			var email = $("#email").val().trim();
			var nickname   = $("#nickname").val().trim();
			var pw = $("#pw").val().trim();
	        if (email === "") {
	            alert("이메일을 입력하세요");
	            $("#email").focus();
	        } else if(pw == "") {
	            alert("비밀번호를 입력하세요");
	            $("#pw").focus();
	        } else if (nickname === "") {
	            alert("닉네임을 입력하세요");
	            $("#nickname").focus();
	        } else {
	            $("#register-from").submit(); 
	        }
        }
	});
});

</script>

</body>
</html>