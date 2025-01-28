package com.tastehill.myweb.place;
import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import java.util.List;

@Getter
@Setter
@ToString
@JsonIgnoreProperties(ignoreUnknown = true)
public class PlaceVO {
    private String status;
    private Result result;

    @Getter
    @Setter
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Result {
        private String name;
        private Double rating;
        private Geometry geometry;
        private List<String> types;
        
//        @JsonProperty("opening_hours")
        private OpeningHours opening_hours;
        private List<Photo> photos;
    }

    @Getter
    @Setter
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Geometry {
        private Location location;
    }

    @Getter
    @Setter
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Location {
        private Double lat;
        private Double lng;
    }

    @Getter
    @Setter
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class OpeningHours {
//        @JsonProperty("weekday_text")
        private List<String> weekday_text;
    }

    @Getter
    @Setter
    @ToString
    @JsonIgnoreProperties(ignoreUnknown = true)
    public static class Photo {
//        @JsonProperty("photo_reference")
        private String photo_reference;
        private String photo_url;
        
        // Google Places Photo API요청 URL을 생성하는 메서드
        public String makePhotoUrl(String apiKey, int maxWidth) {
            return String.format(
                "https://maps.googleapis.com/maps/api/place/photo?maxwidth=%d&photo_reference=%s&key=%s",
                maxWidth,
                photo_reference,
                apiKey
            );
        }
    }
}