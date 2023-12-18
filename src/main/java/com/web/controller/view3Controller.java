package com.web.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.web.beans.*;

/**
 * Servlet implementation class view3Controller
 */
@WebServlet("/view3Controller")
public class view3Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public view3Controller() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		String a = request.getParameter("name");
		String address = request.getParameter("address");
		Store store = createStore(a);
		Menu menu = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql_update;

		try {
			// database 연결 생성
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://hyunseok.mysql.database.azure.com:3306/wptest?serverTimezone=UTC";
			conn = DriverManager.getConnection(url, "hyunseok", "qakh0130!");
			stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
			sql_update = "SELECT * FROM storeInfoTable WHERE storeName='" + a + "';";
			rs = stmt.executeQuery(sql_update);

			while (rs.next()) {
				menu = new Menu();
				menu.setMenu1(rs.getString("menu1"));
				menu.setMenu2(rs.getString("menu2"));
				menu.setMenu3(rs.getString("menu3"));
				menu.setMenu4(rs.getString("menu4"));
				menu.setMenu5(rs.getString("menu5"));
				menu.setMenu6(rs.getString("menu6"));
				menu.setMenu7(rs.getString("menu7"));
				menu.setMenu8(rs.getString("menu8"));
			}

		} catch (Exception e) {
			out.println("DB 연동 오류입니다.:" + e.getMessage());
		}

	
		request.setAttribute("menu", menu);
		request.setAttribute("address", address);
		request.setAttribute("store", store);
		RequestDispatcher dispatcher = request.getRequestDispatcher("view3.jsp");
		dispatcher.forward(request, response);
	}
	
	private Store createStore(String a) {
		
		 Connection conn = null;
			Statement stmt = null;
			ResultSet rs = null;
			String sql_update;
			Store store = null;

			try {
				//database 연결 생성
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://hyunseok.mysql.database.azure.com:3306/wptest?serverTimezone=UTC";
				conn = DriverManager.getConnection(url, "hyunseok", "qakh0130!");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				sql_update = "SELECT * FROM storeTable WHERE name='" + a + "';";
				rs = stmt.executeQuery(sql_update);
				
				while(rs.next()) {
					store = new Store();
					store.setName(rs.getString("name"));
					store.setPhoneNumber(rs.getString("phoneNumber"));
					store.setAddress(rs.getString("address"));
					store.setNotes(rs.getString("notes"));
					store.setBusinessHours(rs.getString("businessHours"));		
		  
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		return store;
	}

}
