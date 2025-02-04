package com.tastehill.myweb.place;

import java.util.List;

public interface PlaceService {
	public void svcSavePlace(PlaceDetailVO placeVO);
	
	public PlaceDetailVO svcGetPlaceDetail(String placeId,String API_KEY);
	PlaceDetailVO svcSelectPlaceDetailByPlaceID(String placeId);
	
	PlaceVO svcSelectPlaceByPlaceId(String placeId);
    List<PlaceVO> searchPlaces(String query);
    
    PlaceDetailVO svcSelectDetailOne(String placeId);
  
}