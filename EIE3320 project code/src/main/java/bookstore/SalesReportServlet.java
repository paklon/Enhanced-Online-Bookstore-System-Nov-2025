package bookstore;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SalesReportServlet")
public class SalesReportServlet extends HttpServlet {
    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost:3306/books";
    private static final String USER = "root";
    private static final String PASS = "";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Class.forName(JDBC_DRIVER);
            try (Connection conn = DriverManager.getConnection(DB_URL, USER, PASS)) {
                String sql = "SELECT B.Title, SUM(S.Quantity) AS TotalSold, SUM(S.Quantity*B.Price) AS TotalRevenue "
                        + "FROM Sales S JOIN BookInfo B ON S.ISBN = B.ISBN GROUP BY B.Title";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                response.setContentType("text/html;charset=UTF-8");
                var out = response.getWriter();
                out.println("<html><head><title>Sales Report</title></head><body>");
                out.println("<h2>Sales Report</h2>");
                out.println("<table border='1'><tr><th>Title</th><th>Total Sold</th><th>Total Revenue</th></tr>");
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("Title") + "</td><td>" + rs.getInt("TotalSold") + "</td><td>" + rs.getDouble("TotalRevenue") + "</td></tr>");
                }
                out.println("</table><br/><a href='admin-dashboard.jsp'>Back to Admin Dashboard</a>");
                out.println("</body></html>");

                rs.close();
                stmt.close();
            }
        } catch (Exception e) {
            response.getWriter().println("Database error: " + e.getMessage());
        }
    }
}
