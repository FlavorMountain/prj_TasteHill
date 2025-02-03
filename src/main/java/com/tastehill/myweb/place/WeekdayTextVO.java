package com.tastehill.myweb.place;

import org.codehaus.jackson.annotate.JsonCreator;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonValue;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@AllArgsConstructor
@NoArgsConstructor
@Data
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class WeekdayTextVO {
	private int seq_place;
	private String place_id;
    private String weekday_text;
    
    //json에 들어온 문자열을 다시 String 객체로 저장하려면 아래 어노테이션을 이용해야함
    
    @JsonCreator 
    public WeekdayTextVO(String weekday_text) {
        this.weekday_text = weekday_text;
    }

    @JsonValue 
    public String getWeekday_text() {
        return weekday_text;
    }
}
