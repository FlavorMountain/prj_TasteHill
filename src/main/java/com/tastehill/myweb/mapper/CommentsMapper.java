package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.comments.CommentsVO;
import com.tastehill.myweb.member.MemberVO;

public interface CommentsMapper {
	
	List<CommentsVO> selectCommentsAll(@Param("seqRoute") int seqRoute);
	int insertComments(@Param("CVO") CommentsVO cvo);
		
	// 댓글 수정
    int updateComments(@Param("contents") String contents,
                       @Param("seqComments") int seqComments);
    // 댓글 삭제 
    int deleteComments(@Param("seqComments") int seqComments);

}
