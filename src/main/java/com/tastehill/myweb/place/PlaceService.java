package com.tastehill.myweb.place;

import java.util.List;

public interface PlaceService {
	public void svcSavePlace(PlaceDetailVO placeVO);
	
	public PlaceDetailVO svcSelectPlaceDetail(String placeId,String API_KEY);
	PlaceVO svcSelectPlaceByPlaceId(String placeId);
    List<PlaceVO> searchPlaces(String query);
    PlaceDetailVO svcSelectPlaceDetailOne(String placeId);
}