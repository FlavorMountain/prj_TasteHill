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
public class RouteListController {
	
	@Autowired
    private RouteService routeService;

	@Autowired
    private PlaceService placeService;
    
    // 검색창
    @GetMapping("/searchList")
    public String searchAll(
            @RequestParam(value = "searchGubun", required = false) String searchGubun,
            @RequestParam(value = "searchStr", required = false) String searchStr,
            Model model) {

        // Route와 Place 검색
    	RouteVO routeVO  = new RouteVO();
    	routeVO.setSearchGubun(searchGubun);
    	routeVO.setSearchStr(searchStr);
    	List<PlaceVO> searchRes = placeService.searchBar(routeVO);
       
        // 검색 결과를 모델에 추가
    	if (searchGubun.equals("formatted_address")) {
    		model.addAttribute("searchGubunKor", "주소");  
    	} else if (searchGubun.equals("formatted_address")) {
    		model.addAttribute("searchGubunKor", "이름");  
    	}
		 model.addAttribute("searchBarRes", searchRes);  
		 model.addAttribute("pageType", "searchStr");
        
	    // 검색 결과 페이지로 이동
      model.addAttribute("content", "/jsp/route/route_list.jsp");
      return "index";
    }

      
      
    
    // 장소 -> 동선 검색 한번에 되는 컨트롤러
    @GetMapping("/searchList2")
    public String searchAll2(
    		@RequestParam(value = "location", required = false) String location,
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            Model model) {

        // Route와 Place 검색
    	List<PlaceVO> searchPlaces = placeService.svcSearchPlacesByName(query);
    	if (searchPlaces != null && !searchPlaces.isEmpty()) {
    		int blockCount = 3; 
    		int blockPage = 10;
    		int seqPlace = searchPlaces.get(0).getSeq_place();
    		int size = routeService.svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
    		PagingUtil pg = new PagingUtil("/routeList/searchList", currentPage, size, blockCount, blockPage);
    		List<RouteVO> searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlacePaging(seqPlace, pg.getStartSeq(), pg.getEndSeq());

    		
            for(RouteVO x : searchRoutes) {
            	System.out.println(x.toString());
            }
    		
    		model.addAttribute("searchRoutes", searchRoutes);    	
    		model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());

    	}

      model.addAttribute("searchPlaces", searchPlaces);
	    model.addAttribute("content", "/jsp/route/route_list.jsp");
	    return "index";
    }
    
    // 핫 동선 리스트
    @GetMapping("/hotList")
    public String hotRoutesPage(Model model) {
        List<RouteVO> hotRoutes = routeService.svcSelectHotRoute();
        model.addAttribute("pageType", "hotList");
	    model.addAttribute("hotRoutes", hotRoutes);
	     
        // hotList.jsp 페이지로 이동
        model.addAttribute("content", "/jsp/route/route_list.jsp");
	    return "index";
    }
    
    // 마이페이지 동선 리스트
    @RequestMapping(value = "/myRoutes")
    public String getMyRoutes(Model model, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "redirect:/myroutes"; //"redirect:/loginPage"
        }

        List<RouteVO> myRoutes = routeService.svcSelectRouteAllMy(seqMember);
        
        model.addAttribute("pageType", "myRoutes");        
        model.addAttribute("myRoutes", myRoutes);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
        return "index";
    }
    
    // 즐겨찾기 리스트
    @RequestMapping(value = "/forkList")
    public String getFavorites(Model model, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "/jsp/fork/forkList";  //"redirect:/loginPage"
        }

        List<RouteVO> forkList = routeService.svcSelectRouteAllByFork(seqMember);
        
        model.addAttribute("pageType", "forkList");        
        model.addAttribute("forkList", forkList);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
        return "index";
    }
  
}