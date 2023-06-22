<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인 홈</title>
<link rel="stylesheet" href="/css/diary.css">
</head>
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
function Plus(Year, Moon, Day, Title, Content) {
    $.ajax({
        url: "/diary",
        type: "POST",
        cache: false,
        dataType: 'json',
        data: { Year: Year, Moon: Moon, Day: Day, Title: Title, Content: Content },
        success: function (data) {
            var list_container = $(".dairy_list_item");
            for (var i = 0; i < data.length; i++) {
                var content = data[i];
                // 새로운 항목을 리스트에 추가
                list_container.append("<li><div>" + content.title + "</div></li>");
                var content = "";
            }
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
                <ul class="dairy_list_item"></ul>
            </div>
        </div>
        <div id="right_container">
            <input type="text" placeholder="연도를 입력하세요" id="Year">
            <input type="text" placeholder="월을 입력하세요" id="Moon">
            <input type="text" placeholder="날 짜를 입력하세요" id="Day">
            <input type="text" placeholder"타이틀 입력" id="Title">
            <input type="text" placeholder="내용을 입력하세요" id="Content">
            <button onclick="Plus(Year.value, Moon.value, Day.value , Title.value, Content.value)">추가 하기</button>
        </div>
    </div>
</body>
</html>