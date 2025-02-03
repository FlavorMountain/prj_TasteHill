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
	public String getMap(HttpServletRequest request, Model model) {
		
		HttpSession session =  request.getSession();
		//테스트용 멤버 1번
		session.setAttribute("SESS_MEMBER_ID", 1);
		session.setAttribute("API_KEY", API_KEY);
		model.addAttribute("content", "/jsp/route/google_map.jsp");
		return "index";
	}
	

	@GetMapping("/{placeId}")
	public ResponseEntity<PlaceDetailVO> getPlaceDetails(@PathVariable String placeId) {
		//일단 db에 있는지 찾기
		PlaceDetailVO response = placeService.svcSelectPlaceDetailByPlaceID(placeId);
		//없으면 url로 장소상세 요청보내서 가져오고 db에 추가
		if(response == null) {
			response = placeService.svcGetPlaceDetail(placeId, API_KEY);
			if(response != null) {
				return ResponseEntity.ok(response);
			}
			else return ResponseEntity.status(500).body(null);
		}
		else return ResponseEntity.ok(response);
	}
	
	 //이 부분 글 작성시 요청보내도록 수정해야됨
//	 @PostMapping("/list")
//	    public ResponseEntity<String> receivePlaces(@RequestBody List<PlaceVO> plist) {
//	        // 받은 데이터 출력
//	        for (PlaceVO place : plist) {
//	        	System.out.println(place.toString());
//	        }
//	        RouteVO rvo = new RouteVO();
//	        rvo.setSeqMember(1);
//	        rvo.setTitle("test title");
//	        rvo.setContents("test contents");
//	        routeService.svcInsertRouteWithPlaces(rvo, plist);
//
//	        return ResponseEntity.ok("데이터 수신 완료");
//	    }
	 
	@PostMapping("/list")
	public String receivePlaces(@RequestBody Map<String, Object> requestData) {
	    try {
	        List<Map<String, String>> placesData = (List<Map<String, String>>) requestData.get("places");
	        String title = (String) requestData.get("title");
	        String contents = (String) requestData.get("contents");
	        
	        List<PlaceVO> plist = new ArrayList<PlaceVO>();
	        for(Map<String, String> pmap : placesData) {
	            PlaceVO pvo = new PlaceVO();
	            pvo.setPlace_id(pmap.get("place_id"));
	            pvo.setName(pmap.get("name"));
	            plist.add(pvo);
	        }
	        
	        RouteVO rvo = new RouteVO();
	        rvo.setSeqMember(1);
	        rvo.setTitle(title);
	        rvo.setContents(contents);
	        
	        routeService.svcInsertRouteWithPlaces(rvo, plist);
	        return "redirect:/main";
	        
	    } catch (Exception e) {
	        return "redirect:/main";
	    }
	}
	
	
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

