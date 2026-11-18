<html>
<head><title>Add New Book</title></head>
<body>
<h2>Add New Book</h2>
<form method="post" action="AddBookServlet">
ISBN: <input type="text" name="isbn" required /><br/><br/>
Title: <input type="text" name="title" required /><br/><br/>
Author: <input type="text" name="author" required /><br/><br/>
Edition Number: <input type="number" name="editionNumber" required /><br/><br/>
Publisher: <input type="text" name="publisher" required /><br/><br/>
Copyright: <input type="text" name="copyright" required /><br/><br/>
Price: <input type="number" step="0.01" name="price" required /><br/><br/>
<input type="submit" value="Add Book" />
</form>
<% String error = (String)request.getAttribute("errorMsg");
   if(error != null){ %>
   <p style="color:red;"><%= error %></p>
<% } %>
<a href="admin-dashboard.jsp">Back to Admin Dashboard</a>
</body>
</html>
