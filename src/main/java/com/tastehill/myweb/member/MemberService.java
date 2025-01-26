package com.tastehill.myweb.member;

import java.util.List;

public interface MemberService {
	public int svcInsertMember(MemberVO mvo);
	public MemberVO svcSelectMember(int seqMember);
	public MemberVO svcloginMember(String email, String pw);
	List<MemberVO> svcSelectMemberAll();
	int svcUpdateMemberProfile(int seqMember, String profile);
	int svcUpdateMemberNickname(int seqMember, String nickname);
	int svcUpdateMemberPinnedRoute(int seqMember, int seqRoute);
	int svcUpdateMemberPw(int seqMember, String pw);
	int svcDeleteMember(int seqMember);
}
