package com.tastehill.myweb.route;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class RoutePlaceVO {
    private int seqRoute;
    private int seqPlace;
    private int order;
    private int price;
}

