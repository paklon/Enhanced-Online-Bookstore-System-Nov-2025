package bookstore;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DeleteBookServlet")
public class DeleteBookServlet extends HttpServlet {
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
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM BookInfo WHERE ISBN=?");
                stmt.setString(1, isbn);
                stmt.executeUpdate();
                response.sendRedirect("admin-dashboard.jsp");
            }
        } catch (Exception e) {
            response.sendRedirect("admin-dashboard.jsp");
        }
    }
}
