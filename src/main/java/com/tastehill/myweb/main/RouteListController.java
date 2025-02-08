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

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpSession;

@Controller
public class RouteListController {
	
	@Autowired
    private RouteService routeService;

	@Autowired
    private PlaceService placeService;
	
    
    // 장소 리스트 검색창
    @GetMapping("/searchPlaceList")
    public String searchPlaces(
            @RequestParam(value = "searchGubun", required = false) String searchGubun,
            @RequestParam(value = "searchStr", required = false) String searchStr,
            Model model) {
    	
    	if (searchStr == null || searchStr.isEmpty()) {
            model.addAttribute("MY_KEY_PAGING_HTML", "");
            model.addAttribute("content", "/jsp/route/route_list.jsp");
    	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
    	    return "index";
    	}

        // Route와 Place 검색
    	RouteVO routeVO  = new RouteVO();
    	routeVO.setSearchGubun(searchGubun);
    	routeVO.setSearchStr(searchStr);
    	List<PlaceVO> searchRes = placeService.searchBar(routeVO);
		 model.addAttribute("searchBarRes", searchRes);  
		 model.addAttribute("pageType", "searchStr");
        
	    // 검색 결과 페이지로 이동
       model.addAttribute("content", "/jsp/route/route_list.jsp");
	   model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
      return "index";
    }
    
