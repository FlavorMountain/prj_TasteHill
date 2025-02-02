package com.tastehill.myweb.place;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
import java.util.List;


@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlaceDetailVO {
	private int seqPlace;
    private String status;
    private Result result;
    
    @Data
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Result {
    	private String place_id;
        private String name;
        private Double rating;
        private String formatted_address;
        private OpeningHoursVO opening_hours; 
        private List<PhotoVO> photos;     
        private GeometryVO geometry;
    }
}
