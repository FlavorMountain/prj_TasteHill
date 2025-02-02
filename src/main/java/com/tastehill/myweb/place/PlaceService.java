package com.tastehill.myweb.place;

public interface PlaceService {
	public void svcSavePlace(PlaceDetailVO placeVO);
	
	public PlaceDetailVO svcGetPlaceDetail(String placeId,String API_KEY);
	PlaceDetailVO svcSelectPlaceDetailByPlaceID(String placeId);
	
	PlaceVO svcSelectPlaceByPlaceId(String placeId);
}
