package com.tastehill.myweb.chat;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class ChattingRoomVO {
    private int seqChattingRoom;
    private int sender;
    private int receiver;
}