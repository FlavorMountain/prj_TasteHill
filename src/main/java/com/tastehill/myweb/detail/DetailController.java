package com.tastehill.myweb.detail;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@Value("${google.map.apiKey}")
	private String API_KEY;
	
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
	
	@RequestMapping(value = "/detail/{seqRoute}", method = RequestMethod.GET)
	public String ctlDetailmapPage(HttpServletRequest request, Model model, 
			@PathVariable("seqRoute") int seqRoute) {
		
		HttpSession session =  request.getSession();
		//테스트용 멤버 1번
		session.setAttribute("SESS_MEMBER_ID", 1);
		session.setAttribute("API_KEY", API_KEY);
		

		MemberVO mvo = msvc.svcSelectMember(1);
		
		RouteVO rvo =  rsvc.svcSelectRoutesAndPlaceBySeqRoute(seqRoute);
		
		System.out.println(rvo.toString());
//		List<CommentsVO> clist = csvc.svcSelectComments(1);
//		model.addAttribute("MVO", mvo);
//		model.addAttribute("CLIST", clist);
		
		model.addAttribute("seqRoute", seqRoute);
		model.addAttribute("content", "jsp/detail/route_detail.jsp");
		return "index";
	}
	
	// 루트vo 전달
	// 공통 기능이 될거같아서 route쪽으로 빼야 될까 고민중
	@GetMapping("/detail/getRoute/{seqRoute}")
    public ResponseEntity<RouteVO> getRouteDetail(@PathVariable int seqRoute) {
		
        RouteVO rvo = rsvc.svcSelectRoutesAndPlaceBySeqRoute(seqRoute);
        if (rvo == null) {
            return ResponseEntity.status(404).body(null); 
        }
        return ResponseEntity.ok(rvo); 
    }
		
}