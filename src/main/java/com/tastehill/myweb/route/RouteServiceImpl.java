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
    public void svcDeleteRoute(int seqRoute) {
    	routeMapper.deleteRoute(seqRoute);
    }

    @Override
    public List<RouteVO> svcSelectRouteAllByFork(int seqMember, int start, int end) {
        return routeMapper.selectFavoriteRoutes(seqMember, start, end);
    }
    
    @Override
    public List<RouteVO> svcSelectHotRoute(int start, int end){
    	return routeMapper.selectHotRoutes(start, end);
    }
    
    @Override
	public RouteVO svcSelectPinnedRoute(int seqMember) {
    	return routeMapper.getPinnedRouteBySeqMember(seqMember);
    }
    



	@Override
	@Transactional
	public int svcInsertRouteWithPlaces(RouteVO route, List<PlaceVO> places) {
		System.out.println("루트 삽입 !" + route.toString());
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

        System.out.println("ㅅㅄㅄ 제발" + routePlaces.toString());
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
	public List<RouteVO> svcSelectAllRoutesAndPlaceBySearchPlacePaging(int seq_place, int start, int end) {
        return routeMapper.selectAllRoutesAndPlaceBySearchPlacePaging(seq_place, start, end);
	}

	@Override
	public int svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(int seqPlace) {
		return routeMapper.selectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
	}

	@Override
	public void svcIncreaseFork(int seqRoute) {
		routeMapper.increaseFork(seqRoute);
	}

	@Override
	public void svcDecreaseFork(int seqRoute) {
		routeMapper.decreaseFork(seqRoute);
	}

	@Override
	public List<RouteVO> svcSelectAllRoutesAndPlaceByAddressPlacePaging(
			List<Integer> seqPlaceList, 
			int start,
			int end) {
		return routeMapper.selectAllRoutesAndPlaceByAddressPlacePaging(seqPlaceList, start, end);
	}

	@Override
	public int svcSelectHotRoutesSize() {
		return routeMapper.selectHotRoutesSize();
	}
	
    @Override
    public List<RouteVO> svsSearchRoutesByMember (int seqMember, int start, int end) {
        return routeMapper.searchRoutesByMember(seqMember, start, end);
    }
	

	public int svcSearchRoutesByMemberSize(int seqMember) {
		return routeMapper.searchRoutesByMemberSize(seqMember);
	}

	@Override
	public int svcSelectFavoriteRoutesCount(int seqMember) {
		int tmp = 0;
		tmp =  routeMapper.selectFavoriteRoutesCount(seqMember);
		return tmp;
	}

    
}