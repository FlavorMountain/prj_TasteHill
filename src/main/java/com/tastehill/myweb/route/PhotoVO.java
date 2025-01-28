package com.tastehill.myweb.route;

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
public class PhotoVO {
    @JsonProperty("photo_reference")
    private String photoReference;
    private Integer width;
    private Integer height;
    private List<String> htmlAttributions;
}