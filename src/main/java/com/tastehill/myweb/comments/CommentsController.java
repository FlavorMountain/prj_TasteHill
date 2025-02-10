package com.tastehill.myweb.comments;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping(value = "/comments")
public class CommentsController {

	@Autowired
	private CommentsService service;

	
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> insertComment(@RequestBody CommentsVO cvo,
			HttpSession session) {
			// 세션에서 현재 로그인한 사용자 정보 가져오기
			int seqMember = (int) session.getAttribute("SESS_MEMBER_ID");
			String nickname = (String) session.getAttribute("SESS_NICKNAME");
			
			cvo.setSeqMember(seqMember);
			cvo.setNickname(nickname);
			
		    service.svcInsertComments(cvo);
		    
			Map<String, Object> response = new HashMap<>();
		    response.put("status", "200");
		    response.put("message", "success");
		    response.put("nickname", "현재 로그인한 사용자 닉네임"); // 세션에서 가져오거나 DB에서 조회
		    response.put("clist", service.svcSelectComments(cvo.getSeqRoute()));
		    
		    return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteComment(@RequestParam("seqComments") int seqComments) {
		try {
			
			service.svcDeleteComments(seqComments);
			
			return "redirect: /detail";
		} catch (Exception e) {
			return "error";
		}
	}
}
//