package com.tastehill.myweb.route;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import com.tastehill.myweb.place.PlaceVO;



public interface RouteService {
    List<RouteVO> svcSelectRouteAllMy(int seqMember);
    void svcDelectRoute(int seqRoute);
    List<RouteVO> svcSelectRouteAllByFork(int seqMember);
    
    List<RouteVO> svcSelectHotRoute();
    RouteVO svcSelectPinnedRoute(int seqMember);
    
  	
    int svcInsertRouteWithPlaces(RouteVO route, List<PlaceVO> places);
    
    //멤버가 작성한 루트 리스트
    List<RouteVO> svcSelectRoutesAndPlaceByMember(int seqMember);
    //특정 루트 가져오기
    RouteVO svcSelectRoutesAndPlaceBySeqRoute(int seq_route);
    //모든 루트 리스트
    List<RouteVO> svcSelectAllRoutesAndPlace();

	void svcIncreaseFork(int seqRoute);
	void svcDecreaseFork(int seqRoute);
	List<RouteVO> svcSelectAllRoutesAndPlaceBySearchPlacePaging(int seq_place, int start, int end);
	
	int svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(@Param("seqPlace") int seqPlace);

   }

