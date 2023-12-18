<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="EUC-KR">
    <title>Insert title here</title>
</head>
<body>
<%
    String location = request.getParameter("location");
    String address="";

    if (location != null) {
        if (location.equals("신공학관")) {
            address = "28-27 Pil-dong, Jung-gu, Seoul";
        } else if (location.equals("학림관")) {
            address = "19-3 Pil-dong 3(sam)-ga, Jung-gu, Seoul";
        } else if (location.equals("만해관")) {
            address = "192-5 Jangchung-dong 2(i)-ga";
        }
    }

    // Set the address as a request attribute
    request.setAttribute("address", address);

    // Redirect to view1.jsp with the address as a parameter
    response.sendRedirect("view1.jsp?address=" + URLEncoder.encode(address, "UTF-8"));
%>
</body>
</html>
