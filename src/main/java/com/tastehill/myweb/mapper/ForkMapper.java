package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.fork.ForkVO;
import com.tastehill.myweb.member.MemberVO;

public interface ForkMapper {
	List<ForkVO> seleteForkAll(int seqMember);
	ForkVO seleteFork(@Param("seqMember") int seqMember, @Param("seqRoute") int seqRoute);
	int insertFork(@Param("seqMember") int seqMember, @Param("seqRoute") int seqRoute);
	int deleteFork(@Param("seqMember") int seqMember, @Param("seqRoute") int seqRoute);
}
