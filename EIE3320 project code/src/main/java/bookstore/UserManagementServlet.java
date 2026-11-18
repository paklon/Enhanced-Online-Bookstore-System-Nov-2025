package bookstore;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserManagementServlet")
public class UserManagementServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<User> users = new ArrayList<>();
        try {
            Class.forName(JDBC_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);
            PreparedStatement stmt = conn.prepareStatement("SELECT UserID, Username, Role FROM Users");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                User u = new User(rs.getInt("UserID"), rs.getString("Username"), rs.getString("Role"));
                users.add(u);
            }
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("userList", users);
        RequestDispatcher dispatcher = request.getRequestDispatcher("user-management.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            Class.forName(JDBC_DRIVER);
            Connection conn = DriverManager.getConnection(DB_URL, USER, PASS);

            if ("add".equalsIgnoreCase(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String role = request.getParameter("role");
                String sql = "INSERT INTO Users (Username, Password, Role) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                stmt.setString(2, password);
                stmt.setString(3, role);
                stmt.executeUpdate();
                stmt.close();
            } else if ("delete".equalsIgnoreCase(action)) {
                int userId = Integer.parseInt(request.getParameter("userid"));
                String sql = "DELETE FROM Users WHERE UserID = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);
                stmt.executeUpdate();
                stmt.close();
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        response.sendRedirect("UserManagementServlet");
    }
}
