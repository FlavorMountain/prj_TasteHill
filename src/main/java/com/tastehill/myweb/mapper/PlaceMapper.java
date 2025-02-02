package com.tastehill.myweb.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.tastehill.myweb.place.PlaceDetailVO;


@Mapper
public interface PlaceMapper {
    int insertPlace(PlaceDetailVO placeVO);
    int insertPhoto(Map<String, Object> photoMap);
    int insertOpeningHours(Map<String, Object> omap);
    int insertWeekdayText(Map<String, Object> wmap);
    int insertGeometry(Map<String, Object> gmap);
    int insertLocation(Map<String, Object> lmap);
    
    //placeVO + 연계된VO들 전부 싹긁어오는쿼리
    PlaceDetailVO selectPlaceDetailByPlaceID(@Param("placeId") String placeId);
    int selectPlaceSeqByPlaceId(@Param("seqPlace") int seqPlace);
    int selectPhotosByPlaceId(@Param("seqPlace") int seqPlace);
    int selectOpeningHoursByPlaceId(@Param("seqPlace") int seqPlace);
    int selectWeekdayTextByPlaceId(@Param("seqPlace") int seqPlace);
    int selectGeometryByPlaceId(@Param("seqPlace") int seqPlace);
    int selectLocationByPlaceId(@Param("seqPlace") int seqPlace);

}

