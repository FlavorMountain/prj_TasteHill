package com.tastehill.myweb.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

import java.util.List;

import javax.servlet.http.HttpSession;

@Controller

public class MainController {

	 @Autowired
	    private RouteService routeService;
	
		// MainPage
	    @RequestMapping(value="/main")
	     public String homePage(Model model, HttpSession session) {
	         System.out.println("homePage method called");
	    	 
		     // 세션에서 사용자 ID 확인
		     Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
		     System.out.println("Session SESS_MEMBER_ID: " + seqMember);
	
		     // 로그인 여부 확인 (세션에 사용자 ID가 있으면 로그인된 상태로 간주)
		     boolean isLoggedIn = (seqMember != null);
		     System.out.println("User Authenticated: " + isLoggedIn);
	
		     model.addAttribute("isLoggedIn", isLoggedIn);
	
		     if (isLoggedIn) {
		         System.out.println("Logged in as member: " + seqMember);
	
		         // 로그인된 사용자의 Pinned Route 가져오기
		         RouteVO pinnedRoute = routeService.svcSelectPinnedRoute(seqMember);
		         model.addAttribute("pinnedRoute", pinnedRoute);
		     } else {
		         System.out.println("Not logged in");
	
		         // 로그인되지 않은 경우 Pinned Route는 null로 설정
		         model.addAttribute("pinnedRoute", null);
		     }
	
		     // Hot 동선은 로그인 여부와 상관없이 항상 표시, 4개 보여줄거고 페이징 안들어간 상태
		     List<RouteVO> hotRoutes = routeService.svcSelectHotRoute(1, 4);
		     model.addAttribute("hotRoutes", hotRoutes);
	
		     // main.jsp 페이지로 이동
		     model.addAttribute("content", "/jsp/main/main.jsp");
			    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");

		     return "index";
		 }
}