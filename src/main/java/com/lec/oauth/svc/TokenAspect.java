package com.lec.oauth.svc;

import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.client.HttpClientErrorException;

import com.lec.oauth.social.GoogleOauth;
import com.lec.oauth.vo.UsersOauthVO;

import javax.servlet.http.HttpSession;

@Aspect
@Component
public class TokenAspect {

    private final GoogleOauth tokenService;
    private final OauthServiceImpl userService;
    private final HttpSession session;
    
    @Autowired
    public TokenAspect(GoogleOauth tokenService, OauthServiceImpl userService, HttpSession session) {
        this.tokenService = tokenService;
        this.userService  = userService;
        this.session      = session;
    }

    @Pointcut("execution(* com.lec.oauth.svc.OauthServiceImpl.*(..))")
    public void serviceMethods() {}

    @AfterThrowing(pointcut = "serviceMethods()", throwing = "ex")
    public void handleTokenExpiredException(HttpClientErrorException ex) throws Throwable {
        if (ex.getStatusCode() == HttpStatus.UNAUTHORIZED) {
            UsersOauthVO userOauthVO = (UsersOauthVO) session.getAttribute("user");
            if (userOauthVO != null) {
                String newAccessToken = tokenService.getAccessTokenByRefreshToken(userOauthVO.getRefreshToken());
                userOauthVO.setAccessToken(newAccessToken);
//                userService.svcUpdateToken(userOauthVO); // DB에 새로운 토큰 저장
                session.setAttribute("SESS_USERVO", userOauthVO);
            }
        } else {
            throw ex;
        }
    }
}