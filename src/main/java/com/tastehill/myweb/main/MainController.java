package com.tastehill.myweb.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

import java.util.List;

@Controller

public class MainController {

	 @Autowired
	    private RouteService routeService;

	    // Hot 동선 리스트 가져오기
	 	@RequestMapping(value="/main/hotList")
	    public String hotRoutesPage(Model model) {
	        List<RouteVO> hotRoutes = routeService.svcSelectHotRoute();

	        // 모델에 데이터 추가
	        model.addAttribute("hotRoutes", hotRoutes);

	        // hotList.jsp 페이지로 이동
	        return "/jsp/main/hotList";
	    }

	    @RequestMapping(value="/main")
	    public String homePage(Model model, 
	                           @RequestParam(value = "seqMember", required = false, defaultValue = "0") int seqMember, 
	                           Authentication authentication) {
	    	 System.out.println("homePage method called with seqMember: " + seqMember);
	    	 
//	        // 로그인 상태 확인
//	        boolean isLoggedIn = authentication != null && authentication.isAuthenticated();
//	        model.addAttribute("isLoggedIn", isLoggedIn);
	        
	        // 강제로 로그인 상태로 설정
	        boolean isLoggedIn = true; // 로그인 상태로 테스트
	        model.addAttribute("isLoggedIn", isLoggedIn);

	        // Hot 동선은 로그인 여부와 상관없이 항상 표시
	        List<RouteVO> hotRoutes = routeService.svcSelectHotRoute();
	        model.addAttribute("hotRoutes", hotRoutes);

	        // My Pinned Route는 로그인 상태일 때만 표시
	        RouteVO pinnedRoute = null;
	        if (isLoggedIn && seqMember != 0) {
	            pinnedRoute = routeService.svcSelectPinnedRoute(seqMember);
	        }
	        model.addAttribute("pinnedRoute", pinnedRoute);

	        // main.jsp 페이지로 이동
	        return "/jsp/main/main";
	    }
}