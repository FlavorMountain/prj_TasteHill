package com.tastehill.myweb.route;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

import com.tastehill.myweb.place.PlaceVO;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RouteVO {
    private int seq_route;
    private String title;
    private String contents;
    private int seqMember;
    private String createdAt;
    private String updatedAt;
    private int forkCount;
    
    //다대다 해결을 위한
    private List<RoutePlaceVO> places;
}
