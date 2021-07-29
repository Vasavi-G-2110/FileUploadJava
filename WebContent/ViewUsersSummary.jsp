<%@ page import="java.sql.*"%>
<%@ page import="com.utils.DBConnect" %>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
%>
<HTML>
<HEAD>
<TITLE>Users</TITLE>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">

<link rel="stylesheet" href="StyleSheet.css">
</HEAD>
<BODY>
	
	<div id="top">
		<li><a href="default.asp">Data Analytics</a></li>
		<li id="userview"><a href="AddData.jsp">Dashboard</a></li>
		<%if(session.getAttribute("role").equals("Admin")){ %>
		<li><a href="ViewUsersSummary.jsp">Settings</a></li>
		<li id="useradd" style="float: right"><a href="#">Add new Users</a></li>
		<%} %>
	</div>
	<div id="left">
	<br />
	<li>Users</li>
	</div>
	
	<div id="content">
	<H1>Users Summary</H1>
	<%
	
	Connection conn = DBConnect.getConnection(); 
	Statement statement = conn.createStatement();
	ResultSet resultset = statement.executeQuery("select * from Users");
	%>
	<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
<div class="container">
	<div class="row">
	<TABLE id="example" class="table table-striped table-bordered" style="width:100%">
	<thead>
		<TR>
			<TH>ID</TH>
			<TH>User Name</TH>
			<TH>Added Date</TH>
			<TH>Data Sources</TH>
			<TH>Role</TH>
		</TR>
		</thead>
		<%
		while (resultset.next()) {
		%>
		<TR>
			<TD><%=resultset.getInt(1)%></TD>
			<TD><%=resultset.getString(2)%></td>
			<TD><%=resultset.getString(6)%></TD>
			<TD><%=resultset.getString(5)%> source</TD>
			<TD><%=resultset.getString(4)%></TD>
		</TR>
		<%
		}
		%>
	</TABLE>
	</div>
	</div>
	</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script>
 
$(document).ready(function() {
    $("#top #useradd a").click(function() {
    	 $("#content").load("AddUsers.jsp");
    });
});

</script>	
</BODY>
</HTML>
