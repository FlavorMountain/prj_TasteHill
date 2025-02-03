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
    List<RouteVO> selectFavoriteRoutes(int seqMember);
    
    List<RouteVO> selectHotRoutes();
    RouteVO getPinnedRouteBySeqMember(int seqMember);

    List<RouteVO> searchRoutes(@Param("query") String query);
    
    // Route 생성
    int insertRoute(RouteVO route);

    // RoutePlace 관계 저장
    void insertRoutePlaces(@Param("routePlaces") List<RoutePlaceVO> routePlaces);
    
    List<RouteVO> searchRoutesByMember(@Param("seqMember") int seqMember);

}