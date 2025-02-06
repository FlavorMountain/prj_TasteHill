package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.route.RoutePlaceVO;
import com.tastehill.myweb.route.RouteVO;

@Mapper
public interface RouteMapper {
	//특정 유저가 작성한 루트 리스트 가져오기
    List<RouteVO> selectRoutesAndPlaceByMember(@Param("seqMember") int seqMember);
    // 모든 루트 리스트 가져오기
    List<RouteVO> selectAllRoutesAndPlace();
    // seq_route로 단일 루트 가져오기
    RouteVO selectRoutesAndPlaceBySeqRoute(@Param("seq_route") int seq_route);

    
    
    
    void deleteRoute(int seqRoute);
    List<RouteVO> selectFavoriteRoutes(@Param("seqMember") int seqMember);
    
    List<RouteVO> selectHotRoutes(
    		@Param("start") int start,
    		@Param("end") int end
    		);
    RouteVO getPinnedRouteBySeqMember(int seqMember);

    List<RouteVO> searchRoutes(@Param("query") String query);
    
    // Route 생성
    int insertRoute(RouteVO route);

    // RoutePlace 관계 저장
    void insertRoutePlaces(@Param("routePlaces") List<RoutePlaceVO> routePlaces);
    
    List<RouteVO> selectAllRoutesAndPlaceBySearchPlacePaging(
    		@Param("seq_place") int seq_place,
    		@Param("start") int start,
    		@Param("end") int end);
    
    List<RouteVO> selectAllRoutesAndPlaceByAddressPlacePaging(
    		@Param("seqPlaceList") List<Integer> seqPlaceList,
    		@Param("start") int start,
    		@Param("end") int end);
    
	List<RouteVO> searchRoutesByMember(
			@Param("seqMember") int seqMember, 
			@Param("start") int start,
    		@Param("end") int end);
	
	int searchRoutesByMemberSize(@Param("seqMember") int seqMember);

	
	void increaseFork(@Param("seq_route") int seq_route);
	void decreaseFork(@Param("seq_route") int seq_route);
	
	int selectCountAllRoutesAndPlaceBySearchPlacePaging(@Param("seqPlace") int seqPlace);
	int selectHotRoutesSize();

}