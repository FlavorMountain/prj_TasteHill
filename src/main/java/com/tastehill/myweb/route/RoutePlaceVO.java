package com.tastehill.myweb.route;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import com.tastehill.myweb.place.PlaceVO;

import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoutePlaceVO {
    private int seq_route;
    private int seq_place;
    private int order;
    private int price;
    
    private PlaceVO place;
}

