<%@ page import="java.sql.*"%>
<%@ page import="com.utils.DBConnect" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
	String tbName = (String) session.getAttribute("dsDel");
	
	Connection conn = DBConnect.getConnection();
	
	//update
		Statement statement1 = conn.createStatement();
		statement1.executeUpdate("update DataSummary set allowable = 1 where dsname = '"+tbName+"';");
	
	
	session.removeAttribute("dsDel");
	response.sendRedirect("AddData.jsp");
	
	%>
</body>
</html>