package com.tastehill.myweb.place;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
public class PlaceVO {
	private int seqPlace;
	private String name;
    private String place_id;
    private Double rating;
    private String formatted_address;
}
