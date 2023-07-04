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
<%-- 차트 라이브러리--%>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css">
<%-- 제이쿼리 --%>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Plus(Title, Content, Month) {
    // 작성한 지금 시간을 객체에 저장
    var currentDate = new Date();
    var Year = currentDate.getFullYear();
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
            // 전달 받음 data의 길이가 0보다 작으면 작성한 게시물이 없다고 나타남
            if (data.length > 0) {
                for (var i = 0; i < data.length; i++) {
                    var content = data[i];
                    var link = "/diary/detail/" + encodeURIComponent(content.title);
                    list_container.append("<tr id='table_line'><td id='table_date'>" + content.day + " 일 " + "</td><td id='table_title'><a href=" + link + ">" + content.title + "</a></td></tr>");
                }
            } else {
                list_container.append("<tr id='table_line'><td colspan='2' id='table_not'> 작성한 게시물이 없습니다 </td></tr>");
            }

            var content = "";
            $("#Title").val(""); // Title 입력 창 비우기
            $("#Content").val("");
        },
        error: function (request, status, error) {
            console.log(error); // 에러 메시지를 콘솔에 출력
        }
    });
}
var month = "";
$(document).ready(function() {


   $("#Diary_btn").click(function() {
       // 버튼 클릭시 다이어리 리스트 호출
       var title = $("#Title").val();
       var content = $("#Content").val();
       var month = $("#Month").val();
       Plus(title , content , month);
   });

    // 차트 부분
   $("#Money_btn").click(function() {
       // 버튼 클릭 시 호출되는 부분
       var money = $("#Money").val();
       var where = $("#Where").val();
       var month = $("#Month").val();
       var money2 = $("#Money2").val();
       var where2 = $("#Where2").val();

       Account_money([money1, money2], [where1, where2], month);
   });

    var title = "";
    var content = "";
    var money = 0;
    var where = "";
    var month = $("#Month").val(); // 페이지 로딩 시 Month 값을 가져옴
    console.log(month);
    Plus(title , content, month);
    Account_money(money, where, month);
});

function Account_money(Money, Where, Month) {
     var currentDate = new Date();
     var Year = currentDate.getFullYear();
     var Day = currentDate.getDate();
    $.ajax({
        url: "/Account_book",
        type: "POST",
        cache: false,
        dataType: 'json',
        data: { Money: Money, Where_use: Where, Year:Year, Month:Month, Day:Day},
        async: false, // AJAX 요청을 동기적으로 처리합니다.
        success: function (data) {
            var accountList = data.accountList;
            var countMap = data.countMap;
            var moneyMap = data.moneyMap;
            var usedMap = data.MostUse;

            var labels = Object.keys(countMap);
            var dataPoints = Object.values(countMap);

            var moneyLabels = Object.keys(moneyMap);
            var moneyDataPoints = Object.values(moneyMap);
            var MostUsed = Object.values(usedMap);

                        var pieChartData = {
                            labels: labels,
                            datasets: [{
                                data: dataPoints,
                                backgroundColor: ['rgb(255, 99, 132)', 'rgb(255, 159, 64)', 'rgb(255, 205, 86)', 'rgb(75, 192, 192)', 'rgb(54, 162, 235)', 'rgb(153, 102, 255)']
                            }]
                        };

                        var ctx = document.getElementById('pieChartCanvas').getContext('2d');
                        window.pieChart = new Chart(ctx, {
                            type: 'pie',
                            data: pieChartData,
                            options: {
                                responsive: false
                            }
                        });

                        var pieChartData2 = {
                            labels: moneyLabels,
                            datasets: [{
                                data: moneyDataPoints,
                                backgroundColor: ['rgb(255, 99, 132)', 'rgb(255, 159, 64)', 'rgb(255, 205, 86)', 'rgb(75, 192, 192)', 'rgb(54, 162, 235)', 'rgb(153, 102, 255)']
                                }]
                        };

                        var ctx2 = document.getElementById('pieChartCanvas2').getContext('2d');
                        window.pieChart = new Chart(ctx2, {
                            type: 'pie',
                            data: pieChartData2,
                            options: {
                                responsive: false
                            }
                        });

            var list_container = $("#total_money");
            var total = 0;
            for (var i = 0; i < accountList.length; i++) {
                 total += accountList[i].money;
            }
            list_container.empty();
            list_container.append("<div><span>이번달 총 사용 금액 : " + total + "원" + "</span></div><div>이번 달 가장 많은 지출 내역 : " + MostUsed + "</div>");
        },
        error: function (request, status, error) {
            console.log(error); // 에러 메시지를 콘솔에 출력
        }
    });
}

</script>
</head>
<body>
    <div id="layout">
        <div id="left_container">
        <div><a href="/Home">홈 으로 돌아가기</a></div>
            <div id="diary_list">
                <table border="1">
                <thead>
                <th>작성 날짜</th>
                <th>작성 타이틀</th>
                </thead>
                <tbody class="dairy_list_item">
                </tbody>
                </table>
            </div>
        </div>
        <div id="input_container">
            <div id="right_container">
            <%
                int currentMonth = Calendar.getInstance().get(Calendar.MONTH) + 1;
                if (request.getAttribute("Month") != null) {
                    int Month = (int) request.getAttribute("Month");
                if (Month == currentMonth) { %>
                <div id="in_con">
                    <input type="text" placeholder="타이틀 입력" id="Title">
                    <textarea placeholder="내용을 입력하세요" id="Content"></textarea>
                    <button id="Diary_btn">추가 하기</button>
                </div>
            <% } else {%>
                   <div> 지난 날은 입력 불 가능합니다</div>
            <% } } %>
            </div>
            <div id="Account_book">
            <h2>가계부</h2
                <div>

                 <%
                 if (request.getAttribute("Month") != null) {
                    int Month = (int) request.getAttribute("Month");
                 if (Month == currentMonth) { %>
                  <div id="input_money">
                    <input type="number" id="Money">
                    <input type="hidden" id="Month" value="${Month}">
                    <select id="Where">
                        <option value="카페">카페</option>
                        <option value="식당">식당</option>
                        <option value="편의점">편의점</option>
                        <option value="문화 생활">문화 생활</option>
                        <option value="교통비">교통비</option>
                    </select>
                    <button id="Money_btn">추가 하기</button>
                    </div>
                      <% }  else {%>
                      <input type="hidden" id="Month" value="${Month}">
                      <div id="input_money"> 이번 달이 아닌 경우 입력 할 수 없습니다. </div>
                    <% } }  %>
                    <div id="charts">
                        <div class="chart-div">
                             <canvas id="pieChartCanvas" width="300px" height="300px"></canvas>
                             <div class="Chart_info">금액별 사용처</div>
                        </div>
                        <div class="chart-divs2">
                             <canvas id="pieChartCanvas2" width="300px" height="300px"></canvas>
                             <div class="Chart_info">사용처별 금액</div>
                        </div>
                    </div>
                        <div id="total_money_container">
                             <div id="total_money"></div>
                        </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>