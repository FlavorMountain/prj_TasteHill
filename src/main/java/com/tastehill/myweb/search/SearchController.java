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

import com.tastehill.myweb.common.PagingUtil;
import com.tastehill.myweb.member.MemberService;
import com.tastehill.myweb.member.MemberVO;
import com.tastehill.myweb.place.PlaceService;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

import lombok.Getter;

@Controller
@RequestMapping("/search")
public class SearchController {

    @Autowired
    private RouteService routeService;

    @Autowired
    private PlaceService placeService;

    @GetMapping("/searchList")
    public String searchAll(
            @RequestParam(value = "query", required = false) String query,
            @RequestParam(value = "currentPage", required = false, defaultValue = "1") int currentPage,
            Model model) {

        List<PlaceVO> searchPlaces = placeService.searchPlacesByName(query);
        if (searchPlaces != null && !searchPlaces.isEmpty()) {

            int blockCount = 3;
            int blockPage = 10;

            int seqPlace = searchPlaces.get(0).getSeq_place();

            int size = routeService.svcSelectCountAllRoutesAndPlaceBySearchPlacePaging(seqPlace);
            PagingUtil pg = new PagingUtil("/routeList/searchList?query=" + query, currentPage, size, blockCount, blockPage);
            
            List<RouteVO> searchRoutes = routeService.svcSelectAllRoutesAndPlaceBySearchPlacePaging(seqPlace, pg.getStartSeq(), pg.getEndSeq());

            model.addAttribute("searchRoutes", searchRoutes);
            model.addAttribute("MY_KEY_PAGING_HTML", pg.getPagingHtml().toString());
        }

        model.addAttribute("searchPlaces", searchPlaces);
        model.addAttribute("content", "/jsp/route/route_list.jsp");
        return "index";
    }

}



