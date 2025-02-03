package com.tastehill.myweb.route;

import java.util.List;

import com.tastehill.myweb.route.RouteVO;

public interface RouteService {
    List<RouteVO> svcSelectRouteAllMy(int seqMember);
    void svcDelectRoute(int seqRoute);
    List<RouteVO> svcSelectRouteAllByFork(int seqMember);
    
    List<RouteVO> svcSelectHotRoute();
    RouteVO svcSelectPinnedRoute(int seqMember);
    
    List<RouteVO> searchRoutes(String query);
}
