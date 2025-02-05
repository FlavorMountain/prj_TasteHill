package com.tastehill.myweb.place;

import java.util.List;

import com.tastehill.myweb.route.RouteVO;

public interface PlaceService {
	public void svcInsertPlace(PlaceDetailVO placeVO);
	
	public PlaceDetailVO svcInsertPlaceDetail(String placeId,String API_KEY);
	PlaceVO svcSelectPlaceByPlaceId(String placeId);
	//네이게이션바 검색기능
    List<PlaceVO> searchBar(RouteVO routeVO);
    PlaceDetailVO svcSelectPlaceDetailOne(String placeId);
}