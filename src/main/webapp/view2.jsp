<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List"%>
<%@ page import="com.web.beans.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.net.*"%>
<%@ page import="com.google.maps.GeoApiContext"%>
<%@ page import="com.google.maps.GeocodingApi"%>
<%@ page import="com.google.maps.model.GeocodingResult"%>
<%@ page import="com.google.maps.model.LatLng"%>

<%
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>
<%!
double haversine(double lat1, double lon1, double lat2, double lon2) {
    // Radius of the Earth in kilometers
    double R = 6371.0;

    // Convert latitude and longitude from degrees to radians
    double lat1Rad = Math.toRadians(lat1);
    double lon1Rad = Math.toRadians(lon1);
    double lat2Rad = Math.toRadians(lat2);
    double lon2Rad = Math.toRadians(lon2);

    // Calculate differences
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Haversine formula
    double a = Math.pow(Math.sin(dLat / 2), 2) + Math.cos(lat1Rad) * Math.cos(lat2Rad) * Math.pow(Math.sin(dLon / 2), 2);
    double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

    // Distance in kilometers
    return R * c;
    
}
%>
<% 
// Google Maps API Key
String apiKey = "AIzaSyA9QlxXm2dyPwPsIDWZW224o9xC7LKyXqA";
GeoApiContext context = new GeoApiContext.Builder().apiKey(apiKey).build();

// Convert current address to LatLng
String currentAddress = (String) request.getAttribute("currentAddress");
LatLng currentLatLng = null;
try {
    GeocodingResult[] currentAddressResults = GeocodingApi.geocode(context, currentAddress).await();
    
    // Check if currentAddressResults is not empty before accessing its elements
    
    if (currentAddressResults != null && currentAddressResults.length > 0) {
        currentLatLng = currentAddressResults[0].geometry.location;
    }
} catch (Exception e) {
    e.printStackTrace();
    // Handle the exception (log, return a default value, etc.)
}

List<Store> typeList = (List<Store>)request.getAttribute("typeList");
List<Store> storeList = (List<Store>)request.getAttribute("storeList");
// Calculate distances and sort storeList
if(storeList==null&&typeList!=null){
	if (currentLatLng != null) {
	    for (Store store : typeList) {
	        try {
	            GeocodingResult[] storeAddressResults = GeocodingApi.geocode(context, store.getAddress()).await();
	            LatLng storeLatLng = storeAddressResults[0].geometry.location;

	            // Check if storeLatLng is not null before accessing its properties
	            if (storeLatLng != null) {
	                // Calculate distance and set it in the Store object
	                double distance = haversine(currentLatLng.lat, currentLatLng.lng, storeLatLng.lat, storeLatLng.lng);
	                store.setDistance(distance);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            // Handle the exception (log, return a default value, etc.)
	        }
	    }
}
	
	Collections.sort(typeList, Comparator.comparingDouble(Store::getDistance)); 
}
else if (storeList!=null&&typeList==null){
if (currentLatLng != null) {
    for (Store store : storeList) {
        try {
            GeocodingResult[] storeAddressResults = GeocodingApi.geocode(context, store.getAddress()).await();
            LatLng storeLatLng = storeAddressResults[0].geometry.location;

            // Check if storeLatLng is not null before accessing its properties
            if (storeLatLng != null) {
                // Calculate distance and set it in the Store object
                double distance = haversine(currentLatLng.lat, currentLatLng.lng, storeLatLng.lat, storeLatLng.lng);
                store.setDistance(distance);
            }
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the exception (log, return a default value, etc.)
        }
    }
}
Collections.sort(storeList, Comparator.comparingDouble(Store::getDistance)); 
}

// Sort storeList based on distances

%>

<!DOCTYPE html>
<html>

<head>
<!-- <link href="css/view2.css" rel="stylesheet" type="text/css" /> -->
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA9QlxXm2dyPwPsIDWZW224o9xC7LKyXqA&libraries=places">
	
</script>
<script type="text/javascript" src="js/view2.js"></script>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>동국대학교 Restaurant Directory</title>
<link rel="stylesheet" href="css/page2.css">
</head>

<body>

	<header>
		<div>
			<a href="view1.jsp"><h3><img src = "img/dongguk.png" width="200" height="auto"></h3></a>
			현재 주소 :
			<%=request.getAttribute("currentAddress") %>
		</div>
	</header>

	<main>
		<div class="main">
			<div class="main">

		   <form method="get" action="SearchController" onsubmit="return validateSearchForm();">
                	<input type="hidden" name="currentAddress" value="<%= currentAddress %>">
                    검색창<br>
                    <input class="searchbox" id = "searchName" name = "searchName" type="text" placeholder="음식 또는 식당 검색">
                    <input class="searchbutton" type="submit" value="검색">
                </form>

			</div>
			<c:choose>
		<c:when test="${not empty storeList}">
					<div>
						<c:forEach var="store" items="${storeList}">
							<!-- Restaurant Card -->
							<div class="restaurant-box">
								<div class="restaurant-image"><img src="${store.getImageURL()}"/></div>
								<div class="restaurant-data">
									<div>
										<a href="view3Controller?address=${store.getAddress()}&name=${store.getName()}"><b>${store.getName()}</b></a>
									</div>
									<br> <br> 식당전화번호:${store.getPhoneNumber()}<br> <br>
									식당영업시간:${store.getType()}<br> <br>
									가게소개:${store.getNotes()}<br> <br>
									평점:${store.getGrade()}
								</div>
							</div>
						</c:forEach>
					</div>
				</c:when>
				<c:when test="${not empty typeList}">
					<div>
						<c:forEach var="store" items="${typeList}">
							<!-- Restaurant Card -->
							<div class="restaurant-box">
								<div class="restaurant-image"><img src="${store.getImageURL()}"/></div>
								<div class="restaurant-data">
									<div>
										<a href="view3Controller?address=${store.getAddress()}&name=${store.getName()}"><b>${store.getName()}</b></a>
									</div>
									<br> <br> 식당전화번호:${store.getPhoneNumber()}<br> <br>
									식당영업시간:${store.getType()}<br> <br>
									가게소개:${store.getNotes()}<br> <br>
									평점:${store.getGrade()}
								</div>
							</div>
						</c:forEach>
						<!-- Repeat for each restaurant -->
						<!-- ... -->
					</div>
				</c:when>
				<c:otherwise>
			  해당 식당이 존재하지 않습니다.
			</c:otherwise>
			</c:choose>
		</div>
	</main>
	<hr>
	<footer>
		<p>제작자 오현석, 정재환, 이찬영</p>
	</footer>
</body>

</html>