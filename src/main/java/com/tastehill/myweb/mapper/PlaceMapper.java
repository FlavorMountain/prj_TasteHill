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
import com.tastehill.myweb.route.RouteVO;


@Mapper
public interface PlaceMapper {
    int insertPlace(PlaceDetailVO placeVO);
    int insertPhoto(Map<String, Object> photoMap);
    int insertOpeningHours(Map<String, Object> omap);
    int insertWeekdayText(Map<String, Object> wmap);
    int insertGeometry(Map<String, Object> gmap);
    int insertLocation(Map<String, Object> lmap);
    
    String selectPhotoUrlBySeqPlace(@Param("seqPlace") int seqPlace);
    //네이게이션바 검색
    List<PlaceVO> searchBar(
    		@Param("searchGubun") String searchGubun,
    		@Param("searchStr") String searchStr,
    		@Param("start") int start,
    		@Param("end") int end);
    
    int searchBarCount(
    		@Param("searchGubun") String searchGubun,
    		@Param("searchStr") String searchStr
    		);
    
    // 장소VO 조회
    PlaceVO selectPlaceByPlaceId(@Param("placeId") String placeId);
    // 장소상세 조회
    PlaceDetailVO selectDetailOne(@Param("placeId") String placeId);
    // 장소 이름으로 조회
    List<PlaceVO> searchPlacesByName(@Param("query") String query);
    // 장소 주소로 조회
    List<PlaceVO> searchPlacesByAddress(@Param("query") String query);
}