package com.tastehill.myweb.route;

import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;
import java.util.List;

import javax.persistence.Transient;

import com.tastehill.myweb.place.PlaceVO;

import lombok.AllArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class RouteVO {
	//-----------------------------
	//네이게이션바 검색기능 
	//	상호명검색 : PlaveVO.name 
	//	주소 검색  : PlaveVO.formatted_address 
	//-----------------------------
	@Transient
	private String searchGubun; 
	
	@Transient  //DB에 없는 컬럼을 표시할때 사용
	private String searchStr;
	//-----------------------------
	
    private int seq_route;
    private String title;
    private String contents;
    private int seqMember;
    private String createdAt;
    private String updatedAt;
    private int forkCount;
    
    //다대다 해결을 위한
    private List<RoutePlaceVO> places;
    
    // 대표 사진 추가
    private String photo_url;
    

    private String nickname;
}
