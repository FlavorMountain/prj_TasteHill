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
        	<input type="hidden" id="room-num" value="${seqChattingRoom}"/>
            <input type="text" id="message" placeholder="메시지를 입력하세요..." />
            <button id="sendBtn" class="send-button">전송</button>
        </div>
    </div>
	
	<script>
		$("#sendBtn").click(function() {
			sendMessage();
		});
		
		let socket = new SockJS("http://localhost:8089/chatting");
		socket.onmessage = onMessage;
		socket.onclose = onClose;
		
		function sendMessage() {
			socket.send($("#message").val());
		}
		
		function onMessage(msg) {
			var contents = msg.data;
			var seqChattingRoom = $("#room-num").val();
			var sessionMember = $("#sess-num").val();
		    jsonObj = {"contents" : contents, "seqChattingRoom" : seqChattingRoom} 
		    jsonStr = JSON.stringify(jsonObj);
			
			$.ajax({
		    	url  		: "/sendchatting",
		    	method 		: "POST", 
		    	data 		:  jsonStr ,
		    	contentType : "application/json; charset=UTF-8", 
		    	dataType 	: "json",
		    	success: function(obj) {    //{"message":"okmap","status":"200"}
		    	    // 기존 댓글 목록 비우기
		    	    $(".chat-messages").empty();
		    	    
		    	    // 받아온 댓글 목록으로 새로 구성
		    	    obj.CLIST.forEach(function(cvo) {

		    	    	console.log(cvo.seqMember == sessionMember);
		    	    	console.log(cvo.seqMember == sessionMember ? "mine" : "fail");

		    	    	var newComment = "<div class='message " + (cvo.seqMember == sessionMember ? "mine" : "") + "'>";
		    	    	newComment +=     "<div class='profile-image'>";
		    	    	newComment +=     "<img src='/resources/images/tastehill.png'>";
		    	    	newComment +=     "</div>";
		    	    	newComment +=       "<div class='message-content'>";
		    	    	newComment +=           "<div class='sender'>"+cvo.memberVO.nickname+"</div>";
		    	    	newComment +=             "<div class='text'>"+cvo.contents+"</div>";
		    	    	newComment +=           "</div>";
		    	    	newComment +=        "</div>";
		    	    	

		    	        // 댓글 목록에 새로운 댓글 추가
		    	        $(".chat-messages").append(newComment);
		    	    });
		    	    

					$("#message").val('');
					
		            scrollToBottom();
		    	    
		    	},
		    	error : function(err) { console.log("에러:" + err) }  
		    });
			
			
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