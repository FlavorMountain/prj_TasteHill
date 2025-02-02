package com.tastehill.myweb.place;

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
public class LocationVO {
	private int seqPlace;
  	private String place_id;
    private Double lat;
    private Double lng;
}
