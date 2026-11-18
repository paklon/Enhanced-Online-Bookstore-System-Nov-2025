package bookstore;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/AddBookServlet")
public class AddBookServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("add-book.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String isbn = request.getParameter("isbn");
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            int editionNumber = Integer.parseInt(request.getParameter("editionNumber"));
            String publisher = request.getParameter("publisher");
            String copyright = request.getParameter("copyright");
            double price = Double.parseDouble(request.getParameter("price"));

            Class.forName(JDBC_DRIVER);
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                String sql = "INSERT INTO BookInfo (ISBN, Title, Author, EditionNumber, Publisher, Copyright, Price, availability) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, isbn);
                stmt.setString(2, title);
                stmt.setString(3, author);
                stmt.setInt(4, editionNumber);
                stmt.setString(5, publisher);
                stmt.setString(6, copyright);
                stmt.setDouble(7, price);
                stmt.setInt(8, 100);  // set default availability to 100
                stmt.executeUpdate();

                response.sendRedirect("admin-dashboard.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Error adding book: " + e.getMessage());
            request.getRequestDispatcher("add-book.jsp").forward(request, response);
        }
    }
}
