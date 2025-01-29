package com.tastehill.myweb.place;

import java.io.IOException;
import java.net.HttpURLConnection;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

@Service
public class PlaceServiceImpl implements PlaceService{
	@Override
	public int test() {
		// TODO Auto-generated method stub
		return 0;
	}

}
