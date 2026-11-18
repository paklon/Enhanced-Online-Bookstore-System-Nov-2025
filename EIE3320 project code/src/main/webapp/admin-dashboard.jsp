<%@ page import="java.util.ArrayList" %>
<%@ page import="bookstore.Book" %>
<%@ page import="java.sql.*" %>
<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("admin")){
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Book> books = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM BookInfo");
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
            books.add(new Book(rs.getString("isbn"), rs.getString("author"), rs.getString("title"),
                               rs.getDouble("price"), rs.getInt("editionNumber"), rs.getString("publisher"), rs.getString("copyright"), rs.getInt("availability")));
        }
        rs.close();
        ps.close();
        conn.close();
    } catch(Exception e){
        e.printStackTrace();
    }
%>
<html>
<head><title>Admin Dashboard</title></head>
<body>
<h2>Welcome Admin: <%= session.getAttribute("username") %></h2>

<a href="UserManagementServlet">User Management</a> |
<a href="LogoutServlet">Logout</a>

<h3>Manage Books</h3>
<table border="1" cellpadding="5">
    <tr>
        <th>ISBN</th>
        <th>Title</th>
        <th>Author</th>
        <th>Edition No</th>
        <th>Publisher</th>
        <th>Copyright</th>
        <th>Price</th>
        <th>Availability</th>
        <th>Actions</th>
    </tr>
    <% for(Book b : books){ %>
    <tr>
        <td><%= b.getIsbn() %></td>
        <td><%= b.getTitle() %></td>
        <td><%= b.getAuthor() %></td>
        <td><%= b.getEditionNumber() %></td>
        <td><%= b.getPublisher() %></td>
        <td><%= b.getCopyright() %></td>
        <td><%= b.getPrice() %></td>
        <td><%= b.getAvailability() %></td>
        <td>
            <a href="EditBookServlet?isbn=<%= b.getIsbn() %>">Edit</a> |
            <a href="DeleteBookServlet?isbn=<%= b.getIsbn() %>" onclick="return confirm('Are you sure?')">Delete</a>
        </td>
    </tr>
    <% } %>
</table>

<br/>
<a href="add-book.jsp">Add New Book</a><br/><br/>

<h3>Sales Report</h3>
<a href="SalesReportServlet">View Sales Report</a>

</body>
</html>
