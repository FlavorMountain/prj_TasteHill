package com.tastehill.myweb.common;

public class PagingUtil {

	private int startSeq;				// 현재 페이지 처음 글번호
	private int endSeq;					// 현재 페이지 끝 글번호
	private int maxPage;				// 최대 페이지 수
	private int startPage;  			// 페이지 시작번호
	private int endPage;				// 페이지 끝번호
	private StringBuffer pagingHtml; 	// 페이징 관련 HTML

	/**
	 * @param url 			: 페이징 적용 대상 주소  (서블릿주소) /myboard
	 * @param currentPage 	: 현재 페이지
	 * @param totRecord 	: 젠체 게시물수
	 * @param blockCount 	: 한 블럭의 게시물 수
	 * @param blockPage  	: 한화면에 보여질 블럭 수
	 **/
	public PagingUtil(String url, int currentPage, int totRecord, int blockCount, int blockPage) {
	    maxPage = (int) Math.ceil((double) totRecord / blockCount);
	    if (maxPage == 0) {
	        maxPage = 1;
	    }

	    if (currentPage > maxPage) {
	        currentPage = maxPage;
	    }

	    startSeq = (currentPage - 1) * blockCount + 1;
	    endSeq = currentPage * blockCount;

	    if (currentPage % blockPage == 0) {
	        startPage = currentPage - (blockPage - 1);
	    } else {
	        startPage = (int)(currentPage / blockPage) * blockPage + 1;
	    }
	    endPage = startPage + blockPage - 1;

	    if (endPage > maxPage) {
	        endPage = maxPage;
	    }

	    //################## HTML 만들기 ###################
	    pagingHtml = new StringBuffer();
	    pagingHtml.append("<div class='pagination'>");

	    // [이전] 버튼
	    if (currentPage > blockPage) {
	        pagingHtml.append("<a href='" + url + "&currentPage=" + (startPage - 1) + "' class='prev'>");
	        pagingHtml.append("이전");
	        pagingHtml.append("</a>");
	    }

	    // |1|2|3|4|5| (현재 페이지는 active 클래스 적용)
	    for (int i = startPage; i <= endPage; i++) {
	        if (i > maxPage) {
	            break;
	        }
	        if (i == currentPage) {
	            pagingHtml.append(" <a class='active'>");
	            pagingHtml.append(i);
	            pagingHtml.append("</a>");
	        } else {
	            pagingHtml.append(" <a href='" + url + "&currentPage=" + i + "'>");
	            pagingHtml.append(i);
	            pagingHtml.append("</a>");
	        }
	    }

	    // [다음] 버튼
	    if (maxPage - startPage >= blockPage) {
	        pagingHtml.append("<a href='" + url + "&currentPage=" + (endPage + 1) + "' class='next'>");
	        pagingHtml.append("다음");
	        pagingHtml.append("</a>");
	    }

	    pagingHtml.append("</div>"); // `.pagination` 닫기
	}

	
	
	public StringBuffer getPagingHtml() {
		return pagingHtml;
	}

	public int getStartSeq() {
		return this.startSeq;
	}

	public int getEndSeq() {
		return this.endSeq;
	}
}
