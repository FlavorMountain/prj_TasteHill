package com.tastehill.myweb.mapper;

import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Options;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import com.lec.oauth.vo.UsersOauthVO;
import com.tastehill.myweb.member.MemberVO;


@Repository
@Mapper
public interface OauthMapper {
//	public ArrayList<MemberVO>  allUser();
//	public void insertUsersTbl(MemberVO memberVO);
//	public void updateUserTbl(MemberVO memberVO);
//	public int userDelete(int userSeq);	
//	
//	//일반 로그인
//	public MemberVO formLogin(MemberVO memberVO);
//	//일반 회원가입
//	public void formJoin(MemberVO memberVO);
	
	//-------------- OAuth 추가 -------------------
	public MemberVO findMemberByEmail(String email);
	public void insertMemberOauth(UsersOauthVO usersOauthVO);
//    public void updateUserOauthTbl(UsersOauthVO usersOauthVO);
	
	
}
