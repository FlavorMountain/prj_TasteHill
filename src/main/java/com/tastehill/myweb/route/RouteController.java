package com.tastehill.myweb.route;

import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;

@Controller
public class RouteController {

	@Value("${google.map.apiKey}")
	private String API_KEY;

	@GetMapping("/route/{placeId}")
	public ResponseEntity<PlaceDetailsVO> getPlaceDetails(@PathVariable String placeId) {
	    try {
	        String url = String.format(
	            "https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&key=%s&fields=name,rating,photos,geometry,opening_hours,types",
	            placeId,
	            API_KEY
	        );
	        
	        RestTemplate restTemplate = new RestTemplate();
	        
	        
	        String rawResponse = restTemplate.getForObject(url, String.class);
	        System.out.println("원문 응답!");
	        System.out.println(rawResponse);

	        
	        GooglePlaceResponse response = restTemplate.getForObject(url, GooglePlaceResponse.class);
//	        System.out.println(response.toString());
	        
	        if (response != null && "OK".equals(response.getStatus())) {
	            PlaceDetailsVO placeDetails = new PlaceDetailsVO();
	            placeDetails.setName(response.getResult().getName());
	            placeDetails.setRating(response.getResult().getRating());
	            placeDetails.setPhotos(response.getResult().getPhotoUrls(API_KEY));
	            placeDetails.setOpeningHours(response.getResult().getOpeningHours() != null 
	                ? response.getResult().getOpeningHours().getWeekdayText() : null);
	            placeDetails.setTypes(response.getResult().getTypes());
	            return ResponseEntity.ok(placeDetails);
	        }
	        return ResponseEntity.status(500).body(null);
	    } catch (Exception e) {
	        e.printStackTrace();
	        return ResponseEntity.status(500).body(null);
	    }
	}
}

