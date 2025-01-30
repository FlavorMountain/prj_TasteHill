package com.lec.oauth.vo;

import java.util.Date;

import org.springframework.stereotype.Component;

import com.lec.oauth.social.SocialType;

import lombok.Data;

@Component   
@Data        
public class UsersTblVO {
	private int userSeq;			//seq
	private String userEmail; 		//userID 기능
    private String userPw; 			// 일반 회원가입일 경우 사용
    private String userName;
    private String userGubun;		//a(admin), u(user:default)
    private String regdate;
    private String provider;		//GOOGLE,KAKAO,NAVER,local
   
    private UsersOauthVO usersOauthVO; // 1:1 or 1:0 관계 매핑
}
