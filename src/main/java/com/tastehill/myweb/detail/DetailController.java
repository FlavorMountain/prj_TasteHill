package com.tastehill.myweb.detail;

import java.util.List;
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
import com.tastehill.myweb.comments.CommentsService;
import com.tastehill.myweb.comments.CommentsVO;
import com.tastehill.myweb.member.MemberService;
import com.tastehill.myweb.member.MemberVO;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;



@Controller
public class DetailController {
	
	@Autowired
	private MemberService msvc;
	@Autowired
	private CommentsService csvc;
	@Autowired
	private RouteService rsvc;
	@Autowired
	private PlaceService psvc;

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String ctlDetailPage(Model model, 
			@RequestParam("seqRoute") int seqRoute) {

		RouteVO rvo = rsvc.svcSelectRoutesAndPlaceBySeqRoute(seqRoute);
		MemberVO mvo = msvc.svcSelectMember(rvo.getSeqMember());
		List<CommentsVO> clist = csvc.svcSelectComments(seqRoute);

		model.addAttribute("RVO", rvo);
		model.addAttribute("MVO", mvo);
		model.addAttribute("CLIST", clist);
		
		
		model.addAttribute("content", "jsp/detail/route_detail.jsp");
		return "index";
	}
		
}