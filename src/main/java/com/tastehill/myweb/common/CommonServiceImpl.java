package com.tastehill.myweb.common;

import java.io.IOException;
import java.net.HttpURLConnection;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class CommonServiceImpl implements CommonService{

	 @Override
	    public String fetchFinalImageUrl(String apiUrl) {
	        // RestTemplate에서 리다이렉트를 막기 위한 설정
		    // 이렇게 하지 않으면 RestTemplate이 리다이렉트를 따라가서 
		    // 정상적으로 응답이 왓다는 200만 뜨고 종료됨
	        RestTemplate restTemplate = new RestTemplate();
	        SimpleClientHttpRequestFactory requestFactory = new SimpleClientHttpRequestFactory() {
	            @Override
	            protected void prepareConnection(HttpURLConnection connection, String httpMethod) throws IOException {
	                super.prepareConnection(connection, httpMethod);
	                connection.setInstanceFollowRedirects(false); // 리다이렉트 방지
	            }
	        };
	        restTemplate.setRequestFactory(requestFactory);

	        // Google Places Photo API 호출
	        ResponseEntity<Void> response = restTemplate.getForEntity(apiUrl, Void.class);

	        if (response.getStatusCode() == HttpStatus.FOUND) { // 302 상태 코드 확인
	            HttpHeaders headers = response.getHeaders();
	            return headers.getLocation().toString(); // 리다이렉트된 URL 반환
	        } else {
	            throw new RuntimeException("Failed to fetch redirect URL. Status: " + response.getStatusCode());
	        }
	    }
}
