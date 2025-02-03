package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.member.MemberVO;

public interface MemberMapper {
	
	MemberVO selectMember(int seqMember);
	List<MemberVO> selectMemberAll();
	int insertMember(@Param("MVO") MemberVO mvo);
	MemberVO loginMember(@Param("email") String email, @Param("pw") String pw);
	
	// 닉네임 변경
    int updateMemberNickname(@Param("seqMember") int seqMember,
                             @Param("nickname") String nickname);

    // 프로필 이미지 변경
    int updateMemberProfileImage(@Param("seqMember") int seqMember,
                                 @Param("profile") String profile);
    // 비밀번호 변경
    int updateMemberPassword(@Param("seqMember") int seqMember,
             @Param("password") String password);

    // 회원 탈퇴
    int deleteMember(@Param("status") int status);

}
