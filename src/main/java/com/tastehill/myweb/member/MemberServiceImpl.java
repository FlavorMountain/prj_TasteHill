package com.tastehill.myweb.member;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.MemberMapper;

@Service
public class MemberServiceImpl implements MemberService{

	@Autowired
	MemberMapper mapper;
	
	@Override
	public int svcInsertMember(MemberVO mvo) {
		System.out.println(mvo.toString());
		return mapper.insertMember(mvo);	
	}

	@Override
	public MemberVO svcSelectMember(int seqMember) {
		return mapper.selectMember(seqMember);
	}

	@Override
	public MemberVO svcloginMember(String email, String pw) {
		// TODO Auto-generated method stub
		return mapper.loginMember(email, pw);
	}
	
	@Override
	public List<MemberVO> svcSelectMemberAll() {
		// TODO Auto-generated method stub
		return mapper.selectMemberAll();
	}


	@Override
	public int svcUpdateMemberProfile(int seqMember, String profile) {
	    System.out.println("Updating profile for member ID: " + seqMember + " with profile: " + profile);
	    return mapper.updateMemberProfileImage(seqMember, profile);
	}

	@Transactional
    @Override
    public int svcUpdateMemberNickname(int seqMember, String nickname) {
        return mapper.updateMemberNickname(seqMember, nickname);
    }


	@Transactional
	@Override
	public int svcUpdateMemberPw(int seqMember, String pw) {
		// TODO Auto-generated method stub
		return mapper.updateMemberPassword(seqMember, pw);
	}

	@Transactional
	@Override
	public int svcDeleteMember(int seqMember) {
		// TODO Auto-generated method stub
		return mapper.deleteMember(seqMember);
	}
	
	@Override
	public int svcUpdateMemberPinnedRoute(int seqMember, int seqRoute) {
		// TODO Auto-generated method stub
		return mapper.updatePinnedRoute(seqMember, seqRoute);
	}



}
