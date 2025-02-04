package com.tastehill.myweb.chat;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface ChatService {
	List<ChattingRoomVO> svcSelectChattingRoomList(int seqMember);
	ChattingRoomVO svcSelectChattingRoom(int sender, int receiver);
	List<ChatVO> svcSelectChattingList(int seqChattingRoom);
	int svcInsertChattingRoom(ChattingRoomVO rvo);
	int svcInsertChatting(ChatVO cvo);
	int updateLastChatting(int seqChattingRoom, String contents);
}
