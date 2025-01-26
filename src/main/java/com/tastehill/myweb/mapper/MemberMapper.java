package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.member.MemberVO;

public interface MemberMapper {
	
	MemberVO selectMember(int seqMember);
	List<MemberVO> selectMemberAll();
	int insertMember(@Param("MVO") MemberVO mvo);
	MemberVO loginMember(@Param("email") String email, @Param("pw") String pw);
}
