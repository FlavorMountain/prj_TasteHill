package com.tastehill.myweb.place;


import java.util.HashMap;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.mapper.PlaceMapper;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
    private PlaceMapper placeMapper;
	
	@Autowired
	CommonService commonService;
	
	@Autowired
	PlaceService placeService;

	//placeVO에 연관 VO 5개가 박혀서 6개 한방에 묶었습니다
    @Transactional
	@Override
	public void svcSavePlace(PlaceDetailVO placeVO) {
    	
        // PLACE 데이터 삽입
        placeMapper.insertPlace(placeVO);
        int seqPlace = placeVO.getSeqPlace();
        System.out.println(seqPlace);
        String placeId = placeVO.getResult().getPlace_id();

        // PHOTO 데이터 삽입
        if (placeVO.getResult().getPhotos() != null) {
            for (PhotoVO photo : placeVO.getResult().getPhotos()) {
            	System.out.println(photo.toString());
                
                //인자 안먹어서 맵으로 던짐
                Map<String, Object> photoMap = new HashMap<>();
                photoMap.put("seqPlace", seqPlace);
                photoMap.put("photoReference", photo.getPhoto_reference());
                photoMap.put("photoUrl", photo.getPhoto_url());
                photoMap.put("placeId", placeId);
                System.out.println(photoMap.toString());
                placeMapper.insertPhoto(photoMap);
            }
        }

        // OPENING_HOURS 데이터 삽입
        if (placeVO.getResult().getOpening_hours() != null) {
            Map<String, Object> omap = new HashMap<>();
            omap.put("seqPlace", seqPlace);
            omap.put("placeId", placeId);
            placeMapper.insertOpeningHours(omap);
        
            // 영업시간 정보 있으면 WEEKDAY_TEXT 데이터 삽입
            for (WeekdayTextVO weekday : placeVO.getResult().getOpening_hours().getWeekday_text()) {
                Map<String, Object> wmap = new HashMap<>();
                wmap.put("seqPlace", seqPlace);
                wmap.put("placeId", placeId);
                wmap.put("weekday_text", weekday.getWeekday_text());
                placeMapper.insertWeekdayText(wmap);
            }
        }
        
        // GEOMETRY 데이터 삽입
        if (placeVO.getResult().getGeometry() != null) {
            Map<String, Object> gmap = new HashMap<>();
            gmap.put("seqPlace", seqPlace);
            gmap.put("placeId", placeId);
            placeMapper.insertGeometry(gmap);
        }
        
        
        // LOCATION 데이터 삽입
        LocationVO location = placeVO.getResult().getGeometry().getLocation();
        Map<String, Object> lmap = new HashMap<>();
        lmap.put("seqPlace", seqPlace);
        lmap.put("placeId", placeId);
        lmap.put("lat", location.getLat());
        lmap.put("lng", location.getLng());
        placeMapper.insertLocation(lmap);
    }
    
    
    // 새로 장소 저장해서 리턴 or 있는거 select해서 넘겨주기
    public PlaceDetailVO svcGetPlaceDetail(String placeId,String API_KEY) {
		try {
	        String url = String.format(
	                "https://maps.googleapis.com/maps/api/place/details/json?place_id=%s&key=%s&fields=place_id,geometry,name,rating,photos,opening_hours,formatted_address&language=ko",
	            placeId,
	            API_KEY
	        );
			RestTemplate restTemplate = new RestTemplate();

	        System.out.println(url);
	        
	       
	        PlaceDetailVO response = restTemplate.getForObject(url, PlaceDetailVO.class);
//	        System.out.println("vo에 담긴 값!");
	        
	        //placeID VO마다 담기
	        if (response != null && "OK".equals(response.getStatus())) {
	         	OpeningHoursVO ovo =  response.getResult().getOpening_hours();
	        	if(ovo != null) {
	        		ovo.setPlace_id(placeId);
	        		for(int i = 0; i < ovo.getWeekday_text().size(); i++) {
	        			 ovo.getWeekday_text().get(i).setPlace_id(placeId);
	        		}
	        	}
	        	response.getResult().getGeometry().setPlace_id(placeId);
	        	response.getResult().getGeometry().getLocation().setPlace_id(placeId);
	        	
	        	
	        	// 사진 api 요청 url로 가져온다음 api에 다시 요청해서 리다이렉트 url을 추출하면 사진 url이 됨
	        	if(response.getResult().getPhotos() != null) {
	        		for(int i = 0; i < response.getResult().getPhotos().size(); i++) {
		        		PhotoVO currPhoto = response.getResult().getPhotos().get(i);
		        		currPhoto.setPlace_id(placeId);
		        		String photoApiUrl = currPhoto.makePhotoUrl(API_KEY, 400);
		        		currPhoto.setPhoto_url(commonService.fetchFinalImageUrl(photoApiUrl));
		        	}
	        	}
	        	System.out.println(response.toString());
	        	System.out.println("Before Insert SEQ: " + response.getSeqPlace());
	        	placeService.svcSavePlace(response);
	        	System.out.println("after Insert SEQ: " + response.getSeqPlace());
	            return response;
	        }
	        return null;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
    
    


	@Override
	public PlaceDetailVO svcSelectPlaceDetailByPlaceID(String placeId) {
		PlaceDetailVO pvo = placeMapper.selectPlaceDetailByPlaceID(placeId);
		return pvo;
	}

}
