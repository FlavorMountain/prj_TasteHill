<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
로그인<hr>

<form method="POST" action="/member/login">
<table border="1" width="300">
<tr><td>이메일<input type="text" name="email"></td></tr>
<tr><td>비밀번호<input type="password" name="pw"></td></tr>
<tr><td><input type="submit" value="로그인"></td></tr>
</table>
</form> 
    
</body>
</html>