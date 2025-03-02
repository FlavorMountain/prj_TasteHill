<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>채팅방 목록</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/chatRoomList.css">
</head>
<body>
<div class="chat-room-container">
	<div class="chatting-room-logo">
		<h5>CHATTING Room</h5>
	</div>
    <div class="chat-room-list">
    
    <c:if test="${empty RLIST}">
    <div class="no-chatting-room">
    	채팅방이 없습니다!
    </div>
    </c:if>
        <c:forEach items="${RLIST}" var="room">
            <a href="/chat/${room.seqChattingRoom}" class="chat-room-item">
	            <div class = "chat-room-user">
	                <div class="profile-image">
	                <c:if test="${not empty room.profile}">
	                	<img src="${room.profile}" alt="${room.nickname}">
	                </c:if>
	                <c:if test="${empty room.profile}">
	                	<img src="/resources/images/tastehill.png" alt="${room.nickname}">
	                </c:if>
	                    
	                </div>
	                <div class="chat-room-info">
	                    <div class="chat-room-name">${room.nickname}</div>
	                    <div class="last-chatting">${room.lastChatting}</div>
	                </div>
                </div>
                <div>
                	<div class="chat-room-date">${room.updatedAt}</div>
                </div>
            </a>
        </c:forEach>
    </div>
    </div>
</body>
</html>