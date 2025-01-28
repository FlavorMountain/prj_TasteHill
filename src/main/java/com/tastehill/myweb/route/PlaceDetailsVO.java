package com.tastehill.myweb.route;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class PlaceDetailsVO {
    private String name;
    private Double rating;
    private List<String> photos;
    private List<String> openingHours;
    private List<String> types;
}
