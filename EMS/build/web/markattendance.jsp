<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mark Attendance Process</title>
</head>
<body>
    <%
        String employeeId = request.getParameter("employeeId");
        String attendanceStatus = request.getParameter("attendanceStatus");
        String attendanceDate = request.getParameter("attendanceDate");

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            // Register Oracle JDBC driver
            Class.forName("org.apache.derby.jdbc.ClientDriver");
            // Open a connection to Oracle
            connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");

            // Create SQL query
            String sql = "INSERT INTO ATTENDANCE (EMPLOYEEID, ATTENDANCESTATUS, ATTENDANCEDATE) VALUES (?, ?, ?)";
            preparedStatement = connection.prepareStatement(sql);

            // Set parameters
            preparedStatement.setString(1, employeeId);
            preparedStatement.setString(2, attendanceStatus);
            preparedStatement.setDate(3, java.sql.Date.valueOf(attendanceDate));

            // Execute query
            int rowsAffected = preparedStatement.executeUpdate();

            if (rowsAffected > 0) {
                response.sendRedirect("markattendancesuccess.jsp");
            } else {
                out.println("Error: Failed to mark attendance.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("SQL Error: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("Class Not Found Error: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            out.println("General Error: " + e.getMessage());
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
</body>
</html>
