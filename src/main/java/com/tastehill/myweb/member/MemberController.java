package com.tastehill.myweb.member;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MemberController {
	
	@RequestMapping(value = "/member", method = RequestMethod.GET)
	public String Get(Model model) {
		model.addAttribute("content","/jsp/member/member_login.jsp");
		return "index";
	}
}
//