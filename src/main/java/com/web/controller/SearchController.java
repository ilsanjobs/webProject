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

import com.web.beans.Store;

/**
 * Servlet implementation class TypeController
 */
@WebServlet("/SearchController")
public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SearchController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		List<Store> list = new ArrayList<>();
		PrintWriter out = response.getWriter();
		String a = request.getParameter("searchName");
		String currentAddress = request.getParameter("currentAddress");
		
		
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql_update;
		if (a != null) {
			try {
				// database 연결 생성
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://hyunseok.mysql.database.azure.com:3306/wptest?serverTimezone=UTC";
				conn = DriverManager.getConnection(url, "hyunseok", "qakh0130!");
				stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
				sql_update = "SELECT * FROM storeTable WHERE name like '%" + a + "%';";
				rs = stmt.executeQuery(sql_update);

				while (rs.next()) {
					Store store = new Store();
					store.setName(rs.getString("name"));
					store.setPhoneNumber(rs.getString("phoneNumber"));
					store.setType(rs.getString("type"));
					store.setAddress(rs.getString("address"));
					store.setNotes(rs.getString("notes"));
					store.setGrade(rs.getString("grade"));
					store.setImageURL(rs.getString("imageUrl"));
					list.add(store);
				}

			} catch (Exception e) {
				out.println("DB 연동 오류입니다.:" + e.getMessage());
			}
		}

		// 가져온 리스트를 request 속성에 저장
		request.setAttribute("storeList", list);
		request.setAttribute("currentAddress", currentAddress);

		RequestDispatcher dispatcher = request.getRequestDispatcher("view2.jsp");
		dispatcher.forward(request, response);
	}
}
