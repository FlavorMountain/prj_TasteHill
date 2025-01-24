package com.tastehill.myweb.member;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OAuthVO {
    private int seqMember;
    private String picture;
    private String accessToken;
    private String refreshToken;
    private Date updatedAt;
}