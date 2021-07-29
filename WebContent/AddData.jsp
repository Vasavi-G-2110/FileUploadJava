<%@ page import="java.sql.*"%>
<%@ page import="com.utils.DBConnect" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Data</title>
<link rel="stylesheet" href="StyleSheet.css">

</head>
<body>

	<div id="top">
		<li><a href="default.asp">Data Analytics</a></li>
		<li id="userview"><a href="AddData.jsp">Dashboard</a></li>
		
		<li><%if(session.getAttribute("role").equals("Admin")){%></li>
		
		<li><a href="ViewUsersSummary.jsp">Settings</a></li>
		<%} %>
		<li style="float: right"><a href="AddData.jsp">Add new Data source</a></li>
	</div>
	<%
	
	Connection conn = DBConnect.getConnection();
	Statement statement = conn.createStatement();
	ResultSet resultset = statement.executeQuery("select * from DataSummary");
	%>
	<div id="left">
	<br />
	<%
		while (resultset.next()) {
		%>
		<li><%=resultset.getString(2)%></li>
		 <%
		}
		%>
	<br />
	</div>
	<div id="content">
	<form action="UploadCSV" method="post" enctype="multipart/form-data">

		Data Source Name :<input type="text" name="dsname" maxlength=9/><br /> Upload
		CSV file :<input type="file" name="file"/><br /> <input
			type="submit" value="save" /> <input type="reset" value="cancel" />
	</form>
	
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
 
$(document).ready(function() {
    $("#top #userview a").click(function() {
    	 $("#content").load("ViewUsersSummary.jsp");
    });
});



$(function() { // when DOM is ready
    $("#left").on('click','li',function(){ // when #showhidecomment is clicked
    	var selectedValue = $(this).text();
        $("#content").load("ViewTable.jsp", {var1:selectedValue}); // load the sample.jsp page in the #chkcomments element
    }); 
});


</script>
	

	
	
</body>
</html>