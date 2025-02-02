package com.tastehill.myweb.place;

import java.util.List;

public interface PlaceService {
    List<PlaceVO> searchPlaces(String query);
}
