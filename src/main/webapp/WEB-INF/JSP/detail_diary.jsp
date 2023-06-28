<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar" %>
<%@page import="Annotation.entity.*"%>
<%@page import="Annotation.repository.*"%>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 홈</title>
<link rel="stylesheet" href="/css/detail.css">
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<body>
<%
List<DiaryEntity> diary = (List<DiaryEntity>) request.getAttribute("Detail");
%>
    <div>
    <form method="Post" action="/diary/detail">
        <div>
        <input type="text"
            value="<%=diary.get(0).getTitle() %>"
            id="title_value" name="Title">
        </div>
        <div>
        <textarea
            id="content_value" name="Content"><%=diary.get(0).getContent() %></textarea>
        </div>
        <input type="hidden" value="<%=diary.get(0).getMonth()%>" name="Month">
        <input type="hidden" value="<%=diary.get(0).getDiary_Id()%>" name="Diary_Id">
        <button id="Change" type="submit">수정</button>
    </form>
    </div>
</body>
</html>