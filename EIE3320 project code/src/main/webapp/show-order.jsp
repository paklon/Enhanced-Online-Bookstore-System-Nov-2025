<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="bookstore.ShoppingCart" %>
<%@ page import="bookstore.Book" %>

<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart == null) {
        cart = new ShoppingCart();
        session.setAttribute("cart", cart);
    }
    ArrayList<Book> items = cart.getItems();

    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String formattedDate = sdf.format(now);

    int itemCount = cart.getItemCount();
%>

<html>
<head><title>Shopping Cart</title></head>
<body>
<table border="0" cellpadding="5" cellspacing="0">
    <tr><td><b>Student Name:</b> Yuen Pak Hei</td></tr>
    <tr><td><b>StudentID:</b> 23079398D</td></tr>
    <tr><td><b>The time now is:</b> <%= formattedDate %></td></tr>
    <tr><td>You have <b><%= itemCount %></b> item(s) in your shopping cart.</td></tr>
</table>

<h2>Your Shopping Cart</h2>

<table border="1" cellpadding="5" cellspacing="0">
    <tr><th>Number of Items</th><th>Title</th><th>Price</th></tr>
    <tr><td><%= itemCount %></td><td colspan="2"></td></tr>
    <% double total = 0; for(Book b : items) { 
        total += b.getPrice(); %>
    <tr>
        <td></td><td><%= b.getTitle() %></td><td><%= b.getPrice() %></td>
    </tr>
    <% } %>
    <tr>
        <td colspan="2">Total</td><td><%= total %></td>
    </tr>
</table>

<br/>
<form action="BookInfo.jsp" method="get" style="display:inline;"><input type="submit" value="Back" /></form>
<form action="check-out.jsp" method="get" style="display:inline;"><input type="submit" value="Check Out" /></form>
<form action="remove-all.jsp" method="post" style="display:inline;"><input type="submit" value="Remove All" /></form>

</body>
</html>
