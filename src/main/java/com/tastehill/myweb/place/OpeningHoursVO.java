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
public class OpeningHoursVO {
	private int seqPlace;
	private String place_id;
    private List<WeekdayTextVO> weekday_text;
}