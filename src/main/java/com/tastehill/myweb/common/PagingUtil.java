package com.tastehill.myweb.common;

public class PagingUtil {
    private int startSeq;                
    private int endSeq;                    
    private int maxPage;                
    private int startPage;              
    private int endPage;                
    private StringBuffer pagingHtml;     

    public PagingUtil(String url, int currentPage, int totRecord, int blockCount, int blockPage) {
        // 기존 페이징 계산 로직은 동일하게 유지
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
            startPage = (int) (currentPage / blockPage) * blockPage + 1;
        }
        endPage = startPage + blockPage - 1;
        
        if (endPage > maxPage) {
            endPage = maxPage;
        }

        // HTML과 CSS를 함께 생성
        pagingHtml = new StringBuffer();
        
        // CSS 스타일 추가
        pagingHtml.append("<style>");
        pagingHtml.append(".pagination-container {");
        pagingHtml.append("    display: flex;");
        pagingHtml.append("    justify-content: center;");
        pagingHtml.append("    margin: 20px 0;");
        pagingHtml.append("}");
        
        pagingHtml.append(".pagination {");
        pagingHtml.append("    display: flex;");
        pagingHtml.append("    list-style: none;");
        pagingHtml.append("    padding: 0;");
        pagingHtml.append("    margin: 0;");
        pagingHtml.append("}");
        
        pagingHtml.append(".page-item {");
        pagingHtml.append("    margin: 0 2px;");
        pagingHtml.append("}");
        
        pagingHtml.append(".page-link {");
        pagingHtml.append("    display: block;");
        pagingHtml.append("    padding: 8px 12px;");
        pagingHtml.append("    color: #007bff;");
        pagingHtml.append("    text-decoration: none;");
        pagingHtml.append("    background-color: #fff;");
        pagingHtml.append("    border: 1px solid #dee2e6;");
        pagingHtml.append("    border-radius: 4px;");
        pagingHtml.append("    transition: all 0.2s ease-in-out;");
        pagingHtml.append("}");
        
        pagingHtml.append(".page-link:hover {");
        pagingHtml.append("    color: #0056b3;");
        pagingHtml.append("    background-color: #e9ecef;");
        pagingHtml.append("    border-color: #dee2e6;");
        pagingHtml.append("}");
        
//        pagingHtml.append(".page-item.active .page-link {");
//        pagingHtml.append("    color: #fff;");
//        pagingHtml.append("    background-color: #007bff;");
//        pagingHtml.append("    border-color: #007bff;");
//        pagingHtml.append("    padding: 8px 12px;"); // 기본 page-link와 동일한 패딩 적용
//        pagingHtml.append("}");
        pagingHtml.append("</style>");

        // 페이징 HTML 생성
        pagingHtml.append("<div class='pagination-container'>");
        pagingHtml.append("<ul class='pagination'>");

        // 이전 버튼
        if (currentPage > blockPage) {
            pagingHtml.append("<li class='page-item'>");
            pagingHtml.append("<a class='page-link' href='" + "http://localhost:8089" + url + "&currentPage=" + (startPage - 1) + "'>");
            pagingHtml.append("이전");
            pagingHtml.append("</a></li>");
        }

        // 페이지 번호
        for (int i = startPage; i <= endPage; i++) {
            if (i > maxPage) {
                break;
            }
            if (i == currentPage) {
                pagingHtml.append("<li class='page-item active'>");
                pagingHtml.append("<span class='page-link'>" + i + "</span>");
                pagingHtml.append("</li>");
            } else {
                pagingHtml.append("<li class='page-item'>");
                pagingHtml.append("<a class='page-link' href='" + url + "&currentPage=" + i + "'>");
                pagingHtml.append(i);
                pagingHtml.append("</a></li>");
            }
        }

        // 다음 버튼
        if (maxPage - startPage >= blockPage) {
            pagingHtml.append("<li class='page-item'>");
            pagingHtml.append("<a class='page-link' href='" + url + "&currentPage=" + (endPage + 1) + "'>");
            pagingHtml.append("다음");
            pagingHtml.append("</a></li>");
        }

        pagingHtml.append("</ul>");
        pagingHtml.append("</div>");
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