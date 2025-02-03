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
public class PhotoVO {
	private int seq_place;
	private String place_id;
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