package com.tastehill.myweb.chat;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;


public class ChattingHandler extends TextWebSocketHandler {
    
    // 방별로 세션을 관리하기 위한 맵
    private final ConcurrentHashMap<String, CopyOnWriteArrayList<WebSocketSession>> roomSessions = new ConcurrentHashMap<>();

    private final ConcurrentHashMap<WebSocketSession, String> sessionRoomMap = new ConcurrentHashMap<>();
    private final ObjectMapper objectMapper = new ObjectMapper();
    
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        // URL에서 방 번호 파라미터 추출
        Map<String, String> params = extractUrlParams(session.getUri().getQuery());
        String roomId = params.get("roomId");
        
        if (roomId != null) {
            // 방에 세션 추가
            roomSessions.computeIfAbsent(roomId, k -> new CopyOnWriteArrayList<>()).add(session);
            sessionRoomMap.put(session, roomId);
        }
    }
    
    private Map<String, String> extractUrlParams(String query) {
        Map<String, String> params = new ConcurrentHashMap<>();
        if (query != null) {
            String[] pairs = query.split("&");
            for (String pair : pairs) {
                String[] keyValue = pair.split("=");
                if (keyValue.length == 2) {
                    params.put(keyValue[0], keyValue[1]);
                }
            }
        }
        return params;
    }
    
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        ChatVO messageVO = objectMapper.readValue(message.getPayload(), ChatVO.class);
        String roomId = sessionRoomMap.get(session);
        
        if (roomId != null && roomSessions.containsKey(roomId)) {
            roomSessions.get(roomId).forEach(sess -> {
                try {
                    if (sess.isOpen()) {
                        sess.sendMessage(new TextMessage(message.getPayload()));
                    }
                } catch (IOException e) {
                    e.printStackTrace();
                }
            });
        }
    }
    
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        String roomId = sessionRoomMap.get(session);
        if (roomId != null) {
            if (roomSessions.containsKey(roomId)) {
                roomSessions.get(roomId).remove(session);
                if (roomSessions.get(roomId).isEmpty()) {
                    roomSessions.remove(roomId);
                }
            }
            sessionRoomMap.remove(session);
        }
    }
}