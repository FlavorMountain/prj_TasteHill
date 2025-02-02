package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.place.OpeningHoursVO;
import com.tastehill.myweb.place.PhotoVO;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceDetailVO;

import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping("/route")
public class RouteController {
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	PlaceService placeService;

	@Value("${google.map.apiKey}")
	private String API_KEY;
	
	@GetMapping("")
	public String getMap(HttpServletRequest request) {
		
		HttpSession session =  request.getSession();
		//테스트용 멤버 1번
		session.setAttribute("SESS_MEMBER_ID", 1);
		session.setAttribute("API_KEY", API_KEY);
		return "jsp/route/google_map";
	}

	@GetMapping("/{placeId}")
	public ResponseEntity<PlaceDetailVO> getPlaceDetails(@PathVariable String placeId) {
		PlaceDetailVO response = placeService.svcGetPlaceDetail(placeId, API_KEY);
		if(response != null) {
			return ResponseEntity.ok(response);
		}
		else return ResponseEntity.status(500).body(null);
	   
	}
	
	@ResponseBody
	@GetMapping("/test")
	public String test() {
		System.out.println(placeService.svcSelectPlaceDetailByPlaceID("ChIJHT_MrIRZezUR-BPnggy311E").toString());
		return "test";
	}
}

