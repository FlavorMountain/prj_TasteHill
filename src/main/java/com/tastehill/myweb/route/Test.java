package com.tastehill.myweb.route;


import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

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
class OpeningHoursVO {
	@JsonProperty("seq_place")
	private int seqPlace;
	private String place_id;
    
}


public class Test {

	public static void main(String[] args) {
		OpeningHoursVO tt  = new OpeningHoursVO(1, "aa");
		System.out.println(tt.getSeqPlace());
		
	

	}

}
