package com.tastehill.myweb.place;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.common.CommonService;
import com.tastehill.myweb.mapper.PlaceMapper;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.mapper.PlaceMapper;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
    private PlaceMapper placeMapper;
	
	@Autowired
	CommonService commonService;
	
  @Override
    public List<PlaceVO> searchPlaces(String query) {
        return placeMapper.searchPlaces(query);
    }


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
	        	svcSavePlace(response);
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
	public PlaceVO svcSelectPlaceByPlaceId(String placeId) {
		return placeMapper.selectPlaceByPlaceId(placeId);
	}
    
    

	//트랜잭션으로 묶어서 가져오는 방법으로 변경
	@Transactional
	@Override
	public PlaceDetailVO svcSelectPlaceDetailByPlaceID(String placeId) {
		// 장소 정보 받아오기
		PlaceVO pvo = placeMapper.selectPlaceByPlaceId(placeId);
		
		// pvo가 없으면 db에 없는것, 바로 리턴
		if(pvo == null) return null;
		
		// 빈 장소상세 vo 만들기
		PlaceDetailVO pdvo = new PlaceDetailVO();
		
		// 장소상세VO에 값 넣어줄 결과VO 만들기
		ResultVO rvo = new ResultVO();
	
		// 장소상세 vo에 seq랑 status 넣어주기, 이미 db에 들어간거는 항상 응답 성공인걸로 가정
		int pseq = pvo.getSeq_place();
		pdvo.setSeqPlace(pseq);
		pdvo.setStatus("OK");
		
		// 결과 vo에 장소 정보 넣어주기
		rvo.setPlace_id(pvo.getPlace_id());
		rvo.setName(pvo.getName());
		rvo.setRating(pvo.getRating());
		rvo.setFormatted_address(pvo.getFormatted_address());

		
		// 위도 경도 정보 받아오기
		GeometryVO gvo = placeMapper.selectGeometryByPlaceId(pseq);
		LocationVO lvo = placeMapper.selectLocationByPlaceId(pseq);
		gvo.setLocation(lvo);
		rvo.setGeometry(gvo);
		
		// 영업 정보 받아오기
		OpeningHoursVO ovo = placeMapper.selectOpeningHoursByPlaceId(pseq);
		if(ovo != null) {
			List<WeekdayTextVO> wlist = placeMapper.selectAllWeekdayTextByPlaceId(pseq);
			ovo.setWeekday_text(wlist);
			rvo.setOpening_hours(ovo);
		}
		
		// 사진 정보 받아오기
		List<PhotoVO> plist = placeMapper.selectAllPhotosByPlaceId(pseq);
		rvo.setPhotos(plist);
		pdvo.setResult(rvo);
		
		return pdvo;
	}
}