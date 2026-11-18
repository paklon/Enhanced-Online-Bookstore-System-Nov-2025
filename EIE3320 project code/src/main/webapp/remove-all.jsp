<%@ page import="bookstore.ShoppingCart" %>
<%
    ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");
    if(cart != null){
        cart.removeAll();
    }
    response.sendRedirect("show-order.jsp");
%>
