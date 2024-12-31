<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String name = request.getParameter("name");
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Load Oracle JDBC Driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish connection to Oracle SQL*Plus
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        // SQL query to insert user into REGISTER table
        String sql = "INSERT INTO REGISTER (NAME, EMAIL, PASSWORD) VALUES (?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);
        preparedStatement.setString(1, name);
        preparedStatement.setString(2, email);
        preparedStatement.setString(3, password);

        // Execute update
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            response.sendRedirect("dashboard.html");
            out.println("Registration successful");
        } else {
            out.println("Failed to register user");
        }

    } catch (SQLException e) {
        out.println("SQL Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("Error loading database driver: " + e.getMessage());
    } finally {
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
