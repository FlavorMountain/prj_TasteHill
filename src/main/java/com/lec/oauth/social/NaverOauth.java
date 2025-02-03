package com.lec.oauth.social;

import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.client.HttpClientErrorException;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.lec.oauth.vo.GoogleRequestVO;
import com.lec.oauth.vo.GoogleResponseVO;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@PropertySource("classpath:lec-oauth.properties")
@Component
@RequiredArgsConstructor
public class NaverOauth implements Oauth {
	@Value("${naver.loginform.url}")
	private String LOGIN_FORM_URL;
	@Value("${naver.client.id}")
	private String CLIENT_ID;
	@Value("${naver.client.pw}")
	private String CLIENT_PW;
	@Value("${naver.redirect.uri}")
	private String CALLBACK_URL;
	@Value("${naver.endpoint.token}")
	private String ENDPOINT_URL_TOKEN;
	@Value("${naver.endpoint.userinfo}")
	private String ENDPOINT_URL_USERINFO;
	private String ACCESS_TOKEN  = "";
    
	@Override
	public String getLoginFormURL() {
		Map<String, Object> params = new HashMap<>();
		params.put("response_type"	, "code");
		params.put("client_id"		, CLIENT_ID);
		params.put("redirect_uri"	, CALLBACK_URL);
		params.put("state", "tq");

		//String parameterString = commonBuildQueryString(params);
		String parameterString = params.entrySet().stream()
				.map(x -> x.getKey() + "=" + x.getValue())
				.collect(Collectors.joining("&"));  

		//https://accounts.google.com/o/oauth2/v2/auth?client_id=__&redirect_uri=__&response_type=code&scope=email profile openid&access_type=offline
		return LOGIN_FORM_URL + "?" + parameterString;
	}

	/** 
	 * AccessToken 받기
	 */
	@Override
	public Map<String, String> requestAccessToken(String code) {

		HttpHeaders headers = new HttpHeaders();
        headers.set("Content-type", "application/x-www-form-urlencoded;charset=utf-8");
        //필수 바디 정보
        MultiValueMap<String, String> bodys = new LinkedMultiValueMap<>();
        bodys.add("code"			, code);
        bodys.add("client_id"		, CLIENT_ID);
        bodys.add("client_secret"	, CLIENT_PW);
        bodys.add("grant_type"		, "authorization_code");
        bodys.add("redirect_uri"	, CALLBACK_URL);
        bodys.add("state"			, "tq");
    	// HttpEntity (헤더+바디) 생성
        HttpEntity<MultiValueMap<String, String>> entity = new HttpEntity<>(bodys, headers);
        
		RestTemplate restTemplate = new RestTemplate();
		ResponseEntity<Map> tokenResponse = restTemplate.exchange(ENDPOINT_URL_TOKEN, HttpMethod.POST, entity, Map.class);
		Map<String, Object> bodyMap = tokenResponse.getBody();
		String accessToken = (String) bodyMap.get("access_token");
		System.out.println("2.토큰 응답(body): "  + bodyMap.toString());
		System.out.println("2.토큰 응답(token): " + accessToken);

		//--------------------------------------------------			
		//방법1) RestTemplate Map 바인딩 + 키로 토큰만 꺼내기
		//--------------------------------------------------
        
		this.ACCESS_TOKEN = (String) bodyMap.get("access_token");
		System.out.println("NAVEROauth.requestAccessToken() accessToken:"+ this.ACCESS_TOKEN);
				
		return tokenResponse.getBody();
	}

	/** 
	 * AccessToken을 사용해 유저정보 받기
	 */
	public Map<String, String> getUserInfo(String accessToken) {
		
		 //필수 헤더 정보
		HttpHeaders headers = new HttpHeaders();
		headers.set("Authorization", "Bearer " + this.ACCESS_TOKEN);
		
        HttpEntity<Map<String, Object>> entity = new HttpEntity<>(headers);
		RestTemplate restTemplate = new RestTemplate();

		ResponseEntity<Map<String, Object>> responseEntity = restTemplate.exchange(
	            ENDPOINT_URL_USERINFO,
	            HttpMethod.GET,
	            entity,
	            new ParameterizedTypeReference<Map<String, Object>>() {}
	    );

	    Map<String, Object> responseBody = responseEntity.getBody();
	    Map<String, String> userInfo = new HashMap<>();

	    if (responseBody != null) {
	        // ID 값 (숫자를 문자열로 변환)
	        userInfo.put("id", String.valueOf(responseBody.get("id")));

	        // 프로필 정보가 포함된 경우
	        Map<String, Object> response = (Map<String, Object>) responseBody.get("response");
	        
	        if (response != null) {
	            userInfo.put("nickname", (String) response.getOrDefault("nickname", ""));
	            userInfo.put("profile", (String) response.getOrDefault("profile_image", ""));
	            userInfo.put("email", (String) response.getOrDefault("email", ""));
	        }
	    }

	    return userInfo;
	}

	/** 
	 * refreshToken을 사용해 AccessToken 재발급 받기
	 */
	public String getAccessTokenByRefreshToken(String refreshToken) {
		Map<String, String> bodys = new HashMap<>();
		bodys.put("client_id"     , CLIENT_ID);
		bodys.put("refresh_token" , refreshToken);
		bodys.put("grant_type"    , "refresh_token");
        
        // HttpEntity (바디) 생성
		RestTemplate restTemplate = new RestTemplate();
		HttpEntity<Map<String, String>> entity = new HttpEntity<>(bodys);
        ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
        		ENDPOINT_URL_TOKEN,
			    HttpMethod.POST,
			    entity,
			    new ParameterizedTypeReference<Map<String, String>>() {}
			);
        System.out.println("4.토큰재발급 응답(body):" + responseEntity.getBody().toString());
        String accessToken= responseEntity.getBody().get("access_token");
        System.out.println("4.토큰요청 응답(갱신된access_token): " + accessToken);
        return accessToken;
	}

	/** 
	 * AccessToken 만료 여부 체크
	 */
	public boolean isTokenExpired(String accessToken) {

		try {
			HttpHeaders headers = new HttpHeaders();
			headers.set("Authorization", "Bearer " + accessToken);
			HttpEntity<String> entity = new HttpEntity<>(headers);
			
			RestTemplate restTemplate = new RestTemplate();
			ResponseEntity<Map<String, String>> responseEntity = restTemplate.exchange(
					ENDPOINT_URL_USERINFO,
				    HttpMethod.POST,
				    entity,
				    new ParameterizedTypeReference<Map<String, String>>() {}
				);
			System.out.println("5.유저정보 응답:" + responseEntity.getBody().toString());
			return false; // 요청 성공 -> 토큰 유효
		} catch (HttpClientErrorException e) {
			if (e.getStatusCode().value() == 401) {
				return true; // 401 Unauthorized -> 토큰 만료
			}
			throw e; // 다른 오류는 예외로 처리
		}
	}




}