package com.tastehill.myweb.fork;

import java.util.List;

public interface ForkService {
	public List<ForkVO> selectForkList(int seqMember);
	public ForkVO selectFork(int seqMember, int seqRoute);
	public int insertFork(int seqMember, int seqRoute);
	public int deleteFork(int seqMember, int seqRoute);
}
