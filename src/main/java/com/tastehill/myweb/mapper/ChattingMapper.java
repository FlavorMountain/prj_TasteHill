package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.chat.ChatVO;
import com.tastehill.myweb.chat.ChattingRoomVO;
import com.tastehill.myweb.comments.CommentsVO;
import com.tastehill.myweb.member.MemberVO;

public interface ChattingMapper {
	List<ChattingRoomVO> selectChattingRoomList(@Param("seqMember") int seqMember);
	ChattingRoomVO selectChattingRoom(@Param("sender") int sender, @Param("receiver") int receiver);
	List<ChatVO> selectChattingList(@Param("seqChattingRoom") int seqChattingRoom);
	int insertChattingRoom(@Param("RVO") ChattingRoomVO rvo);
	int insertChatting(@Param("CVO") ChatVO cvo);
	int updateLastChatting(@Param("contents") String contents, @Param("seqChattingRoom") int seqChattingRoom);
}
