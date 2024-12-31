<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%
    String username = request.getParameter("email");
    String password = request.getParameter("password");

    Connection connection = null;
    PreparedStatement selectStatement = null;
    PreparedStatement insertStatement = null;
    ResultSet resultSet = null;

    try {
        // Load Oracle JDBC Driver
       Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Establish connection to Oracle SQL*Plus
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        // Check if the user exists in the REGISTER table
        String selectSql = "SELECT * FROM REGISTER WHERE EMAIL = ? AND PASSWORD = ?";
        selectStatement = connection.prepareStatement(selectSql);
        selectStatement.setString(1, username);
        selectStatement.setString(2, password);

        resultSet = selectStatement.executeQuery();

        if (resultSet.next()) {
            out.println("Login successful..!!!");

            // Insert the login information into the LOGIN table
            String insertSql = "INSERT INTO LOGIN (EMAILID, PASSWORD) VALUES (?, ?)";
            insertStatement = connection.prepareStatement(insertSql);
            insertStatement.setString(1, username);
            insertStatement.setString(2, password);

            int rowsAffected = insertStatement.executeUpdate();
            if (rowsAffected > 0) {
                response.sendRedirect("dashboard.html");
                out.println("Login information stored successfully");
            } else {
                out.println("Failed to store login information");
            }

        } else {
            out.println("Invalid username or password");
        }

    } catch (SQLException e) {
        e.printStackTrace(); 
        out.println("An unexpected SQL error occurred: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace(); 
        out.println("An unexpected error occurred. Please try again later.");
    } finally {
        try {
            if (resultSet != null) {
                resultSet.close();
            }
            if (selectStatement != null) {
                selectStatement.close();
            }
            if (insertStatement != null) {
                insertStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error closing resources: " + e.getMessage());
        }
    }
%>
