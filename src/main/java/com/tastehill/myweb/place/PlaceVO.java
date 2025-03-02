package com.tastehill.myweb.place;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Data
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlaceVO {
	private int seq_place;
	private String place_id;	
    private String name;
    private String formatted_address;
    private Double rating;
    private int seq_route;

    private PhotoVO photos;
    private LocationVO location;
}
