package com.utils;

import java.sql.*;

public class DBConnect {

	public static Connection getConnection() throws ClassNotFoundException, SQLException {
		String url = "jdbc:mysql://localhost:3306/zoho";
		String uname = "root";
		String upass = "Vasavi@JDBC3306";
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection(url, uname, upass);
		DatabaseMetaData md = conn.getMetaData();
		
		return conn;
	}
}
