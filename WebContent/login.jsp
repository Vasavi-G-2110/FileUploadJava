<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login Page</title>
<link rel="stylesheet" href="StyleSheet.css">
<style>
body {
	text-align: center;
}
</style>
</head>
<body>

	<div id="top">
		<li style="float: center"><a href="#">Data Analytics</a></li>
	</div>
	<div id="content">
	<form action="LoginServlet" method="post">

		<fieldset style="width: 250px; text-align: right; height: 300px;">
			<legend> Login to App </legend>
			<table>
				<tr>
					<td>User Name</td>
					<td><input type="text" name="username" placeholder="Username"
						required="required" /></td>
				</tr>
				<tr />
				<tr />
				<tr />
				<tr />
				<tr />
				<tr />
				<tr>
					<td>Password</td>
					<td><input type="password" name="userpass"
						placeholder="Password" required="required" /></td>
				</tr>
				<tr />
				<tr />
				<tr />
				<tr />
				<tr />
				<tr />
				<tr />
				<tr>
					<td />
					<td><input type="submit" value="Sign in" /></td>
				</tr>
			</table>
		</fieldset>



	</form>
	</div>
</body>
</html>