<%@ page language="java" contentType="text/html; charset=EUC-KR" 
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	<script type="text/javascript" src="js/view1.js"></script>
	<link rel="stylesheet" href="css/page1.css">
</head>
<body>
	<header>
            <a href="view1.jsp"><h3><img src = "img/dongguk.png" width="200" height="auto"></h3></a>
    </header>
    
    <main>
        <div class="main">
            <div>
                <h2>현재 위치와 가까운 곳을 선택하세요!</h2>
                <div>
                    <form method="get" action="a.jsp">
                        <input type="radio" name="location" value="신공학관" id="location1"> 
   						 <label for="location1">신공학관</label>
    
    					<input type="radio" name="location" value="학림관" id="location2"> 
					    <label for="location2">학림관</label>
					    
					    <input type="radio" name="location" value="만해관" id="location3"> 
					    <label for="location3">만해관</label>
					    <!-- Add a submit button -->
					    <input class="searchbutton" type="submit" value="선택">
                    </form>
                    <%
                    String currentAddress = request.getParameter("address");
 					request.setAttribute("currentAddress", currentAddress);
 					%>
 					현재위치: <%=currentAddress %>
                </div>
            </div>
            <br>
            <div>
                <form method="get" action="SearchController" onsubmit="return validateSearchForm();">
                	<input type="hidden" name="currentAddress" value="<%= currentAddress %>">
                    검색창<br>
                    <input class="searchbox" id = "searchName" name = "searchName" type="text" placeholder="음식 또는 식당 검색">
                    <input class="searchbutton" type="submit" value="검색">
                </form>
            </div>
            <br>
            <div>
                <button class="button" onclick="location.href='TypeController?category=한식&currentAddress=<%=currentAddress%>'">한식</button>
                <button class="button" onclick="location.href='TypeController?category=중식&currentAddress=<%=currentAddress%>'">중식</button>
                <button class="button" onclick="location.href='TypeController?category=일식&currentAddress=<%=currentAddress%>'">일식</button>
                <button class="button" onclick="location.href='TypeController?category=양식&currentAddress=<%=currentAddress%>'">양식</button><br>
                <button class="button" onclick="location.href='TypeController?category=치킨&currentAddress=<%=currentAddress%>'">치킨</button>
                <button class="button" onclick="location.href='TypeController?category=피자&currentAddress=<%=currentAddress%>'">피자</button>
                <button class="button" onclick="location.href='TypeController?category=햄버거&currentAddress=<%=currentAddress%>'">햄버거</button>
                <button class="button" onclick="location.href='TypeController?category=고기&currentAddress=<%=currentAddress%>'">고기</button>
            </div>

            <div>
                <h3>땡기는 음식이 없을 땐!</h3>
                <form onsubmit="return false">
					<input type="submit" value="추천 받기" onclick="showRecommendedMenu();reloadPage();" class="recommendbutton">
				</form>
            </div>

            <div>
            
                <h4>추천 음식 식당 정보</h4> 
           	<div id="recommendationDiv"></div>
            </div>
        </div>
    </main>
    <hr>
    <footer>
        <p>제작자 오현석, 정재환, 이찬영</p>
    </footer>

<%!
		String recommendMenu() {
	    HashMap<Integer, String> map = new HashMap<Integer, String>();
	    map.put(1, "치킨");
	    map.put(2, "피자");
	    map.put(3, "햄버거");
	    map.put(4, "고기");
	    map.put(5, "한식");
	    map.put(6, "중식");
	    map.put(7, "양식");
	    map.put(8, "일식");
	
	    Random random = new Random();
	    random.setSeed(System.currentTimeMillis());
	    int key = random.nextInt(8) + 1;
	
	    String menu = map.get(key);
	    return menu;
	}
%>

    <script>
		function updateRecommendation() {
    	// Ajax를 이용하여 서버에서 추천 메뉴를 가져오기
		    $.ajax({
		        type: "GET",
		        url: "RecommendationController", // 실제 서블릿 또는 컨트롤러 URL로 변경
		        success: function (data) {
		            // 가져온 데이터를 recommendationDiv에 업데이트
		            $("#recommendationDiv").html(data);
		        },
		        error: function () {
		            console.log("추천 메뉴를 가져오는 중 에러가 발생했습니다.");
		        }
		    });
		}
		// 일정 간격으로 추천 메뉴 업데이트
		setInterval(updateRecommendation, 5000); // 5초마다 업데이트 (1000ms = 1초)
		function showRecommendedMenu() {
			alert('오늘 식사는 <%= recommendMenu() %>!');
		}
		
		function reloadPage(){  
		      $("#recommend").load(window.location.href + "#recommend");
		}
	</script>
</body>
</html>


