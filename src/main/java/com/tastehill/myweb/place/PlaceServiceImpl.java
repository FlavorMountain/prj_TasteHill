package com.tastehill.myweb.place;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.SimpleClientHttpRequestFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.tastehill.myweb.mapper.PlaceMapper;

@Service
public class PlaceServiceImpl implements PlaceService {

    @Autowired
    private PlaceMapper placeMapper;

    @Override
    public List<PlaceVO> searchPlaces(String query) {
        return placeMapper.searchPlaces(query);
    }

}
