<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/chatting.css">
</head>
<body>
<body>
    <div class="chat-container">
        <div class="chat-messages">
            <c:forEach items="${CLIST}" var="cvo">
                <div class="message ${cvo.seqMember == sessionScope.SESS_MEMBER_ID ? 'mine' : ''}">
                    <div class="profile-image">
                        <img src="/resources/images/tastehill.png">
                    </div>
                    <div class="message-content">
                        <div class="sender">${cvo.memberVO.nickname}</div>
                        <div class="text">${cvo.contents}</div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="chat-input">
        	<input type="hidden" id="sess-num" value="${sessionScope.SESS_MEMBER_ID}"/>
        	<input type="hidden" id="sess-nick" value="${sessionScope.SESS_NICKNAME}"/>
        	<input type="hidden" id="room-num" value="${seqChattingRoom}"/>
            <input type="text" id="message" placeholder="메시지를 입력하세요..." />
            <button id="sendBtn" class="send-button">전송</button>
        </div>
    </div>
	
	<script>
		let roomId = $("#room-num").val(); // 채팅방 ID 가져오기
		let nickname = $("#sess-nick").val();
		
		let sessionMember = 0;
	    let socket = new SockJS("http://localhost:8089/chatting/");
	
	    socket.onmessage = onMessage;
	    socket.onclose = onClose;
	
	    $("#sendBtn").click(function () {
			sessionMember = $("#sess-num").val();
	        sendMessage();
	    });

	    function sendMessage() {
	        let message = $("#message").val();
	        let jsonObj = {
	            contents: message,
	            seqChattingRoom: roomId,
	            seqMember: sessionMember,
	            nickname: nickname
	        };
	        socket.send(JSON.stringify(jsonObj));
	    }
	    
	    function onMessage(msg) {
	        let obj = JSON.parse(msg.data);
	        updateChat(obj);
	    }
		
		function updateChat(cvo) {
		    jsonStr = JSON.stringify(cvo);
			sessionMember = $("#sess-num").val();
			
			var newComment = "<div class='message " + (cvo.seqMember == sessionMember ? "mine" : "") + "'>";
	    	newComment +=     "<div class='profile-image'>";
	    	newComment +=     "<img src='/resources/images/tastehill.png'>";
	    	newComment +=     "</div>";
	    	newComment +=       "<div class='message-content'>";
	    	newComment +=           "<div class='sender'>" + cvo.nickname+"</div>";
	    	newComment +=             "<div class='text'>"+cvo.contents+"</div>";
	    	newComment +=           "</div>";
	    	newComment +=        "</div>";
	    	
	        $(".chat-messages").append(newComment);
			
	        sessionMember = 0;
			
            scrollToBottom();
	        
			$.ajax({
		    	url  		: "/sendchatting",
		    	method 		: "POST", 
		    	data 		:  jsonStr ,
		    	contentType : "application/json; charset=UTF-8", 
		    	dataType 	: "json",
		    	success: function(obj) {
		     	},
		    	error : function(err) { console.log("에러:" + err) }  
		    });
			
			$("#message").val('');
		}
		
		function onClose() {
			
		}
		
		function scrollToBottom() {
		    let chatMessages = document.querySelector(".chat-messages");
		    chatMessages.scrollTop = chatMessages.scrollHeight;
		}
	</script>
</body>
</html>