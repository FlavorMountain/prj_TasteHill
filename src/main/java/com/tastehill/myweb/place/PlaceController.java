package com.tastehill.myweb.place;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	@Autowired
	PlaceService placeService;
	
	@Value("${google.map.apiKey}")
	private String API_KEY;
	

	@GetMapping("/{placeId}")
	public ResponseEntity<PlaceDetailVO> ctlSelectPlaceDetails(@PathVariable String placeId) {

		//일단 db에 있는지 찾기
		PlaceDetailVO response = placeService.svcSelectPlaceDetailOne(placeId);
		//없으면 url로 장소상세 요청보내서 가져오고 db에 추가
		if(response == null) {
			response = placeService.svcInsertPlaceDetail(placeId, API_KEY);
			if(response != null) {
				response.setStatus("OK");
				return ResponseEntity.ok(response);
			}
			else return ResponseEntity.status(500).body(null);
		}
		else return ResponseEntity.ok(response);
	}
}
//