package com.tastehill.myweb.member;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {
    private int seqMember;
    private String nickname;
    private String email;
    private String pw;
    private String profile;
    private Date createdAt;
    private Date updatedAt;
    private int pinnedRoute;
    private Integer status;
}
