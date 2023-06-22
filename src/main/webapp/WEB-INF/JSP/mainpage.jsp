<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 홈</title>
</head>
<body>
    <div>메인 홈 페이지 입니다.</div>
    <div>
    <form method="Get" action="diary/{Moon}">
        <input type="hidden" value="6" name="Moon">
        <button>6월 개발 일정</button>
    </form>
    </div>
</body>
</html>