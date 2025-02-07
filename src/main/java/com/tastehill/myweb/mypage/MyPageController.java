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
import org.springframework.web.bind.annotation.ResponseBody;
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
    public String getProfile(Model model, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null) {
            return "redirect:/loginPage"; // 로그인 페이지로 이동
        }
        MemberVO member = memberService.svcSelectMember(seqMember);
        List<RouteVO> myRoutes = routeService.svcSelectRoutesAndPlaceByMember(seqMember);
        List<RouteVO> forkRoutes = routeService.svcSelectFavoriteRoutes(
        		seqMember, 1, routeService.svcSelectFavoriteRoutesCount(seqMember));
        model.addAttribute("member", member);
        model.addAttribute("myRoutes", myRoutes); // 추가
        model.addAttribute("forkRoutes", forkRoutes); // 추가
	    model.addAttribute("searchBar" , "/jsp/common/searchBar.jsp");

        model.addAttribute("content", "/jsp/mypage/mypage.jsp");
        return "index";
    }

    // 프로필 정보 업데이트
    @RequestMapping("/profile/update")
    public String updateProfile(HttpSession session,
                                @RequestParam String nickname,
                                @RequestParam String profile) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember != null) {
            memberService.svcUpdateMemberProfile(seqMember, profile);
        }
        return "/profile";
    }

    
    // 프로필 이미지 업로드 
    @RequestMapping(value = "/profile/upload", method = RequestMethod.POST)
    @ResponseBody // JSON 응답을 위해 추가
    public String uploadProfileImage(@RequestParam("profileImage") MultipartFile file, HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember == null || file.isEmpty()) {
            return "ERROR: 파일 업로드 실패"; // 실패 메시지 반환
        }

        try {
            // 업로드 디렉토리 설정 (Tomcat 실행 경로 기반)
            String uploadDir = session.getServletContext().getRealPath("/uploads/profile/");
            File dir = new File(uploadDir);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            // 파일 저장
            String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
            String filePath = uploadDir + File.separator + fileName;
            File dest = new File(filePath);
            file.transferTo(dest);

            // DB 저장 (상대 경로 사용)
            String dbFilePath = "/uploads/profile/" + fileName;
            memberService.svcUpdateMemberProfile(seqMember, dbFilePath);
            session.setAttribute("SESS_PROFILE", dbFilePath);

            System.out.println("파일 업로드 성공: " + dbFilePath);

            // 업로드된 파일의 URL을 클라이언트에 반환
            return dbFilePath;

        } catch (Exception e) {
            e.printStackTrace();
            return "ERROR: 파일 저장 중 오류 발생";
        }
    }
    
    // 닉네임 변경
    @RequestMapping(value = "/profile/update/nickname")
    public String updateNickname(HttpSession session,
                                 @RequestParam("nickname") String nickname) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember != null) {
            memberService.svcUpdateMemberNickname(seqMember, nickname);
        }
        return "redirect:/profile";
    }

    // 비밀번호 변경
    @RequestMapping(value = "/profile/update/password")
    public String updatePassword(HttpSession session,
                                 @RequestParam("password") String password) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember != null) {
            memberService.svcUpdateMemberPw(seqMember, password);
        }
        return "redirect:/profile";
    }

    // 회원 탈퇴
    @RequestMapping(value = "/profile/delete")
    public String deleteMember(HttpSession session) {
        Integer seqMember = (Integer) session.getAttribute("SESS_MEMBER_ID");
        if (seqMember != null) {
            memberService.svcDeleteMember(seqMember);
            session.invalidate(); // 세션 종료
        }
        return "redirect:/main";
    }


    // 특정 동선 삭제
    @RequestMapping(value = "/profile/myroutes/delete", method = RequestMethod.POST)
    public String deleteRoute(@RequestParam("seqRoute") int seqRoute) {
        System.out.println("🔴 삭제 요청 수신: seqRoute = " + seqRoute); // 요청 확인
        routeService.svcDeleteRoute(seqRoute);
        System.out.println("✅ 삭제 완료: seqRoute = " + seqRoute); // 삭제 완료 확인
        return "redirect:/myRoutes";
    }
}



