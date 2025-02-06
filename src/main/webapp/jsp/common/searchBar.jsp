<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


		<div>
		    <div class="search-container">
		        <div class="search-bar">
		            <form id="searchForm" action="/searchList" method="get">
		                <select id="searchType" name="searchGubun" onchange="toggleSearchResults()">
					        <option value="formatted_address">주소</option>
					        <option value="name">장소</option>
		                </select>
		                <input type="text" name="searchStr" placeholder="search place...">
		                <button type="submit">🔍</button>
		            </form>
		            
		            <form id="searchForm2" action="/searchListByPlaceQuery" method="get">
		                <select id="searchType2" name="searchGubun2" onchange="toggleSearchResults()">
					        <option value="formatted_address">주소</option>
					        <option value="name">장소</option>
		                </select>
		                <input type="text" name="searchStr2" placeholder="search place...">
		                <button type="submit">🔍</button>
		            </form>
		        </div>
		    </div>
		</div>