package com.web.controller;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.beans.Store;
@WebServlet("/RecommendationController")
public class RecommendationController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 여기에서 추천 메뉴를 데이터베이스에서 가져오는 로직을 작성
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");

        Store recommendation = getRecommendationFromDatabase(); // 실제 메서드로 변경

        // 가져온 추천 메뉴를 클라이언트로 응답
        response.setContentType("text/plain;charset=UTF-8");
        response.getWriter().write(conversion(recommendation));
    }

  
    private String conversion(Store store) {
        if (store == null) {
            return "No recommendation available";
        }

        StringBuilder sb = new StringBuilder();
        sb.append("가게 이름: ").append(store.getName());
        sb.append(" 전화번호: ").append(store.getPhoneNumber());
        sb.append(" 종류: ").append(store.getType());
        sb.append(" 주소: ").append(store.getAddress());
        return sb.toString();
    }

    private Store getRecommendationFromDatabase() {
        List<Store> menuList = new ArrayList<>();
        Connection conn = null;
        PreparedStatement preparedStatement = null;
        ResultSet rs = null;
        String sql;

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://hyunseok.mysql.database.azure.com:3306/wptest?serverTimezone=UTC";
            conn = DriverManager.getConnection(url, "hyunseok", "qakh0130!");
            sql = "SELECT * FROM storeTable"; // 여러 속성을 가져오도록 수정
            preparedStatement = conn.prepareStatement(sql);
            rs = preparedStatement.executeQuery();
            while (rs.next()) {
                Store store = new Store();
                store.setName(rs.getString("name"));
                store.setPhoneNumber(rs.getString("phoneNumber"));
                store.setType(rs.getString("type"));
                store.setAddress(rs.getString("address"));
                menuList.add(store);
            }
            
            
            // 랜덤으로 추천 메뉴 선택
            Store recommendation = getRandomMenu(menuList);

            return recommendation;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (preparedStatement != null) preparedStatement.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return null;
    }

    private Store getRandomMenu(List<Store> menuList) {
        if (menuList.isEmpty()) {
            return null;
        }

        Random random = new Random();
        int randomIndex = random.nextInt(menuList.size());
        return menuList.get(randomIndex);
    }
}