package bookstore;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.util.ArrayList;

@WebServlet("/ReceiptServlet")
public class ReceiptServlet extends HttpServlet {

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");

        HttpSession session = request.getSession();
        ShoppingCart cart = (ShoppingCart) session.getAttribute("cart");

        if (cart != null) {
            ArrayList<Book> items = cart.getItems();

            try {
                Class.forName(JDBC_DRIVER);
                try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                    conn.setAutoCommit(false);  

                    String getUserIdSql = "SELECT UserID FROM Users WHERE Username = ?";
                    PreparedStatement userIdStmt = conn.prepareStatement(getUserIdSql);
                    userIdStmt.setString(1, (String) session.getAttribute("username"));
                    ResultSet userRs = userIdStmt.executeQuery();
                    int userId = -1;
                    if (userRs.next()) {
                        userId = userRs.getInt("UserID");
                    }
                    userRs.close();
                    userIdStmt.close();

                    if (userId == -1) {
                        response.getWriter().println("<html><body><h2>User not found.</h2></body></html>");
                        return;
                    }

                    String insertSaleSql = "INSERT INTO Sales (ISBN, Quantity, SaleDate) VALUES (?, ?, CURRENT_TIMESTAMP)";
                    String updateAvailSql = "UPDATE BookInfo SET availability = availability - 1 WHERE ISBN = ? AND availability > 0";
                    String insertPurchaseSql = "INSERT INTO UserPurchases (UserID, ISBN, Quantity) VALUES (?, ?, ?)";

                    PreparedStatement insertSaleStmt = conn.prepareStatement(insertSaleSql);
                    PreparedStatement updateAvailStmt = conn.prepareStatement(updateAvailSql);
                    PreparedStatement insertPurchaseStmt = conn.prepareStatement(insertPurchaseSql);

                    boolean allUpdated = true;

                    for (Book book : items) {
                        insertSaleStmt.setString(1, book.getIsbn());
                        insertSaleStmt.setInt(2, 1);
                        insertSaleStmt.executeUpdate();

                        updateAvailStmt.setString(1, book.getIsbn());
                        int updatedRows = updateAvailStmt.executeUpdate();
                        if (updatedRows == 0) {
                            allUpdated = false; 
                            break;
                        }

                        insertPurchaseStmt.setInt(1, userId);
                        insertPurchaseStmt.setString(2, book.getIsbn());
                        insertPurchaseStmt.setInt(3, 1);
                        insertPurchaseStmt.executeUpdate();
                    }

                    if (allUpdated) {
                        conn.commit();
                        cart.removeAll();
                    } else {
                        conn.rollback();
                        response.getWriter().println("<html><body><h2>Purchase failed: One or more books are out of stock.</h2><a href='student-dashboard.jsp'>Back to Dashboard</a></body></html>");
                        return;
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("<html><body><h2>Purchase failed due to error: " + e.getMessage() + "</h2></body></html>");
                return;
            }
        }

        response.setContentType("text/html");
        response.getWriter().println("<html><head>");
        response.getWriter().println("<title>Receipt</title>");
        response.getWriter().println("<meta http-equiv='refresh' content='5;URL=student-dashboard.jsp'>");
        response.getWriter().println("</head><body>");
        response.getWriter().println("<h2>Thank you for your purchase</h2>");
        response.getWriter().println("<p>Dear " + name + ", thanks for purchasing books from BookStore</p>");
        response.getWriter().println("<p>This page will automatically go back to Student Dashboard after 5 seconds.</p>");
        response.getWriter().println("</body></html>");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
