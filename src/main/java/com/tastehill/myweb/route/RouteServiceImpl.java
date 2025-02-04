package com.tastehill.myweb.route;

import java.util.ArrayList;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tastehill.myweb.mapper.RouteMapper;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;

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
	@Transactional
	public int svcInsertRouteWithPlaces(RouteVO route, List<PlaceVO> places) {
        routeMapper.insertRoute(route);
        int seqRoute = route.getSeq_route(); 

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

	@Override
	public List<RouteVO> svcSelectAllRoutesAndPlaceBySearchPlace(int seq_place) {
		// seq_place 기준으로 루트 찾기
        return routeMapper.selectAllRoutesAndPlaceBySearchPlace(seq_place);
	}
    
}