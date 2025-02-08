<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="col-lg-6">
    <div class="position-relative mx-auto">
        <form id="searchForm" method="get">
            <div class="d-flex">
                <select id="searchType" name="searchGubun" 
                        class="form-select border-1 rounded-pill me-2 py-3 px-4" 
                        style="width: auto;" 
                        onchange="updateAction()">
                    <option value="formatted_address" data-action="/searchPlaceList">장소-주소</option>
                    <option value="name" data-action="/searchPlaceList">장소-장소명</option>
                    <option value="formatted_address" data-action="/searchRouteList">동선-주소</option>
                    <option value="name" data-action="/searchRouteList">동선-장소명</option>
                </select>
                <div class="position-relative w-100">
                    <input type="text" 
                           name="searchStr" 
                           class="form-control border-1 w-100 py-3 px-4 rounded-pill" 
                           placeholder="search place...">
                    <button type="submit" 
                            class="btn btn-primary border-0 border-secondary py-3 px-4 position-absolute rounded-pill text-white"
                            style="top: 0; right: 0; margin-top: 2px;">
                        🔍 Search
                    </button>
                </div>
            </div>
        </form>
    </div>
</div>

<script>
    function updateAction() {
        var selectBox = document.getElementById("searchType");
        var selectedOption = selectBox.options[selectBox.selectedIndex];
        document.getElementById("searchForm").action = selectedOption.getAttribute("data-action");
    }

    // 폼이 제출되기 전에 URL을 업데이트하도록 설정
    document.getElementById("searchForm").addEventListener("submit", function() {
        updateAction();
    });
</script>