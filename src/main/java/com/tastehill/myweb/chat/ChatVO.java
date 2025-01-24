package com.tastehill.myweb.chat;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChatVO {
    private int seqChat;
    private String contents;
    private Date createdAt;
    private int createdById;
    private int seqChattingRoom;
}
