<%@ page import="java.util.ArrayList" %>
<%@ page import="bookstore.User" %>

<%
    ArrayList<User> users = (ArrayList<User>) request.getAttribute("userList");
%>

<html>
<head><title>User Management</title></head>
<body>
<h2>User Account Management</h2>
<a href="admin-dashboard.jsp">Back to Admin Dashboard</a> | <a href="LogoutServlet">Logout</a>

<h3>Add New User</h3>
<form method="post" action="UserManagementServlet">
    <input type="hidden" name="action" value="add" />
    Username: <input type="text" name="username" required />
    Password: <input type="password" name="password" required />
    Role:
    <select name="role">
        <option value="student">Student</option>
        <option value="admin">Admin</option>
    </select>
    <input type="submit" value="Add User" />
</form>

<h3>Existing Users</h3>
<table border="1" cellpadding="5">
    <tr><th>UserID</th><th>Username</th><th>Role</th><th>Action</th></tr>
    <% for (User user : users) { %>
    <tr>
        <td><%= user.getUserId() %></td>
        <td><%= user.getUsername() %></td>
        <td><%= user.getRole() %></td>
        <td>
            <form method="post" action="UserManagementServlet" style="display:inline;">
                <input type="hidden" name="action" value="delete" />
                <input type="hidden" name="userid" value="<%= user.getUserId() %>" />
                <input type="submit" value="Delete" onclick="return confirm('Delete user <%= user.getUsername() %>?');" />
            </form>
        </td>
    </tr>
    <% } %>
</table>
</body>
</html>
