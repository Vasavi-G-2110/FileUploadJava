
<%@page import="com.utils.DBConnect"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%
Class.forName("com.mysql.cj.jdbc.Driver");
%>
<HTML>
<HEAD>
<TITLE>The View Of Database Table</TITLE>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<link rel="stylesheet" href="StyleSheet.css">
</HEAD>
<BODY> 



	<%
	String val = request.getParameter("var1");
	%>

	<H1><%=val%>
		- Summary
	</H1>
	<%
	
	Connection conn = DBConnect.getConnection();
	Statement statement = conn.createStatement();
	ResultSet resultset = statement.executeQuery("select * from UserData where dataname = '" + val + "';");

	ResultSetMetaData rsMetaData = resultset.getMetaData();
	System.out.println("List of column names in the current table: ");
	int count = rsMetaData.getColumnCount();
	System.out.println(count);

	List<Integer> columns = new ArrayList<>();
	ResultSet rs1 = resultset;
	List<String> firstrow = new ArrayList<>();
	String col, st;
	while (rs1.next()) {
		for (int i = 4; i <= count; i++) {
			System.out.println(i);
			col = rsMetaData.getColumnName(i);
			st = rs1.getString(col);
			if (st != null) {
		columns.add(i);
		firstrow.add(st);
			}
		}
		break;
	}
	System.out.println("*************");
	System.out.println(columns.toString());
	%>
	<%
	Statement statement1 = conn.createStatement();

	ResultSet rset1 = statement1.executeQuery("select * from DataSummary where dsname = '" + val + "';");
	System.out.println("*************");
	int allowable = 0;
	String addby = "", addon = "";
	while (rset1.next()) {
		addby = rset1.getString(6);
		addon = rset1.getString(3);
		allowable = rset1.getInt(5);
		System.out.println(allowable);
	}
	System.out.println("*************");
	%>


	<%
	if ((session.getAttribute("role").equals("Admin")) || (allowable == 1)) {
	%>
	
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

<script src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.16/js/dataTables.bootstrap4.min.js"></script>
<div class="container">
	<div class="row">
	<table id="example" class="table table-striped table-bordered" style="width:100%">
        <thead>
            <tr>
			<%
			for (Integer c : columns) {
			%>


			<TH><%=rsMetaData.getColumnName(c)%></TH>

			<%
			}
			%>
		</tr>
		</thead>
		<tbody>
		<tr>
			<%
			for (String s : firstrow) {
			%>

			<td><%=s%></td>


			<%
			}
			%>
		</tr>

		

		<%
		while (resultset.next()) {
		%>
		<tr>
			<%
			for (Integer c : columns) {
			%>

			<td><%=resultset.getString(c)%></td>


			<%
			}
			%>
		</tr>
		<%
		}
		%>
	</tbody>
	</table>
	</div>
	</div>
	<hr>

	<p>
		Data Added by :
		<%=addby%></p>
	<p>
		Data Added date :
		<%=addon%></p>
	<%if( %><%addby.equals(session.getAttribute("username")) || session.getAttribute("role").equals("Admin") ){ %>
	<h4>Actions:</h4>
	<p>
		<a id="del" href="DeleteData.jsp">Remove</a> the datasource
	</p>
	<%
	session.setAttribute("dsDel", val);
	%>
	<%if(session.getAttribute("role").equals("Admin") && allowable==0){ %>
	<p>
		<a id="show" href="AccessProv.jsp">Show</a> the data to guests
	</p>
	<%} %>
	<%
	} } else {
	%>
	<h4>Data not accessible. Contact Admin for Further details</h4>

	<%
	}
	%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script>
		$(document).on("click", "#del", function() {
			alert("Successfully Deleted ! ");
		});

		$(document).on("click", "#show", function() {
			alert("Data is accessible to other users now ! ");
		});
		
		
		
			</script>


</BODY>
<script>
$(document).ready(function() {
    $('#example').DataTable(
        
         {     

      "aLengthMenu": [[5, 10, 25, -1], [5, 10, 25, "All"]],
        "iDisplayLength": 5
       } 
        );
} );

</script>
</HTML>
