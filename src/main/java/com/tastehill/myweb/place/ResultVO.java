package com.tastehill.myweb.place;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class ResultVO {
	private String place_id;
    private String name;
    private Double rating;
    private String formatted_address;
    private OpeningHoursVO opening_hours; 
    private List<PhotoVO> photos;     
    private GeometryVO geometry;
}