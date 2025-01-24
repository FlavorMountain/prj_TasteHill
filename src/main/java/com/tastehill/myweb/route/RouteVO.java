package com.tastehill.myweb.route;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RouteVO {
    private int seqRoute;
    private String title;
    private String contents;
    private int seqMember;
    private Date createdAt;
    private Date updatedAt;
    private int forkCount;
    private int thumbUpCount;
}
