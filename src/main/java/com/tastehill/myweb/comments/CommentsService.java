package com.tastehill.myweb.comments;

import java.util.List;

public interface CommentsService {
	public int svcInsertComments(CommentsVO cvo);
	public int svcUpdateComments(String contents, int seqComments);
	public int svcDeleteComments(int seqComments);
	public List<CommentsVO> svcSelectComments(int seqRoute);
}
