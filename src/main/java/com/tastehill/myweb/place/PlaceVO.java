package com.tastehill.myweb.place;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PlaceVO {
    private int seqRestaurant;
    private String name;
    private String loc;
    private String openingHours;
    private Float rating;
    private String categoryCode;
}