    // 장소 -> 동선 검색 컨트롤러
    @GetMapping("/searchList2")
    public String searchRoutesByPlaceSeq(
            @RequestParam(value = "seqPlace", required = false) int seqPlace,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            Model model) {


    		int blockCount = 4; 
    		int blockPage = 10;
    		int size = routeService.svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
    		PagingUtil pg = new PagingUtil("/searchList2?seqPlace="+ seqPlace, currentPage, size, blockCount, blockPage);
    		List<RouteVO> searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlacePaging(seqPlace, pg.getStartSeq(), pg.getEndSeq());
//            List<PlaceVO> searchPlaces = placeService.svcSelectPlaceListBySeqRoute(size);
	    	if (searchRoutes.isEmpty()) {
	            model.addAttribute("searchRoutes", Collections.emptyList());
	            model.addAttribute("MY_KEY_PAGING_HTML", "");
	            model.addAttribute("content", "/jsp/route/route_list.jsp");
	    	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
	            return "index";
	        }
    		
	    	for(int i = 0; i < searchRoutes.size(); i++) {
	    		searchRoutes.get(i).setPlist(placeService.svcSelectPlaceListBySeqRoute(searchRoutes.get(i).getSeq_route()));
	    	}
	    	
    		model.addAttribute("seqPlace", seqPlace);
    		model.addAttribute("searchRoutes", searchRoutes);    	
    		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());
		    model.addAttribute("content", "/jsp/route/route_list.jsp");
		    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
		    return "index";
    }


    @GetMapping("/searchRouteList")
    public String searchAll(
    		@RequestParam(value = "searchGubun", required = false) String searchGubun,
            @RequestParam(value = "searchStr", required = false) String searchStr,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "seqPlace", required = false, defaultValue = "1") int seqPlace,
            Model model) {
    	
    	if (searchStr.isEmpty()) {
            model.addAttribute("searchRoutes", Collections.emptyList());
            model.addAttribute("MY_KEY_PAGING_HTML", "");
            model.addAttribute("content", "/jsp/route/route_list.jsp");
    	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
            return "index";
        }
    	
    	List<PlaceVO> searchPlaces;
    	List<RouteVO> searchRoutes;
		int blockCount = 4; 
		int blockPage = 10;
		PagingUtil pg;
    	
		//동선 주소로 검색
    	if(searchGubun.equals("formatted_address") || searchGubun.isEmpty()) {
        	searchPlaces = placeService.svcSearchPlacesByAddress(searchStr);
	    	if (searchPlaces.isEmpty()) {
	            model.addAttribute("searchRoutes", Collections.emptyList());
	            model.addAttribute("MY_KEY_PAGING_HTML", "");
	            model.addAttribute("content", "/jsp/route/route_list.jsp");
	    	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
	            return "index";
	        }
        	List<Integer> seqPlaceList = new ArrayList<Integer>();
        	for(int i = 0; i < searchPlaces.size(); i++) {
        		seqPlaceList.add(searchPlaces.get(i).getSeq_place());
        	}
        	
    		int size = searchPlaces.size();
    		pg = new PagingUtil("/searchRouteList?" + "&searchGubun=" + searchGubun + "&searchStr=" + searchStr,
    				currentPage, size, blockCount, blockPage);
    		searchRoutes = routeService.svcSelectAllRoutesAndPlaceByAddressPlacePaging(seqPlaceList, pg.getStartSeq(), pg.getEndSeq());
	    	for(int i = 0; i < searchRoutes.size(); i++) {
	    		searchRoutes.get(i).setPlist(placeService.svcSelectPlaceListBySeqRoute(searchRoutes.get(i).getSeq_route()));
	    	}
    		System.out.println("제발...." + searchRoutes);
    	}
    	
    	//동선 장소로 검색
    	else {
    		searchPlaces = placeService.svcSearchPlacesByName(searchStr);
	    	if (searchPlaces.isEmpty()) {
	            model.addAttribute("searchRoutes", Collections.emptyList());
	            model.addAttribute("MY_KEY_PAGING_HTML", "");
	            model.addAttribute("content", "/jsp/route/route_list.jsp");
	    	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
	            return "index";
	        }
    		seqPlace = searchPlaces.get(0).getSeq_place();
    		int size = routeService.svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
    		pg = new PagingUtil("/searchRouteList?seqPlace=" + seqPlace  
    				+ "&searchGubun=" + searchGubun + "&searchStr=" + searchStr,
    				currentPage, size, blockCount, blockPage);
    		searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlacePaging(seqPlace, pg.getStartSeq(), pg.getEndSeq());
	    	for(int i = 0; i < searchRoutes.size(); i++) {
	    		searchRoutes.get(i).setPlist(placeService.svcSelectPlaceListBySeqRoute(searchRoutes.get(i).getSeq_route()));
	    	}
    	}
    	
        // Route와 Place 검색
    	if (searchPlaces != null && !searchPlaces.isEmpty()) {
    		model.addAttribute("seqPlace", seqPlace);
    		model.addAttribute("searchRoutes", searchRoutes);    	
    		model.addAttribute("searchPlaces", searchPlaces);
    		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());
    	}
	    model.addAttribute("content", "/jsp/route/route_list.jsp");
	    return "index";
    }
    
    // 핫 동선 리스트
    @GetMapping("/hotList")
    public String hotRoutesPage(Model model,
    		 @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
             @RequestParam(value = "seqPlace", required = false, defaultValue = "1") int seqPlace
    		) {
		int blockCount = 4; 
		int blockPage = 10;
    	
		//바꿔야됨
    	int size = routeService.svcSelectHotRoutesSize();
		PagingUtil pg = new PagingUtil("/hotList?seqPlace", currentPage, size, blockCount, blockPage);
    	
        List<RouteVO> hotRoutes = routeService.svcSelectHotRoute(pg.getStartSeq(), pg.getEndSeq());
    	for(int i = 0; i < hotRoutes.size(); i++) {
    		hotRoutes.get(i)
    		.setPlist(placeService.svcSelectPlaceListBySeqRoute(hotRoutes
    				.get(i).getSeq_route()));
    	}
        model.addAttribute("pageType", "hotList");
	    model.addAttribute("hotRoutes", hotRoutes);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());
	    return "index";
    }
    
    
    
    
    
    // 마이페이지 동선 리스트
    @RequestMapping(value = "/myRoutes")
    public String getMyRoutes(Model model, HttpSession session,
    		@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "seqPlace", required = false, defaultValue = "1") int seqPlace
    		) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "redirect:/myroutes"; //"redirect:/loginPage"
        }

        
		int blockCount = 4; 
		int blockPage = 10;
    	int size = routeService.svcSearchRoutesByMemberSize(seqMember);
		PagingUtil pg = new PagingUtil("/myRoutes?", currentPage, size, blockCount, blockPage);
        
        List<RouteVO> myRoutes = routeService.svsSearchRoutesByMember(seqMember, pg.getStartSeq(), pg.getEndSeq());
    	for(int i = 0; i < myRoutes.size(); i++) {
    		myRoutes.get(i)
    		.setPlist(placeService.svcSelectPlaceListBySeqRoute(myRoutes
    				.get(i).getSeq_route()));
    	}
        
        
        model.addAttribute("pageType", "myRoutes");        
        model.addAttribute("myRoutes", myRoutes);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());

        return "index";
    }
    
    // 즐겨찾기 리스트
    @RequestMapping(value = "/forkList")
    public String getFavorites(Model model, HttpSession session,
    		@RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            @RequestParam(value = "seqPlace", required = false, defaultValue = "1") int seqPlace
    		) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "/jsp/fork/forkList";  //"redirect:/loginPage"
        }
        
		int blockCount = 4; 
		int blockPage = 10;
    	int size = routeService.svcSelectFavoriteRoutesCount(seqMember);
		PagingUtil pg = new PagingUtil("/forkList?", currentPage, size, blockCount, blockPage);

        List<RouteVO> forkList = routeService.svcSelectRouteAllByFork(seqMember, pg.getStartSeq(), pg.getEndSeq());
    	for(int i = 0; i < forkList.size(); i++) {
    		forkList.get(i)
    		.setPlist(placeService.svcSelectPlaceListBySeqRoute(forkList
    				.get(i).getSeq_route()));
    	}
        
        model.addAttribute("pageType", "forkList");        
        model.addAttribute("forkList", forkList);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");
		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());


        return "index";
    }
  
    

}