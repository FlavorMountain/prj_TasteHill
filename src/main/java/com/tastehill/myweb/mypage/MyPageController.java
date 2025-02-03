package com.tastehill.myweb.mypage;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import com.tastehill.myweb.member.MemberService;
import com.tastehill.myweb.member.MemberVO;
import com.tastehill.myweb.route.RouteService;
import com.tastehill.myweb.route.RouteVO;

@Controller
public class MyPageController {

    @Autowired
    private MemberService memberService;

    @Autowired
    private RouteService routeService;

    // 프로필 정보 조회
    @RequestMapping(value = "/profile")
    public String getProfile(Model model, @SessionAttribute(value = "seqMember", required = false) Integer seqMember) {
        if (seqMember == null) {
            return "/jsp/mypage/mypage"; 	//"/jsp/member/member_login; // 로그인 페이지로 이동
        }
        MemberVO member = memberService.svcSelectMember(seqMember);
        model.addAttribute("member", member);
        return "/jsp/mypage/mypage";
    }
    
    // 프로필 정보 업데이트
    @RequestMapping("/profile/update")
    public String updateProfile(@SessionAttribute("seqMember") int seqMember,
                                @RequestParam String nickname,
                                @RequestParam String profile) {
        memberService.svcUpdateMemberProfile(seqMember, profile);
        return "redirect:/mypage/profile";
    }
    
 // 닉네임 변경
    @RequestMapping(value = "/profile/update/nickname")
    public String updateNickname(@SessionAttribute("seqMember") int seqMember,
                                 @RequestParam("nickname") String nickname) {
        memberService.svcUpdateMemberNickname(seqMember, nickname);
        return "redirect:/mypage/profile";
    }

    // 비밀번호 변경
    @RequestMapping(value = "/profile/update/password")
    public String updatePassword(@SessionAttribute("seqMember") int seqMember,
                                 @RequestParam("password") String password) {
        memberService.svcUpdateMemberPw(seqMember, password);
        return "redirect:/mypage/profile";
    }

    // 회원 탈퇴
    @RequestMapping(value = "/profile/delete")
    public String deleteMember(@SessionAttribute("seqMember") int seqMember, HttpSession session) {
        memberService.svcDeleteMember(seqMember);
        session.invalidate(); // 세션 종료
        return "redirect:/";
    }
    



    // 내가 작성한 동선 리스트 
    @RequestMapping(value = "/myroutes")
    public String getMyRoutes(Model model, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "/jsp/mypage/myroutes"; //"redirect:/loginPage"
        }

        List<RouteVO> myRoutes = routeService.svcSelectRouteAllMy(seqMember);
        model.addAttribute("myRoutes", myRoutes);
        return "/jsp/mypage/myroutes";
    }

    // 특정 동선 삭제 
    @RequestMapping(value = "/myroutes/delete")
    public String deleteRoute(@RequestParam int seqRoute) {
        routeService.svcDelectRoute(seqRoute);
        return "redirect:/mypage/myroutes";
    }

    // 좋아요한 동선 리스트
    @RequestMapping(value = "/forkList")
    public String getFavorites(Model model, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "/jsp/fork/forkList";  //"redirect:/loginPage"
        }

        List<RouteVO> forkRoutes = routeService.svcSelectRouteAllByFork(seqMember);
        model.addAttribute("forkRoutes", forkRoutes);
        return "/jsp/fork/forkList";
    }
}



