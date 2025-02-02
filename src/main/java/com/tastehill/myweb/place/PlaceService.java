package com.tastehill.myweb.place;

public interface PlaceService {
	public void svcSavePlace(PlaceVO placeVO);
	
	public PlaceVO svcGetPlaceDetail(String placeId,String API_KEY);
	PlaceVO svcSelectPlaceDetailByPlaceID(String placeId);
}
