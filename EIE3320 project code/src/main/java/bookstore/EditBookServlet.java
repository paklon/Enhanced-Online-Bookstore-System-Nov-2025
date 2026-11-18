package bookstore;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/EditBookServlet")
public class EditBookServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        try {
            Class.forName(JDBC_DRIVER);
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM BookInfo WHERE ISBN=?");
                stmt.setString(1, isbn);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    Book book = new Book(rs.getString("isbn"), rs.getString("author"), rs.getString("title"),
                            rs.getDouble("price"), rs.getInt("editionNumber"), rs.getString("publisher"), rs.getString("copyright"),rs.getInt("availability"));
                    request.setAttribute("book", book);
                    RequestDispatcher rd = request.getRequestDispatcher("edit-book.jsp");
                    rd.forward(request, response);
                } else {
                    response.sendRedirect("admin-dashboard.jsp");
                }
                rs.close();
                stmt.close();
            }
        } catch (Exception e) {
            response.sendRedirect("admin-dashboard.jsp");
        }
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
                PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE BookInfo SET Title=?, Author=?, EditionNumber=?, Publisher=?, Copyright=?, Price=? WHERE ISBN=?");
                stmt.setString(1, title);
                stmt.setString(2, author);
                stmt.setInt(3, editionNumber);
                stmt.setString(4, publisher);
                stmt.setString(5, copyright);
                stmt.setDouble(6, price);
                stmt.setString(7, isbn);
                stmt.executeUpdate();

                response.sendRedirect("admin-dashboard.jsp");
            }
        } catch (Exception e) {
            request.setAttribute("errorMsg", "Error updating book: " + e.getMessage());
            request.getRequestDispatcher("edit-book.jsp").forward(request, response);
        }
    }
}
