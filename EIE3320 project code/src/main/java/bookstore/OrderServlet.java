package bookstore;

import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/OrderServlet")
public class OrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, jakarta.servlet.http.HttpServletResponse response)
            throws jakarta.servlet.ServletException, IOException {
        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart == null) {
            cart = new ShoppingCart();
            session.setAttribute("cart", cart);
        }

        String isbn = request.getParameter("isbn");
        if (isbn != null) {
            ArrayList<Book> bookList = (ArrayList<Book>) session.getAttribute("bookList");
            if (bookList != null) {
                for (Book b : bookList) {
                    if (b.getIsbn().equals(isbn)) {
                        cart.addBook(b);
                        break;
                    }
                }
            }
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("show-order.jsp");
        dispatcher.forward(request, response);
    }
}
