package com.tastehill.myweb.detail;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
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
import com.tastehill.myweb.fork.ForkService;
import com.tastehill.myweb.fork.ForkVO;
import com.tastehill.myweb.member.MemberService;
import com.tastehill.myweb.member.MemberVO;
import com.tastehill.myweb.place.PhotoVO;
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
	private ForkService fsvc;
	@Autowired
	private PlaceService psvc;

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String ctlDetailPage(Model model, HttpSession session,
			@RequestParam("seq_route") int seqRoute) {

		RouteVO rvo = rsvc.svcSelectRoutesAndPlaceBySeqRoute(seqRoute);
		System.out.println("테스트으으 : " + rvo.toString());
		MemberVO mvo = msvc.svcSelectMember(rvo.getSeqMember());
		List<CommentsVO> clist = csvc.svcSelectComments(seqRoute);
		
		for(int i = 0; i < rvo.getPlaces().size(); i++) {
			int seqPlace = rvo.getPlaces().get(i).getSeq_place();
			rvo.getPlaces().get(i).getPlace().setPhotos(new PhotoVO());
			rvo.getPlaces().get(i).getPlace().getPhotos().
			setPhoto_url(psvc.selectPhotoUrlBySeqPlace(seqPlace));
			
		}

		session.setAttribute("API_KEY", API_KEY);
    
		ForkVO fvo = new ForkVO(0,0,0);
		if(session.getAttribute("SESS_MEMBER_ID") != null) {
			fvo = fsvc.selectFork((int)session.getAttribute("SESS_MEMBER_ID"), seqRoute);	
		}
    
		model.addAttribute("RVO", rvo);
		model.addAttribute("MVO", mvo);
		model.addAttribute("CLIST", clist);
		model.addAttribute("FVO", fvo);
		
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
  
	
	@GetMapping("/pinroute")
	public ResponseEntity<Map<String, Object>> pinRoute(@RequestParam("seqRoute") int seqRoute, HttpSession session) {

	    Map<String, Object> response = new HashMap<>();		
		if(session.getAttribute("SESS_MEMBER_ID") != null) {
			int seqMember = (int)session.getAttribute("SESS_MEMBER_ID");
			msvc.svcUpdateMemberPinnedRoute(seqMember, seqRoute);
			
			response.put("message", true);
			response.put("pin", msvc.svcSelectMember(seqMember).getPinnedRoute() == seqRoute);
		}
		else {
		    response.put("message", false);
		}
	    
	    return new ResponseEntity<>(response, HttpStatus.OK);
    }
		
}
