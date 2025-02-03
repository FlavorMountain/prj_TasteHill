package com.tastehill.myweb.route;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.RouteMapper;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.route.RouteVO;

@Service
public class RouteServiceImpl implements RouteService {
	
	@Autowired 
	private PlaceService placeService;

    @Autowired
    private RouteMapper routeMapper;

    @Override
    public List<RouteVO> svcSelectRouteAllMy(int seqMember) {
        return routeMapper.searchRoutesByMember(seqMember);
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
	@Transactional
	public int svcCreateRouteWithPlaces(RouteVO route, List<PlaceVO> places) {
		// Route 저장
        routeMapper.insertRoute(route);
        int seqRoute = route.getSeq_route(); // MyBatis에서 자동 증가된 값 가져오기

        // RoutePlace 리스트 생성
        List<RoutePlaceVO> routePlaces = new ArrayList<>();
        for(int i = 0; i < places.size(); i++) {
        	 RoutePlaceVO routePlace = new RoutePlaceVO();
             routePlace.setSeq_route(seqRoute);
             int tmp = placeService.svcSelectPlaceByPlaceId(places.get(i).getPlace_id()).getSeq_place();
             routePlace.setSeq_place(tmp);
             routePlace.setOrder(i + 1);
             routePlace.setPrice(0);
             routePlaces.add(routePlace);
        }

        // RoutePlace 리스트 저장
        routeMapper.insertRoutePlaces(routePlaces);
        return 1;
	}

	@Override
	public List<RouteVO> svcSelectRoutesAndPlaceByMember(int seqMember) {
        return routeMapper.selectRoutesAndPlaceByMember(seqMember);
	}

	@Override
	public RouteVO svcSelectRoutesAndPlaceBySeqRoute(int seq_route) {
		return routeMapper.selectRoutesAndPlaceBySeqRoute(seq_route);
	}

	@Override
	public List<RouteVO> svcSelectAllRoutesAndPlace() {
		return routeMapper.selectAllRoutesAndPlace();
	}
    
}