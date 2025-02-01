package com.tastehill.myweb.main;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

import java.util.List;

@Controller
@RequestMapping("/main")
public class MainController {

	@Autowired
    private RouteService routeService;

        // Hot 동선 리스트 가져오기
        @GetMapping("/hotList")
        public String hotRoutesPage(Model model) {
            List<RouteVO> hotRoutes = routeService.svcSelectHotRoute();

            // 모델에 데이터 추가
            model.addAttribute("hotRoutes", hotRoutes);

            // hotList.jsp 페이지로 이동
            return "/main/hotList";
        }
        
        @GetMapping
        public String homePage(Model model, @RequestParam("seqMember") int seqMember, Authentication authentication) {
            // 로그인 상태 확인
            boolean isLoggedIn = authentication != null && authentication.isAuthenticated();
            model.addAttribute("isLoggedIn", isLoggedIn);

            // Pinned Route 가져오기
            RouteVO pinnedRoute = routeService.svcSelectPinnedRoute(seqMember);
            model.addAttribute("pinnedRoute", pinnedRoute);

            return "main";
        }
}