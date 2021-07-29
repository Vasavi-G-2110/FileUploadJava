<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home</title>
<link rel="stylesheet" href="StyleSheet.css">
<style>
body {
	text-align: center;
}
</style>
</head>
<body>


	<div id="top">
		<li><a class="active" href="default.asp">Data Analytics</a></li>
		<li><a href="news.asp">Dashboard</a></li>
		<%if(session.getAttribute("role").equals("Admin")){ %>
		<li><a href="ViewUsersSummary.jsp">Settings</a></li>
		<%} %>
		<li style="float: right"><a href="AddData.jsp">Add new Data Source</a></li>
	</div>
	<p>No details available</p>
	<a href="AddData.jsp">Add Data</a><br />
	
</body>
</html>