<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	회원가입
	<hr>

	<form method="POST" action="/member/register">
		<table border="1" width="600">
			<tr>
				<td>이메일 <input type="text" name="email"></td>
			</tr>
			<tr>
				<td>비번 <input type="password" name="pw"></td>
			</tr>
			<tr>
				<td>닉네임 <input type="text" name="nickname"></td>
			</tr>
			<tr>
				<td><input type="submit" value="회원가입"></td>
			</tr>
		</table>
	</form>


</body>
</html>