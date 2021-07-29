<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>AddUsers</title>
</head>
<body>


<form action="AddUser" method="post">
	<fieldset style="width: 400px; text-align: center; height: 200px;">
			
			<table>
				<tr>
					<td>User Name</td>
					<td><input type="text" name="username" placeholder="Username"
						required="required" /></td>
				</tr>
				<tr>
					<td>Password</td>
					<td><input type="password" name="password" placeholder="Password"
						required="required" /></td>
				</tr>

				<tr>
					<td>Role</td>

					<td>

						<div
							style="position: relative; width: 200px; height: 25px; border: 0; padding: 0; margin: 0;">
							<select id="role" name="role">
								<option value="" disabled selected>Select role</option>
								<option value="Admin">Admin</option>
								<option value="Guest">Guest</option>

							</select>
						</div>
					</td>
				</tr>
				<tr>
					<td><input type="submit" value="save" /></td>
					<td><input type="reset" value="cancel" /></td>
				</tr>
			</table>
		

		</fieldset>

</form>
</body>
</html>