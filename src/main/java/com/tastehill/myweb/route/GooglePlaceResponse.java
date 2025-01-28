package com.tastehill.myweb.route;
import java.util.ArrayList;
import java.util.List;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class GooglePlaceResponse {
    private String status;
    private ResultVO result;

    @JsonIgnoreProperties(ignoreUnknown = true)
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class OpeningHours {
        @JsonProperty("weekday_text")
        private List<String> weekdayText;
        
        @JsonProperty("open_now")
        private Boolean openNow;
        
        private List<Period> periods;
    }
    
    @JsonIgnoreProperties(ignoreUnknown = true)
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Period {
        private DayTime open;
        private DayTime close;
    }
    
    @JsonIgnoreProperties(ignoreUnknown = true)
    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class DayTime {
        private Integer day;
        private String time;
    }
}