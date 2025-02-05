package com.tastehill.myweb.chat;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import com.tastehill.myweb.member.MemberVO;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatVO {
    private int seqChat;
    private String contents;
    private Date createdAt;
    private int seqMember;
    private int seqChattingRoom;
    private MemberVO memberVO;
    private String nickname;
}
