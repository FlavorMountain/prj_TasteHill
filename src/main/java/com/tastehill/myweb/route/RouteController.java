package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.place.PlaceDetailVO;

import java.util.ArrayList;
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

@Controller
@RequestMapping("/route")
public class RouteController {
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	PlaceService placeService;
	
	@Autowired
	RouteService routeService;

	@Value("${google.map.apiKey}")
	private String API_KEY;
	
	@GetMapping("")
	public String ctlSelectMap(HttpServletRequest request, Model model) {
		
		HttpSession session =  request.getSession();
		//테스트용 멤버 1번
		if(request.getSession().getAttribute("SESS_MEMBER_ID") == null) {
			return "redirect:/loginPage";
		}
		session.setAttribute("API_KEY", API_KEY);
		model.addAttribute("content", "/jsp/route/google_map.jsp");
		return "index";
	}

	 
	@PostMapping("/insertRoute")
	public String ctlInsertRoute(HttpServletRequest request, @RequestBody Map<String, Object> requestData, HttpSession session) {

	    try {
	        List<Map<String, String>> placesData = (List<Map<String, String>>) requestData.get("places");
	        String title = (String) requestData.get("title");
	        String contents = (String) requestData.get("contents");
	        
	        List<PlaceVO> plist = new ArrayList<PlaceVO>();
	        for(Map<String, String> pmap : placesData) {
	        	PlaceVO pvo = placeService.svcSelectPlaceByPlaceId(pmap.get("place_id"));
	        	plist.add(pvo);
	        	
//	            PlaceVO pvo = new PlaceVO();
//	            pvo.setPlace_id(pmap.get("place_id"));
//	            pvo.setName(pmap.get("name"));
//	            plist.add(pvo);
	        }
	        
	        
	        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! "+request.getSession().getAttribute("SESS_MEMBER_ID"));
	        
	        
	        RouteVO rvo = new RouteVO();
//	        rvo.setSeqMember((Integer) request.getSession().getAttribute("SESS_MEMBER_ID"));
	        rvo.setSeqMember((int)session.getAttribute("SESS_MEMBER_ID"));
	        rvo.setTitle(title);
	        rvo.setContents(contents);
	        
	        System.out.println("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" + rvo.toString());
	        
	        routeService.svcInsertRouteWithPlaces(rvo, plist);
	        return "redirect:/main";
	        
	    } catch (Exception e) {
	        return "redirect:/main";
	    }
	}
	
	
	// 루트 조회 테스트용
	
	 @GetMapping("/placeMember")
	    public ResponseEntity<String> getRoutePlacesByMember() {
	        List<RouteVO> rlist = routeService.svcSelectRoutesAndPlaceByMember(1);
	        System.out.println(rlist.toString());

	        return ResponseEntity.ok("데이터 수신 완료");
	    }
	 
	 @GetMapping("/placeSeq")
	    public ResponseEntity<String> getRoutePlaceBySeq() {
		 	RouteVO rvo = routeService.svcSelectRoutesAndPlaceBySeqRoute(25);
		 	System.out.println(rvo.toString());
	        return ResponseEntity.ok("데이터 수신 완료");
	    }
	 
	 
	 @GetMapping("/placeAll")
	    public ResponseEntity<String> getRoutePlacesAll() {
	        List<RouteVO> rlist = routeService.svcSelectAllRoutesAndPlace();
	        System.out.println(rlist.toString());
	        return ResponseEntity.ok("데이터 수신 완료");
	    }
}