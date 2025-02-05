package com.tastehill.myweb.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tastehill.myweb.common.PagingUtil;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/routeList")
public class RouteListController {
	
	@Autowired
    private RouteService routeService;

    @Autowired
    private PlaceService placeService;
    
    // 검색창
    @GetMapping("/searchList")
    public String searchAll(
            @RequestParam(value = "query", required = false) String query,
            Model model) {

        // Route와 Place 검색
    	List<PlaceVO> searchPlaces = placeService.searchPlacesByName(query);
    	if(searchPlaces != null) {
    		
    		int blockCount = 3; 
    		int blockPage = 10;
    		
    		int seqPlace = searchPlaces.get(0).getSeq_place();
    		
    		int currentPage = 1;
    		int size = routeService.svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
    		PagingUtil pg = new PagingUtil("/searchList", currentPage, size, blockCount, blockPage);
    		List<RouteVO> searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlacePaging(seqPlace, pg.getStartSeq(), pg.getEndSeq());

    		
            for(RouteVO x : searchRoutes) {
            	System.out.println(x.toString());
            }
    		
    		model.addAttribute("searchRoutes", searchRoutes);    	
    		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());

    	}

        // 검색 결과를 모델에 추가
        model.addAttribute("searchPlaces", searchPlaces);
        
        // routee_list.jsp 페이지로 이동
	    model.addAttribute("content", "/jsp/route/route_list.jsp");
	    return "index";
    }
    
    
}