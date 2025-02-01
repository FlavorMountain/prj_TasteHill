package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.place.PlaceVO.Photo;

import java.util.Base64;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
@RequestMapping("/route")
public class RouteController {
	
	@Autowired
	CommonService commonService;

	@Value("${google.map.apiKey}")
	private String API_KEY;
	
	@GetMapping("")
	public String getMap(HttpServletRequest request) {
		HttpSession session =  request.getSession();
		session.setAttribute("API_KEY", API_KEY);
		return "jsp/route/google_map";
	}

	@GetMapping("/{placeId}")
	public ResponseEntity<PlaceVO> getPlaceDetails(@PathVariable String placeId) {
	    try {
	        String url = String.format(
	                "https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&key=%s&fields=name,rating,photos,opening_hours,formatted_address&language=ko",
	            placeId,
	            API_KEY
	        );
	        
//	        System.out.println(url);
	        
	        RestTemplate restTemplate = new RestTemplate();
	       

	        PlaceVO response = restTemplate.getForObject(url, PlaceVO.class);
//	        System.out.println("vo에 담긴 값!");
	        
	        // 사진 api 요청 url로 가져온다음 api에 다시 요청해서 리다이렉트 url을 추출하면
	        //사진 url이 됨
	        if (response != null && "OK".equals(response.getStatus())) {
	        	if(response.getResult().getPhotos() != null) {
	        		for(int i = 0; i < response.getResult().getPhotos().size(); i++) {
		        		Photo currPhoto = response.getResult().getPhotos().get(i);
		        		String photoApiUrl = currPhoto.makePhotoUrl(API_KEY, 400);
		        		currPhoto.setPhoto_url(commonService.fetchFinalImageUrl(photoApiUrl));
		        	}
	        	}
	        	System.out.println(response.toString());
	            return ResponseEntity.ok(response);
	        }
	        return ResponseEntity.status(500).body(null);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body(null);
	    }
	}
}

