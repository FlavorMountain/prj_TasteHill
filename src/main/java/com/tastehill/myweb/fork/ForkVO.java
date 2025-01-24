package com.tastehill.myweb.fork;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ForkVO {
    private int seqFork;
    private int seqMember;
    private int seqRoute;
}
