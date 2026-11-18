<%@ page import="java.sql.*" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="bookstore.Book" %>
<%@ page import="bookstore.Book" %>

<%-- Declaration for PurchaseItem helper class --%>
<%! 
public class PurchaseItem {
    private Book book;
    private int quantity;
    public PurchaseItem(Book book, int quantity) {
        this.book = book;
        this.quantity = quantity;
    }
    public Book getBook() { return book; }
    public int getQuantity() { return quantity; }
}
%>

<%
    String role = (String)session.getAttribute("role");
    if(role == null || !role.equals("student")){
        response.sendRedirect("login.jsp");
        return;
    }

    ArrayList<Book> books = (ArrayList<Book>) session.getAttribute("bookList");
    if (books == null) {
        books = new ArrayList<Book>();
    }

    String username = (String) session.getAttribute("username");
    ArrayList<PurchaseItem> purchasedBooks = new ArrayList<>();

    if (username != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/books", "root", "");

            String sql = "SELECT b.ISBN, b.Author, b.Title, b.Price, b.EditionNumber, b.Publisher, b.Copyright, b.availability, SUM(p.Quantity) AS qty " + 
                         "FROM BookInfo b JOIN UserPurchases p ON b.ISBN = p.ISBN " +
                         "JOIN Users u ON p.UserID = u.UserID WHERE u.Username = ? GROUP BY b.ISBN ORDER BY MAX(p.PurchaseDate) DESC";

            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                purchasedBooks.add(new PurchaseItem(
                    new Book(rs.getString("ISBN"), rs.getString("Author"), rs.getString("Title"),
                            rs.getDouble("Price"), rs.getInt("EditionNumber"), rs.getString("Publisher"), rs.getString("Copyright"),
                            rs.getInt("availability")),
                    rs.getInt("qty")
                ));
            }
            rs.close();
            ps.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<html>
<head><title>Student Dashboard</title></head>
<body>
<h2>Welcome Student: <%= session.getAttribute("username") %></h2>
<a href="LogoutServlet">Logout</a>

<h3>Advanced Book Search</h3>
<form action="QueryServlet" method="post">
    ISBN: <input type="text" name="isbn" />
    Author: <input type="text" name="author" />
    Sort by:
    <select name="sortField">
        <option value="title">Title</option>
        <option value="author">Author</option>
        <option value="price">Price</option>
    </select>
    Order:
    <select name="sortOrder">
        <option value="asc">Ascending</option>
        <option value="desc">Descending</option>
    </select>
    <input type="submit" value="Search" />
</form>

<h3>Books Found:</h3>
<table border="1" cellpadding="5">
    <tr><th>ISBN</th><th>Title</th><th>Author</th><th>Price</th><th>Action</th></tr>
    <% for (Book b : books) { %>
    <tr>
        <td><%= b.getIsbn() %></td>
        <td><%= b.getTitle() %></td>
        <td><%= b.getAuthor() %></td>
        <td><%= b.getPrice() %></td>
        <td><a href="OrderServlet?isbn=<%= b.getIsbn() %>">Add to Cart</a></td>
    </tr>
    <% } %>
</table>

<br/>

<h3>Previously Purchased Books</h3>
<table border="1" cellpadding="5">
    <tr><th>ISBN</th><th>Title</th><th>Author</th><th>Price</th><th>Quantity Purchased</th></tr>
    <%
        for (PurchaseItem pi : purchasedBooks) {
            Book book = pi.getBook();
    %>
    <tr>
        <td><%= book.getIsbn() %></td>
        <td><%= book.getTitle() %></td>
        <td><%= book.getAuthor() %></td>
        <td><%= book.getPrice() %></td>
        <td><%= pi.getQuantity() %></td>
    </tr>
    <%
        }
    %>
</table>

<br/>
<a href="show-order.jsp">View Shopping Cart</a>

</body>
</html>
