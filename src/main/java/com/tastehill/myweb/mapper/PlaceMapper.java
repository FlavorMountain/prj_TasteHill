package com.tastehill.myweb.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.place.GeometryVO;
import com.tastehill.myweb.place.LocationVO;
import com.tastehill.myweb.place.OpeningHoursVO;
import com.tastehill.myweb.place.PhotoVO;
import com.tastehill.myweb.place.PlaceDetailVO;
import com.tastehill.myweb.place.PlaceVO;
import com.tastehill.myweb.place.WeekdayTextVO;


@Mapper
public interface PlaceMapper {
    int insertPlace(PlaceDetailVO placeVO);
    int insertPhoto(Map<String, Object> photoMap);
    int insertOpeningHours(Map<String, Object> omap);
    int insertWeekdayText(Map<String, Object> wmap);
    int insertGeometry(Map<String, Object> gmap);
    int insertLocation(Map<String, Object> lmap);
    List<PlaceVO> searchPlacesByName(@Param("query") String query);
    List<PlaceVO> searchPlacesByAddress(@Param("query") String query);
    // 장소VO 조회
    PlaceVO selectPlaceByPlaceId(@Param("placeId") String placeId);
    // 장소상세 조회
    PlaceDetailVO selectDetailOne(@Param("placeId") String placeId);
}