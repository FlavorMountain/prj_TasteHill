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
    
    //placeVO + 연계된VO들 전부 싹긁어오는쿼리
//    PlaceDetailVO selectPlaceDetailByPlaceId(@Param("placeId") String placeId);
    
    PlaceVO selectPlaceByPlaceId(@Param("placeId") String placeId);
    
    int selectPlaceSeqByPlaceId(@Param("seqPlace") int seqPlace);
    
    
    List<PhotoVO> selectAllPhotosByPlaceId(@Param("seqPlace") int seqPlace);
    OpeningHoursVO selectOpeningHoursByPlaceId(@Param("seqPlace") int seqPlace);
    List<WeekdayTextVO> selectAllWeekdayTextByPlaceId(@Param("seqPlace") int seqPlace);
    GeometryVO selectGeometryByPlaceId(@Param("seqPlace") int seqPlace);
    LocationVO selectLocationByPlaceId(@Param("seqPlace") int seqPlace);

}

