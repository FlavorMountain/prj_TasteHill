package com.tastehill.myweb.member;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.lec.oauth.social.SocialType;
import com.lec.oauth.svc.OauthService;
import com.lec.oauth.vo.UsersOauthVO;



@Controller
public class MemberController {
	
	@Autowired
	MemberService svc;

	@Autowired
	OauthService oauthService;
	
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String ctlMemberRegister(@ModelAttribute MemberVO mvo
			) {
		
		svc.svcInsertMember(mvo);
		//return "user/login_form";
		System.out.println(mvo.toString());
		return "redirect:jsp/member/member_login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String ctlMemberLogin(@RequestParam("email") String email
			, @RequestParam("pw") String pw
			) {
		
		MemberVO mvo = svc.svcloginMember(email, pw);

		System.out.println(mvo.toString());
		return "redirect:jsp/member/member_login.jsp";
	}
	

	@RequestMapping(value = "/loginPage", method = RequestMethod.GET)
	public String ctlLoginPage(Model model) {

		model.addAttribute("content", "jsp/member/member_login.jsp");
		return "index";
	}
	
	@RequestMapping(value = "/registerPage", method = RequestMethod.GET)
	public String ctlRegisterPage(Model model) {

		model.addAttribute("content", "jsp/member/member_register.jsp");
		return "index";
	}
	
	
}
//