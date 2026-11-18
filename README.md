# 📚 Enhanced Online Bookstore System

A robust, enterprise-grade multi-tier Java Web Application built upon the **Model-View-Controller (MVC)** architectural pattern. This project represents an advanced evolution from a core e-commerce book-searching and purchasing platform into a fully secured, role-based bookstore management ecosystem complete with administrative controls, advanced search sorting, and sales reporting.

---

## 📌 Project Overview & Evolution

The development process began with a foundational transaction platform enabling users to search database catalogs dynamically by ISBN or author, manage session-based shopping carts, and execute checkout flows. Building upon this base, the system was expanded into a comprehensive management application featuring:
* **Role-Based Access Control (RBAC):** Distinct authentication and portals separating regular **Students** from **Administrators**.
* **Advanced Search & Sorting:** Expanded search parameters with multi-column sorting capabilities (by Title, Price, etc.).
* **Administrative Oversight:** Full backend capabilities for inventory manipulation (add, edit, delete books), user account management, and real-time sales reporting.

---

## 🚀 Tech Stack & Architecture
* **Frontend:** HTML5, CSS3, JSP (JavaServer Pages)
* **Backend:** Java Servlets, Jakarta EE, JDBC (Java Database Connectivity)
* **Database:** MySQL Server (Relational Database Management System)
* **Server Container:** Apache Tomcat (v8.0+)
* **Design Pattern:** **MVC (Model-View-Controller)**

---

## 🏛️ MVC Implementation Details
* **Model (`Book.java`, `User.java`, `ShoppingCart.java`)**: Encapsulates core business logic and entities. `Book` and `User` map directly to relational database tables, while `ShoppingCart` manages state tracking for selected items and total cost computations.
* **Controller (`LoginServlet`, `QueryServlet`, `OrderServlet`, `AddBookServlet`, `EditBookServlet`, `DeleteBookServlet`, `UserManagementServlet`, `SalesReportServlet`)**: Servlets intercepting HTTP requests, handling business logic via JDBC, maintaining user sessions, and routing data to views.
* **View (`login.jsp`, `student-dashboard.jsp`, `admin-dashboard.jsp`, `BookInfo.jsp`, `show-order.jsp`, `check-out.jsp`, `user-management.jsp`)**: JSP pages responsible for rendering dynamic server data and capturing user input.

---

## 🌟 Key Features & Application Workflow

### 🎓 Student Portal
* **Advanced Search & Catalog Sorting:** Search inventories by ISBN or Author with options to sort results dynamically by title or price in ascending/descending order.
* **Session-Based Shopping Cart:** Add multiple books, inspect itemized totals, clear cart items, and execute secure checkouts.
* **Purchase History Tracking:** Automatically tracks and displays previously purchased books for logged-in user accounts.

### 🛠️ Admin Portal
* **Inventory Management:** Full CRUD operations to add new books, edit existing attributes, or remove books from the system database.
* **User Account Oversight:** Directory management allowing administrators to add new user profiles and delete existing accounts.
* **Sales Analytics & Reporting:** Dedicated sales report generation computing total sold units and cumulative revenue per book title.

---

## ⚙️ Quick Installation & Setup Guide

### 1. Prerequisites
* **Java Development Kit (JDK):** Version 8 or above
* **Apache Tomcat:** Version 9 or compatible servlet container
* **MySQL Server:** Version 5.7+ or 8.x
* **IDE:** Eclipse IDE for Enterprise Java or IntelliJ IDEA
* **JDBC Driver:** MySQL JDBC Connector (`Connector/J` .jar file) added to your project build path

### 2. Set Up the Database
1. Open your MySQL client or command prompt and log in as root:
   mysql -h localhost -u root
2. Create and initialize the database schema using the provided SQL dump script (books.sql):
CREATE DATABASE books;
USE books;
SOURCE C:/project/sql/books.sql;
3. Alternatively, restore data from a backup script (books_backup.sql):
   mysql -u root -p books < path/to/books_backup.sql

### 3. Configure Your Project
1. Clone or copy this repository into your local workspace and import it into your Java IDE as a dynamic web project.   
2. Ensure src/main/java/bookstore contains all model and servlet classes, and src/main/webapp/ contains your JSP views.   
3. Verify that database connection configurations inside your servlet files point correctly to your local MySQL instance (jdbc:mysql://localhost:3306/books, root user/password).

 ### 4. Deploying and Running the Project 
1. Build / compile the project as a WAR or copy the web app folder into Tomcat’s `webapps` directory.  Example folder: `EnhancedBookstore/` (containing `WEB-INF`, JSP files, etc.) 
2. Start Tomcat: On Windows: run `bin/startup.bat` from your Tomcat folder. 
3. Open your browser and visit: 
* If deployed as root app: `http://localhost:8080/` 
* If deployed as `EnhancedBookstore`: `http://localhost:8080/EnhancedBookstore/login.jsp` 
4. Log in using the default credentials below.

### Default User Accounts 
* The following users are pre-created in `books.sql`: 
1. Admin: 
* Username: `admin` - Password: `admin`
2. Students: 
- Username: `student1` - Password: `student1` 
- Username: `student2` - Password: `student2` 

### Normal Usage 
1. Admin login 
- Log in as `admin/admin`. 
- Access Admin Dashboard to: 
* Add / edit / delete books. 
* Manage user accounts. 
* View sales reports and inventory. 

2. Student login 
- Log in as `student1/student1` or `student2/student2`. 
- Use Student Dashboard to: 
* Browse and advanced-search books. 
* Add books to cart and checkout. 
* View previously purchased books.
