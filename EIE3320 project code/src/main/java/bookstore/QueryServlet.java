package bookstore;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/QueryServlet")
public class QueryServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String isbn = request.getParameter("isbn");
        String author = request.getParameter("author");

        // For advanced search sorting and filtering
        String sortField = request.getParameter("sortField"); // price or author
        String sortOrder = request.getParameter("sortOrder"); // asc or desc

        ArrayList<Book> books = new ArrayList<>();

        try {
            Class.forName(JDBC_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            String sql = "SELECT * FROM BookInfo WHERE 1=1";
            if (isbn != null && !isbn.trim().isEmpty()) {
                sql += " AND isbn=?";
            }
            if (author != null && !author.trim().isEmpty()) {
                sql += " AND author LIKE ?";
            }
            if ("price".equalsIgnoreCase(sortField) || "author".equalsIgnoreCase(sortField)) {
                sql += " ORDER BY " + sortField + ("desc".equalsIgnoreCase(sortOrder) ? " DESC" : " ASC");
            } else {
                sql += " ORDER BY title ASC";
            }

            PreparedStatement stmt = conn.prepareStatement(sql);
            int index = 1;
            if (isbn != null && !isbn.trim().isEmpty()) {
                stmt.setString(index++, isbn.trim());
            }
            if (author != null && !author.trim().isEmpty()) {
                stmt.setString(index++, "%" + author.trim() + "%");
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(new Book(rs.getString("isbn"), rs.getString("author"),
                        rs.getString("title"), rs.getDouble("price"),
                        rs.getInt("editionNumber"), rs.getString("publisher"),
                        rs.getString("copyright"),rs.getInt("availability")));
            }
            rs.close();
            stmt.close();
            conn.close();

            HttpSession session = request.getSession();
            session.setAttribute("bookList", books);

            RequestDispatcher dispatcher = request.getRequestDispatcher("BookInfo.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
