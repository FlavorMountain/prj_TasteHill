<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<div>
    <div class="search-container">
        <div class="search-bar">
            <form id="searchForm" action="/searchList" method="get">
                <select id="searchType" name="searchGubun">
                    <option value="formatted_address">주소</option>
                    <option value="name">장소</option>
                </select>
                <input type="text" name="searchStr" placeholder="search place...">
                <button type="submit" onclick="setAction('/searchPlaceList')">🔍장소 검색</button>
                <button type="submit" onclick="setAction('/searchRouteList')">🔍동선 검색</button>
            </form>
        </div>
    </div>
</div>

<script>
    function setAction(actionUrl) {
        document.getElementById("searchForm").action = actionUrl;
    }
</script>
