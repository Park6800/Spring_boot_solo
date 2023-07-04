<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 홈</title>
<link rel="stylesheet" href="/css/main.css">
<%-- 제이쿼리 --%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
    <div id="Main_container">
        <div id="Con_center">
            <div>기존 프로젝트 설명 및 파일</div>
            <div id="Project_file">파일</div>
        </div>
    <div id="input_container">
    <form method="Get" action="/diary">
        <select name="Month" id="Sel_Month">
            <option value="1">1월</option>
            <option value="2">2월</option>
            <option value="3">3월</option>
            <option value="4">4월</option>
            <option value="5">5월</option>
            <option value="6">6월</option>
            <option value="7">7월</option>
            <option value="8">8월</option>
            <option value="9">9월</option>
            <option value="10">10월</option>
            <option value="11">11월</option>
            <option value="12">12월</option>
        </select>
        <button id="Btn_Month">일지</button>
    </form>
    </div>
    </div>
</body>
</html>