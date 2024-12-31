<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.io.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="java.text.*" %>

<%
    Connection connection = null;
    PreparedStatement preparedStatement = null;

    String resultMessage = "";

    try {
        String id = request.getParameter("eid");
        String department = request.getParameter("department");
        String position = request.getParameter("position");
        String startDate = request.getParameter("startDate");

        // Register Oracle JDBC driver
        Class.forName("org.apache.derby.jdbc.ClientDriver");

        // Open a connection to Oracle
        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
        // Create SQL query
        String sql = "INSERT INTO EMPLOYEE (ID, DEPARTMENT, POSITION, STARTDATE) VALUES (?, ?, ?, ?)";
        preparedStatement = connection.prepareStatement(sql);

        preparedStatement.setString(1, id);
        preparedStatement.setString(2, department);
        preparedStatement.setString(3, position);
        preparedStatement.setDate(4, java.sql.Date.valueOf(startDate)); // Convert String to java.sql.Date

        // Execute query
        int rowsAffected = preparedStatement.executeUpdate();

        if (rowsAffected > 0) {
            resultMessage = "Record successfully inserted!";
        } else {
            resultMessage = "Error: Record not inserted.";
        }

    } catch (SQLException e) {
        e.printStackTrace();
        resultMessage = "SQL Error: " + e.getMessage();
    } catch (ClassNotFoundException e) {
        e.printStackTrace();
        resultMessage = "Class Not Found Error: " + e.getMessage();
    } catch (Exception e) {
        e.printStackTrace();
        resultMessage = "General Error: " + e.getMessage();
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

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Information Form</title>
</head>
<body>
    <header>
        <h1>Employee Information Form</h1>
    </header>
    <main>
        <div>
            <p><%= resultMessage %></p>
            <p>Click <a href="employee.html">here</a> to go back.</p>
            <p>Click <a href="viewemployee.jsp"> View the employee details!</a></p>
        </div>
    </main>
</body>
</html>
