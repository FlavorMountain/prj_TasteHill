package com.tastehill.myweb.chat;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.ChattingMapper;
import com.tastehill.myweb.mapper.MemberMapper;

@Service
public class ChatServiceImpl implements ChatService{

	@Autowired
	private ChattingMapper mapper;
	@Autowired
	private MemberMapper memberMapper;
	
	@Override
	public List<ChattingRoomVO> svcSelectChattingRoomList(int seqMember) {
		List<ChattingRoomVO> roomList = mapper.selectChattingRoomList(seqMember);
		for(ChattingRoomVO rvo : roomList) {
			rvo.setSenderVO(memberMapper.selectMember(rvo.getSender()));
			rvo.setReceiverVO(memberMapper.selectMember(rvo.getReceiver()));
		}
		
		return roomList;
	}

	@Override
	public ChattingRoomVO svcSelectChattingRoom(int sender, int receiver) {
		return mapper.selectChattingRoom(sender, receiver);
	}

	@Override
	public List<ChatVO> svcSelectChattingList(int seqChattingRoom) {
		return mapper.selectChattingList(seqChattingRoom);
	}

	@Override
	public int svcInsertChattingRoom(ChattingRoomVO rvo) {
		return mapper.insertChattingRoom(rvo);
	}

	@Override
	public int svcInsertChatting(ChatVO cvo) {
		return mapper.insertChatting(cvo);
	}

	@Override
	public int updateLastChatting(int seqChattingRoom, String contents) {
		return mapper.updateLastChatting(contents, seqChattingRoom);
	}

}
