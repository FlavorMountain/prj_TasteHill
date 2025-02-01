package com.lec.oauth.vo;

import java.util.Date;
import org.springframework.stereotype.Component;
import lombok.Data;

@Component   
@Data     
public class UsersOauthVO {
	private int seqMember;
	private String picture;
	private String accessToken;
	private String refreshToken;
	private String updatedAt;
}
