<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 홈</title>
<link rel="stylesheet" href="/css/diary.css">
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Plus(Title, Content) {
     var currentDate = new Date();
     var Year = currentDate.getFullYear();
     var Month = currentDate.getMonth() + 1; // (+1을 해주는 이유는 getMonth()의 반환값이 0부터 시작하기 때문)
     var Day = currentDate.getDate();
    $.ajax({
        url: "/diary",
        type: "POST",
        cache: false,
        dataType: 'json',
        data: { Year: Year, Month: Month, Day: Day, Title: Title, Content: Content },
        success: function (data) {
            var list_container = $(".dairy_list_item");
            list_container.empty();
            for (var i = 0; i < data.length; i++) {
                var content = data[i];
                var link = "/diary/detail/" + encodeURIComponent(content.title);
                // 새로운 항목을 리스트에 추가

                list_container.append("<a href=" + link + "><div><span>" + content.day + " 일 " + "</span><span>" + content.title + "</span></div></a>");
                var content = "";
            }
            $("#Title").val(""); // Title 입력 창 비우기
            $("#Content").val("");
        },
        error: function (request, status, error) {
            console.log(error); // 에러 메시지를 콘솔에 출력
        }
    });
}

function Account_money(Money, Where) {
     var currentDate = new Date();
     var Year = currentDate.getFullYear();
     var Month = currentDate.getMonth() + 1; // (+1을 해주는 이유는 getMonth()의 반환값이 0부터 시작하기 때문)
     var Day = currentDate.getDate();
    $.ajax({
        url: "/Account_book",
        type: "POST",
        cache: false,
        dataType: 'json',
        data: { Money: Money, Where_use: Where, Year:Year, Month:Month, Day:Day},
        success: function (data) {
            var list_container = $("#total_money");
            var total = 0;
            for (var i = 0; i < data.length; i++) {
            console.log(data)
                 total += data[i].money;
            }
            list_container.append("<div><span>" + total + "원" + "</span></div>");
        },
        error: function (request, status, error) {
            console.log(error); // 에러 메시지를 콘솔에 출력
        }
    });
}
</script>
<body>
    <div id="layout">
        <div id="left_container">
            <div id="diary_list">
                <ul class="dairy_list_item">
                <c:forEach var="diary" items="${Diary_List}" varStatus="list">
                <div>
                <a href="/diary/detail/${diary.title}">
                    <span><c:out value="${diary.day}" /> 일</span>
                    <span><c:out value="${diary.title}" /></span>
                </a>
                </div>
                </c:forEach>
                </ul>
            </div>
        </div>
        <div id="input_container">
            <div id="right_container">
            <%
                int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
                if (request.getAttribute("Month") != null) {
                    int Month = (int) request.getAttribute("Month");
                if (Month == currentMonth) { %>
                    <input type="text" placeholder="타이틀 입력" id="Title">
                    <input type="text" placeholder="내용을 입력하세요" id="Content">
                    <button onclick="Plus(Title.value, Content.value)">추가하기</button>
            <% } else {%>
                   <div> 지난 날은 입력 불 가능합니다</div>
            <% } } %>
            </div>
            <div id="Account_book">
            <h2>가계부</h2
                <div>
                    <input type="number" id="Money">
                    <select id="Where">
                        <option value="카페">카페</option>
                        <option value="식당">식당</option>
                        <option value="편의점">편의점</option>
                        <option value="문화 생활">문화 생활</option>
                        <option value="교통비">교통비</option>
                    </select>
                    <button onclick="Account_money(Money.value , Where.value)">추가 하기</button>
                </div>
                <div>
                    <div id="total_money"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>