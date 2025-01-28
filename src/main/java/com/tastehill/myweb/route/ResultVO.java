package com.tastehill.myweb.route;

import java.util.ArrayList;
import java.util.List;

import org.codehaus.jackson.annotate.JsonIgnoreProperties;
import org.codehaus.jackson.annotate.JsonProperty;

import com.tastehill.myweb.route.GooglePlaceResponse.OpeningHours;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@JsonIgnoreProperties(ignoreUnknown = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ResultVO {
    private String name;
    private Double rating;
    private List<PhotoVO> photos;
    
    @JsonProperty("opening_hours")
    private OpeningHours openingHours;
    private List<String> types;
    
    public List<String> getPhotoUrls(String apiKey) {
        List<String> photoUrls = new ArrayList<>();
        if (photos != null) {
            for (PhotoVO photo : photos) {
                if (photo != null && photo.getPhotoReference() != null) {
                    String url = String.format(
                        "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=%s&key=%s",
                        photo.getPhotoReference(),
                        apiKey
                    );
                    photoUrls.add(url);
                }
            }
        }
        return photoUrls.isEmpty() ? null : photoUrls;
    }
  }