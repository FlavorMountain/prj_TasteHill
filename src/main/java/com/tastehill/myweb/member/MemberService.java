package com.tastehill.myweb.member;

import java.util.List;

public interface MemberService {
	public int svcInsertMember(MemberVO mvo);
	public MemberVO svcSelectMember(int seqMember);
	public MemberVO svcloginMember(String email, String pw);
	List<MemberVO> svcSelectMemberAll();
	
	// 닉네임 변경
    int svcUpdateMemberNickname(int seqMember, String nickname);

    // 프로필 이미지 변경
    int svcUpdateMemberProfile(int seqMember, String profilePath);
	int svcUpdateMemberPinnedRoute(int seqMember, int seqRoute);
	int svcUpdateMemberPw(int seqMember, String pw);
	int svcDeleteMember(int status);
}
