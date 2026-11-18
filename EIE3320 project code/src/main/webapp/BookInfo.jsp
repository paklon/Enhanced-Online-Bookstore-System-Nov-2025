<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="bookstore.Book" %>

<%
    ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("bookList");
    if (books == null) {
        books = new ArrayList<Book>();
    }
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = sdf.format(now);
%>

<html>
<head><title>Book Information</title></head>
<body>
<table border="0" cellpadding="5">
    <tr><td><b>Student Name:</b> Yuen Pak Hei</td></tr>
    <tr><td><b>StudentID:</b> 23079398D</td></tr>
    <tr><td><b>The time now is:</b> <%= formattedDate %></td></tr>
</table>

<h2>Books Found:</h2>
<table border="1" cellpadding="5" cellspacing="0">
    <tr>
        <th>ISBN</th><th>Title</th><th>Author</th><th>Edition Number</th><th>Publisher</th><th>Copyright</th><th>Price</th><th>Action</th>
    </tr>
    <% for (Book book : books) { %>
    <tr>
        <td><%= book.getIsbn() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getEditionNumber() %></td>
        <td><%= book.getPublisher() %></td>
        <td><%= book.getCopyright() %></td>
        <td><%= book.getPrice() %></td>
        <td><a href="OrderServlet?isbn=<%= book.getIsbn() %>">Add to Cart</a></td>
    </tr>
    <% } %>
</table>

<br/>
<a href="student-dashboard.jsp">Home</a>
</body>
</html>
