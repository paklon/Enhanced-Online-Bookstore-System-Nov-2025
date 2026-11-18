<%@ page import="bookstore.ShoppingCart" %>
<%
    String username = (String) session.getAttribute("username");
    String errorMsg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String ccNum = request.getParameter("ccnum");
        if (ccNum == null || ccNum.trim().isEmpty()) {
            errorMsg = "Missing Credit Card Number";
        } else if (!ccNum.matches("\\d+")) {
            errorMsg = "Invalid Credit Card Number";
        } else {
            request.getRequestDispatcher("ReceiptServlet").forward(request, response);
            return;
        }
    }
%>

<html>
<head>
<meta charset="UTF-8">
<title>Check Out</title>
</head>
<body>
<h2>Check Out</h2>
<p>Your total purchase is: 
<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if (cart != null) {
        out.print(cart.getTotalPrice());
    } else {
        out.print("0");
    }
%></p>

<% if (!errorMsg.isEmpty()) { %>
<p style="color:red;"><%= errorMsg %></p>
<% } %>

<form name="checkoutForm" method="post" action="check-out.jsp">
    <!-- Username shown but NOT editable -->
    Name: <b><%= username != null ? username : "" %></b>
    <input type="hidden" name="name" value="<%= username != null ? username : "" %>" />
    <br/><br/>
    Credit Card Number: <input type="text" name="ccnum" value="<%= request.getParameter("ccnum") != null ? request.getParameter("ccnum") : "" %>" />
    <br/><br/>
    <input type="submit" value="Submit Information" />
    <input type="button" value="Cancel" onclick="window.location='show-order.jsp';" />
</form>

</body>
</html>
