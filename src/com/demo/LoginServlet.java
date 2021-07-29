package com.demo;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.utils.DBConnect;


public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
    public void doPost(HttpServletRequest request, HttpServletResponse response)  
            throws ServletException, IOException {  

        response.setContentType("text/html");  
        
        PrintWriter out = response.getWriter();  
        Connection conn;
		try {
			conn = DBConnect.getConnection();
			Statement stmt=conn.createStatement();
			String sql="select * from Users";
			ResultSet resultSet = stmt.executeQuery(sql);
		
			

	        String uname=request.getParameter("username");  
	        String pass=request.getParameter("userpass"); 
	        
	        int uid=0,f=0;
	        String role = null;
			while(resultSet.next()) {
				if(resultSet.getString("username").equals(uname)) {
					if(resultSet.getString("password").equals(pass)) {
						uid=resultSet.getInt("userid");
						role=resultSet.getString("role");
						f=1;
						break;
					}
				}
			}
			System.out.println("F value : "+uid);
	        if(f==1){  
		          HttpSession session = request.getSession(false);
		 	      if(session!=null) {
		 	    	  session.setAttribute("username", uname);
			 	      session.setAttribute("userid", uid);
			 	      session.setAttribute("role", role);
			 	      System.out.println("Role : "+role);
			    	  RequestDispatcher rd=request.getRequestDispatcher("HomePage.jsp");  
			          rd.forward(request,response); 
		 	      }
	        }  
	        else{  
	            out.print("<p style=\"color:red\">Sorry username or password error</p>");  
	            RequestDispatcher rd=request.getRequestDispatcher("login.jsp");  
	            rd.include(request,response);  
	        } 
	         
			
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
		
		
        out.close();  
    }
}
