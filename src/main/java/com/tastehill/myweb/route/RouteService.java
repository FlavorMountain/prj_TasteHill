package com.tastehill.myweb.route;

import org.springframework.http.ResponseEntity;

import com.tastehill.myweb.place.OpeningHoursVO;
import com.tastehill.myweb.place.PhotoVO;
import com.tastehill.myweb.place.PlaceDetailVO;
import com.tastehill.myweb.route.RouteVO;
  import org.springframework.http.ResponseEntity;

import com.tastehill.myweb.place.OpeningHoursVO;
import com.tastehill.myweb.place.PhotoVO;
import com.tastehill.myweb.place.PlaceDetailVO;


public interface RouteService {
    List<RouteVO> svcSelectRouteAllMy(int seqMember);
    void svcDelectRoute(int seqRoute);
    List<RouteVO> svcSelectRouteAllByFork(int seqMember);
    
    List<RouteVO> svcSelectHotRoute();
    RouteVO svcSelectPinnedRoute(int seqMember);
    
    List<RouteVO> searchRoutes(String query);
  	public int test();
}
