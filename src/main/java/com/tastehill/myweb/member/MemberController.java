package com.tastehill.myweb.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

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
	public String ctlMemberRegister(@ModelAttribute MemberVO mvo) {
		if (oauthService.svcCheckExistUser(mvo.getEmail()) == null) {
			if(mvo.getProfile() == null) {
				mvo.setProfile("/resources/images/tastehill.png");
			}
			svc.svcInsertMember(mvo);
			return "redirect:/loginPage";
		} else {
			return "redirect:/loginPage";
		}
	}

	@PostMapping("/emailcheck")
	public ResponseEntity<Map<String, Boolean>> checkEmail(@RequestBody Map<String, String> request) {
		String email = request.get("email");
		boolean exists = oauthService.svcCheckExistUser(email) == null ? true : false;
		
		Map<String, Boolean> response = new HashMap<>();
		response.put("exists", exists);
		return ResponseEntity.ok(response);
	}

	

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String ctlMemberLogin(Model model, @RequestParam("email") String email, @RequestParam("pw") String pw,
			HttpServletRequest request) {

		MemberVO mvo = svc.svcloginMember(email, pw);

		if (mvo != null && mvo.getStatus() != 0) {
			request.getSession().setAttribute("SESS_EMAIL", mvo.getEmail());
			request.getSession().setAttribute("SESS_MEMBER_ID", mvo.getSeqMember());
			request.getSession().setAttribute("SESS_NICKNAME", mvo.getNickname());
			request.getSession().setAttribute("SESS_PROFILE", mvo.getProfile());

			model.addAttribute("MVO", mvo);

			return "redirect: /profile";
		} else {
			return "redirect: /loginPage";
		}
	}

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String ctlFormLoginProcess(HttpServletRequest request) {
		request.getSession().invalidate();
		request.getSession().setMaxInactiveInterval(0);
		return "redirect: /loginPage";
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

	@RequestMapping(value = "/login/{socialType}", method = RequestMethod.GET)
	public String loginForm(Model model, @PathVariable("socialType") SocialType socialType,
			HttpServletRequest request) {
		String loginFormUrl = oauthService.svcLoginFormURL(socialType);
		System.out.println(loginFormUrl);
		request.getSession().setAttribute("SESS_SOCIALTYPE", socialType);
		return "redirect:" + loginFormUrl;
	}

	@RequestMapping(value = "/oauth2callback/{socialType}", method = RequestMethod.GET)
	public String ctlCallback(Model model, @PathVariable("socialType") SocialType socialType,
			@RequestParam("code") String code, @RequestParam(value = "state", required = false) String state,
			HttpServletRequest request) {
		// ??????
		socialType = (SocialType) request.getSession().getAttribute("SESS_SOCIALTYPE");
		System.out.println(socialType + "----" + code);

		// CODE를 사용해 ACCESS TOKEN 받기
		Map<String, String> responseMap = oauthService.svcRequestAccessToken(socialType, code, state);
		String accessToken = (String) responseMap.get("access_token");
		String refreshToken = (String) responseMap.get("refresh_token");
		System.out.println("OauthController.ctlCallback() access_token:" + accessToken);
		System.out.println("OauthController.ctlCallback() refresh_token:" + refreshToken);

		// //-------------------------------------------------------------------------
		// // 토큰 유효성 검증
		// // 엔드포인트 : https://oauth2.googleapis.com/tokeninfo
		// // 파라미터 : access_token/id_token
		// //-------------------------------------------------------------------------
		// //String jwtToken = googleResponseVO.getBody().getId_token();
		// RestTemplate restTemplate = new RestTemplate();
		// Map<String, String> map=new HashMap<>();
		// map.put("id_token", accessToken);
		// ResponseEntity<GoogleInfResponseVO> googleInfResponse =
		// restTemplate.postForEntity("https://oauth2.googleapis.com/tokeninfo", map,
		// GoogleInfResponseVO.class);
		// System.out.println(googleInfResponse.toString());

		// ACCESS TOKEN을 사용해 REST 서비스(유저정보) 받기
		Map<String, String> userInfo = oauthService.svcRequestUserInfo(socialType, accessToken);
		System.out.println("OauthController.ctlCallback():" + userInfo.toString());

		String viewPage = "lec_oauth/login_page";
		if (userInfo != null) {
			// ------------------------------------------------------------
			// userInfo.get("email")을 사용해 DB조회(기존회원 & 신규회원)
			// ------------------------------------------------------------
			MemberVO mvo = oauthService.svcCheckExistUser(userInfo.get("email"));
			if (mvo == null) {
				// OAuth :: 신규 회원일 경우 -- accessToken : 세션에 담고 추가 회원가입페이지로 이동
				request.getSession().setAttribute("SESS_REGISTER_EMAIL", userInfo.get("email"));
				request.getSession().setAttribute("SESS_PICTURE", userInfo.get("profile"));
				request.getSession().setAttribute("SESS_ACCESS_TOKEN", accessToken);
				request.getSession().setAttribute("SESS_REFRESH_TOKEN", refreshToken);
				viewPage = "jsp/member/oauth_join_page";
			} else {
				// OAuth :: 기존 회원일 경우 -- 토큰만 다시 저장(변경이 있을 수 있으므로) : 세션에 담고 마이페이지로 이동
				// 토큰정보
				UsersOauthVO usersOauthVO = new UsersOauthVO();
				usersOauthVO.setPicture(userInfo.get("profile"));
				usersOauthVO.setAccessToken(accessToken);
				usersOauthVO.setRefreshToken(refreshToken);
				usersOauthVO.setSeqMember(mvo.getSeqMember());

				request.getSession().setAttribute("SESS_EMAIL", userInfo.get("email"));
				request.getSession().setAttribute("SESS_PICTURE", userInfo.get("profile"));
				// request.getSession().setAttribute("SESS_ACCESS_TOKEN" , accessToken);
				// request.getSession().setAttribute("SESS_REFRESH_TOKEN" , refreshToken);
				request.getSession().setAttribute("SESS_MEMBER_ID", mvo.getSeqMember());
				request.getSession().setAttribute("SESS_NICKNAME", mvo.getNickname());

				viewPage = "redirect: /main";
			}
		}
		return viewPage;
	}

	// OAuth :: 신규회원: 회원정보저장 + 토큰저장
	@RequestMapping(value = "/oauth_join_process", method = RequestMethod.POST)
	public String ctlOauthJoinProcess(Model model, HttpServletRequest request, @ModelAttribute MemberVO mvo) {

		// 토큰정보
		UsersOauthVO usersOauthVO = new UsersOauthVO();
		usersOauthVO.setPicture((String) request.getSession().getAttribute("SESS_PICTURE"));
		usersOauthVO.setAccessToken((String) request.getSession().getAttribute("SESS_ACCESS_TOKEN"));
		usersOauthVO.setRefreshToken((String) request.getSession().getAttribute("SESS_REFRESH_TOKEN"));

		// 회원정보
//		mvo.setEmail((String)request.getSession().getAttribute("SESS_REGISTER_EMAIL"));
		// usersTblVO.setUserPw(userPw);
		// usersTblVO.setUserName(userName);
		mvo.setProfile(usersOauthVO.getPicture());
		mvo.setUsersOauthVO(usersOauthVO);

		int insertUserSeq = oauthService.svcInsertToken(mvo);

		String viewPage = "redirect: /login_page";
		if (insertUserSeq < 0) {
			// 회원가입실패 : lec_oauth/login_page.jsp로 이동
			request.getSession().invalidate();
		} else {
			// 회원가입성공 : lec_oauth/mypage.jsp로 이동

			// DB에 들어간 구글관련 정보들은 세션에서 삭제
			// request.getSession().removeAttribute("SESS_EMAIL");
			// request.getSession().removeAttribute("SESS_PROVIDER");
			// request.getSession().removeAttribute("SESS_PICTURE");
			request.getSession().removeAttribute("SESS_ACCESS_TOKEN");
			request.getSession().removeAttribute("SESS_REFRESH_TOKEN");

			// 우리 서비스에 필요한 세션만 유지
			request.getSession().setAttribute("SESS_MEMBER_ID", mvo.getSeqMember());
			request.getSession().setAttribute("SESS_NICKNAME", mvo.getNickname());
			viewPage = "redirect: /main";
		}
		return viewPage;
	}

}
//