<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UR+TF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/page3.css">
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyA9QlxXm2dyPwPsIDWZW224o9xC7LKyXqA&libraries=places"></script>
    <script>
        function initMap() {
            var geocoder = new google.maps.Geocoder();
            var map = new google.maps.Map(document.getElementById('map'), {
                zoom: 15,
                center: { lat: 37.7749, lng: -122.4194 } // Default coordinates (San Francisco)
            });

            // Get the address from the server-side code (you need to set this dynamically)
            var address = '<%= request.getParameter("address") %>';
            console.log('Address:', address);
            // Call the geocodeAddress function with the dynamic address
            geocodeAddress(geocoder, map, address);
        }

        function geocodeAddress(geocoder, resultsMap, address) {
            geocoder.geocode({ 'address': address }, function (results, status) {
                if (status === 'OK') {
                    resultsMap.setCenter(results[0].geometry.location);
                    var marker = new google.maps.Marker({
                        map: resultsMap,
                        position: results[0].geometry.location
                    });
                } else {
                    alert('Geocode was not successful for the following reason: ' + status);
                }
            });
        }
    </script>
</head>

<body onload="initMap()">
    <header>
        <div>
            <a href="view1.jsp"><h3><img src = "img/dongguk.png" width="200" height="auto"></h3></a>
        </div>
    </header>

    <main>
        <div class="main">
            <h2>식당 이름:${store.getName()}</h2>
            <div>식당 정보:${store.getNotes()}</div>
            <div>주소:${store.getAddress()}</div>
            <div>영업시간:${store.getBusinessHours()}</div>
            <div>전화번호:${store.getPhoneNumber()}</div>
        </div>
        <div class="main">
            <h2>식당 위치 나오는 지도</h2>
            <div>
                <div id="map" style="height: 300px; width: 50%;"></div>
            </div>
        </div>
        <div class="main">
            <h2>식당 메뉴</h2>
            <div>
                <span style="background-color: #E3E5E7;">
               <UL>
 			
			 <LI>${menu.getMenu1()}</LI> 					
 			 <LI>${menu.getMenu2()}</LI>
 			 <LI>${menu.getMenu3()}</LI>
 			 <LI>${menu.getMenu4()}</LI>
 			 <LI>${menu.getMenu5()}</LI>
 			 <LI>${menu.getMenu6()}</LI>
 			 <LI>${menu.getMenu7()}</LI>
 			 <LI>${menu.getMenu8()}</LI>
                </UL>
                </span>
            </div>
        </div>
    </main>
    <hr>
    <footer>
        <p>제작자 오현석, 정재환, 이찬영</p>
    </footer>
</body>
</html>
