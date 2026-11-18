<%@ page import="bookstore.Book" %>
<%
    Book book = (Book) request.getAttribute("book");
    if (book == null) {
        response.sendRedirect("admin-dashboard.jsp");
        return;
    }
%>
<html>
<head><title>Edit Book</title></head>
<body>
<h2>Edit Book</h2>
<form method="post" action="EditBookServlet">
ISBN: <input type="text" name="isbn" value="<%= book.getIsbn() %>" readonly /><br/><br/>
Title: <input type="text" name="title" value="<%= book.getTitle() %>" required /><br/><br/>
Author: <input type="text" name="author" value="<%= book.getAuthor() %>" required /><br/><br/>
Edition Number: <input type="number" name="editionNumber" value="<%= book.getEditionNumber() %>" required /><br/><br/>
Publisher: <input type="text" name="publisher" value="<%= book.getPublisher() %>" required /><br/><br/>
Copyright: <input type="text" name="copyright" value="<%= book.getCopyright() %>" required /><br/><br/>
Price: <input type="number" step="0.01" name="price" value="<%= book.getPrice() %>" required /><br/><br/>
<input type="submit" value="Update Book" />
</form>
<% String error = (String) request.getAttribute("errorMsg");
   if (error != null) { %>
   <p style="color:red;"><%= error %></p>
<% } %>
<a href="admin-dashboard.jsp">Back to Admin Dashboard</a>
</body>
</html>
