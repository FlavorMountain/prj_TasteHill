package com.tastehill.myweb.search;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.tastehill.myweb.member.MemberService;
import com.tastehill.myweb.member.MemberVO;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

@Controller
public class SearchController {

    @Autowired
    private RouteService routeService;

    @Autowired
    private PlaceService placeService;

    @GetMapping("/searchList")
    public String searchAll(
            @RequestParam(value = "query", required = false) String query,
            Model model) {

        // Route와 Place 검색
    	List<PlaceVO> searchPlaces = placeService.searchPlaces(query);
    	if(searchPlaces != null) {
    		int tmp = searchPlaces.get(0).getSeq_place();
    		List<RouteVO> searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlace(tmp);    		
            for(RouteVO x : searchRoutes) {
            	System.out.println(x.toString());
            	
            }
    		
    		model.addAttribute("searchRoutes", searchRoutes);    	
    	}

        // 검색 결과를 모델에 추가
        model.addAttribute("searchPlaces", searchPlaces);

        return "/jsp/main/searchList";
    }
}



