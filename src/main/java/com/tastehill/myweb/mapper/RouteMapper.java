package com.tastehill.myweb.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.route.RouteVO;

@Mapper
public interface RouteMapper {
    List<RouteVO> selectRoutesByMember(int seqMember);
    void deleteRoute(int seqRoute);
    List<RouteVO> selectFavoriteRoutes(int seqMember);
    
    List<RouteVO> selectHotRoutes();
    RouteVO getPinnedRouteBySeqMember(int seqMember);

    List<RouteVO> searchRoutes(@Param("query") String query);
}