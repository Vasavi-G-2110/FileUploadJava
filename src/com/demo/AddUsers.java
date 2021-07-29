package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.utils.DBConnect;

public class AddUsers extends HttpServlet {
	@Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {   

		Connection conn;
		try {
			conn = DBConnect.getConnection();
			String username,password,role;
			Statement stmt=conn.createStatement();
			username=request.getParameter("username");
	        password=request.getParameter("password");
	        role=request.getParameter("role");
	        String sql="insert into Users(username,password,role,totaldatasources,lastadded) values('"+username+"','"+password+"','"+role+"',0,'Still not added')";
	        stmt.executeUpdate(sql);
	        RequestDispatcher rd=request.getRequestDispatcher("ViewUsersSummary.jsp");  
	         rd.forward(request,response); 
	        
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
    
       
        
        
	}

}