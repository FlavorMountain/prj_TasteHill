package com.tastehill.myweb.route;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.RouteMapper;
import com.tastehill.myweb.route.RouteVO;

@Service
public class RouteServiceImpl implements RouteService {

    @Autowired
    private RouteMapper routeMapper;

    @Override
    public List<RouteVO> svcSelectRouteAllMy(int seqMember) {
        return routeMapper.selectRoutesByMember(seqMember);
    }

    @Override
    public void svcDelectRoute(int seqRoute) {
        routeMapper.deleteRoute(seqRoute);
    }

    @Override
    public List<RouteVO> svcSelectRouteAllByFork(int seqMember) {
        return routeMapper.selectFavoriteRoutes(seqMember);
    }
    
    @Override
    public List<RouteVO> svcSelectHotRoute(){
    	return routeMapper.selectHotRoutes();
    }
    
    @Override
	public RouteVO svcSelectPinnedRoute(int seqMember) {
    	return routeMapper.getPinnedRouteBySeqMember(seqMember);
    }
    
    @Override
    public List<RouteVO> searchRoutes(String query) {
        return routeMapper.searchRoutes(query);
    }

	@Override
	public int test() {
		// TODO Auto-generated method stub
		return 0;
	}
    
}