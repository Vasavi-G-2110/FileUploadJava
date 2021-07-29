<%@page import="com.utils.DBConnect"%>
<%@ page import="java.sql.*"%>
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
	
	Statement stmt = conn.createStatement();
	String sql = "select * from DataSummary where dsname='"+tbName+"';";
	ResultSet idrs=stmt.executeQuery(sql);
	idrs.next();
	int deltbId=idrs.getInt(1);
	 
	//update
	int totcount=0;
	Statement stmt1=conn.createStatement();
	String sqlgettot="select * from Users where userid = "+deltbId+";";
	ResultSet rs = stmt1.executeQuery(sqlgettot);
	rs.next();
	totcount=rs.getInt("totaldatasources");
	
	String sql1="update Users set totaldatasources = "+(totcount-1)+" where userid = "+deltbId+";"; 
	
	stmt1.executeUpdate(sql1);
	
	//delete
	Statement statement1 = conn.createStatement();
	statement1.executeUpdate("delete from DataSummary where dsname = '" + tbName + "' and userid="+deltbId+";");

	Statement statement2 = conn.createStatement();
	statement2.executeUpdate("delete from UserData where dataname = '" + tbName + "' and userid="+deltbId+";");

	session.removeAttribute("dsDel");
	response.sendRedirect("AddData.jsp");
	
	%>



</body>
</html>