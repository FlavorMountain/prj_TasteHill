package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.place.PlaceVO;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
public class RouteController {

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
	        System.out.println("vo에 담긴 값!");
	        System.out.println(response.getResult().toString());
	        
	        if (response != null && "OK".equals(response.getStatus())) {
	            PlaceVO pvo = new PlaceVO();
	            return ResponseEntity.ok(pvo);
	        }
	        return ResponseEntity.status(500).body(null);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body(null);
	    }
	}
}

