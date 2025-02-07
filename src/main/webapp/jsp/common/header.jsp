<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<div class="header">
	<a href="/main" class="header-logo">TasteHILL</a> 
	<c:if test="${empty sessionScope.SESS_MEMBER_ID}">
		<a href="/loginPage" class="header-mypage">LOGIN</a>
	</c:if>
	<c:if test="${not empty sessionScope.SESS_MEMBER_ID}">
		<div>
            <a href="/chatroomlist/${sessionScope.SESS_MEMBER_ID}" class="header-mypage"><i class="fa-solid fa-comment" style="color: #26473c;"></i></a>
			<a href="/profile" class="header-mypage">MyPage</a>
			<a href="/logout" class="header-mypage">LogOut</a>
		</div>
	</c:if>
</div>