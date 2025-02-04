package com.tastehill.myweb.chat;

import lombok.Data;
import lombok.NoArgsConstructor;

import com.tastehill.myweb.member.MemberVO;

import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChattingRoomVO {
    private int seqChattingRoom;
    private int sender;
    private int receiver;
    private String updatedAt;
    private String lastChatting;
    private MemberVO senderVO;
    private MemberVO receiverVO;
    private String nickname; 
    private String profile; 
}