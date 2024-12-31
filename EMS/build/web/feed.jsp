<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.PrintWriter" %>

<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    String employeeName = request.getParameter("fname");
    String department = request.getParameter("fdepartment");
    String feedbackType = request.getParameter("feedbackType");
    String comments = request.getParameter("comments");

    try {
        // Register Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Open a connection to Oracle
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

        // Create SQL query
        String sql = "INSERT INTO FEEDBACK (EMPLOYEENAME, FDEPARTMENT, FEEDBACKTYPE, COMMENTS) VALUES (?, ?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);

        // Set parameters
        preparedStatement.setString(1, employeeName);
        preparedStatement.setString(2, department);
        preparedStatement.setString(3, feedbackType);
        preparedStatement.setString(4, comments);

        // Execute query
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            out.println("Feedback submitted successfully!");
        } else {
            out.println("Error: Feedback not submitted.");
        }

    } catch (SQLException e) {
        e.printStackTrace();
        out.println("SQL Error: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        out.println("Class Not Found Error: " + e.getMessage());
    } catch (Exception e) {
        e.printStackTrace();
        out.println("Error: " + e.getMessage());
    } finally {
        // Close JDBC objects
        try {
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
