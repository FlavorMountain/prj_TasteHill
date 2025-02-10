package com.tastehill.myweb.comments;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.CommentsMapper;

@Service
public class CommentsServiceImpl implements CommentsService{

	@Autowired
	CommentsMapper mapper;

	@Override
	public List<CommentsVO> svcSelectComments(int seqRoute) {
		// TODO Auto-generated method stub
		List<CommentsVO> clist = mapper.selectCommentsAll(seqRoute);
		for(CommentsVO cvo : clist) {
			System.out.println(cvo.toString());
		}
		
		return clist;
	}
	
	@Override
	public int svcInsertComments(CommentsVO cvo) {
		// TODO Auto-generated method stub
		return mapper.insertComments(cvo);
	}

	@Override
	public int svcUpdateComments(String contents, int seqComments) {
		// TODO Auto-generated method stub
		return mapper.updateComments(contents, seqComments);
	}

	@Override
	public int svcDeleteComments(int seqComments) {
		// TODO Auto-generated method stub
		return mapper.deleteComments(seqComments);
	}

	
}
