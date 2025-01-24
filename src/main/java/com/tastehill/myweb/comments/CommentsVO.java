package com.tastehill.myweb.comments;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CommentsVO {
    private int seqComments;
    private String contents;
    private Date createdAt;
    private Date updatedAt;
    private int seqRoute;
    private String nickname;
    private int seqMember;
}
