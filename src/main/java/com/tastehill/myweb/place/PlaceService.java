package com.tastehill.myweb.place;

import java.util.List;

public interface PlaceService {
	public void svcInsertPlace(PlaceDetailVO placeVO);
	
	public PlaceDetailVO svcInsertPlaceDetail(String placeId,String API_KEY);
	PlaceVO svcSelectPlaceByPlaceId(String placeId);
    List<PlaceVO> searchPlacesByName(String query);
    List<PlaceVO> searchPlacesByAddress(String query);
    PlaceDetailVO svcSelectPlaceDetailOne(String placeId);
}