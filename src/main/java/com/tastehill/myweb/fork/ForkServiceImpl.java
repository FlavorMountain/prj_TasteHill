package com.tastehill.myweb.fork;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.ForkMapper;

@Service
public class ForkServiceImpl implements ForkService{

	@Autowired
	ForkMapper mapper;
	
	@Override
	public List<ForkVO> selectForkList(int seqMember) {
		// TODO Auto-generated method stub
		return mapper.seleteForkAll(seqMember);
	}

	@Override
	public ForkVO selectFork(int seqMember, int seqRoute) {
		// TODO Auto-generated method stub
		return mapper.seleteFork(seqMember, seqRoute);
	}

	@Override
	public int insertFork(int seqMember, int seqRoute) {
		// TODO Auto-generated method stub
		return mapper.insertFork(seqMember, seqRoute);
	}

	@Override
	public int deleteFork(int seqMember, int seqRoute) {
		// TODO Auto-generated method stub
		return mapper.deleteFork(seqMember, seqRoute);
	}

}
