package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.place.PlaceVO.Photo;

import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
public class RouteController {
	
	@Autowired
	CommonService commonService;

	@Value("${google.map.apiKey}")
	private String API_KEY;

	@GetMapping("/route/{placeId}")
	public ResponseEntity<PlaceVO> getPlaceDetails(@PathVariable String placeId) {
	    try {
	        String url = String.format(
	            "https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&key=%s&fields=name,rating,photos,geometry,opening_hours,types",
	            placeId,
	            API_KEY
	        );
	        
	        RestTemplate restTemplate = new RestTemplate();
	        
//	        String rawResponse = restTemplate.getForObject(url, String.class);
//	        System.out.println("원문 응답!");
//	        System.out.println(rawResponse);

	       	        
	        PlaceVO response = restTemplate.getForObject(url, PlaceVO.class);
//	        System.out.println("vo에 담긴 값!");
//	        System.out.println(response.getResult().toString());
	        
	        // 사진 api 요청 url로 가져온다음 api에 다시 요청해서 리다이렉트 url을 추출하면
	        //사진 url이 됨
	        if (response != null && "OK".equals(response.getStatus())) {
	        	for(int i = 0; i < response.getResult().getPhotos().size(); i++) {
	        		Photo currPhoto = response.getResult().getPhotos().get(i);
	        		String photoApiUrl = currPhoto.makePhotoUrl(API_KEY, 400);
	        		currPhoto.setPhoto_url(commonService.fetchFinalImageUrl(photoApiUrl));
	        	}
	            return ResponseEntity.ok(response);
	        }
	        return ResponseEntity.status(500).body(null);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body(null);
	    }
	}
}

