<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Attendance</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 15px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>View Attendance</h2>
        <TABLE>
            <thead>
                <tr>
                    <th>Employee ID</th>
                    <th>Attendance Status</th>
                    <th>Attendance Date</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    try {
                        Connection connection = null;
                        Statement statement = null;
                        ResultSet rs = null;

                        Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();

                        connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
                        statement = connection.createStatement();

                        String queryString = "SELECT * FROM ATTENDANCE";
                        rs = statement.executeQuery(queryString);

                        while (rs.next()) {
                %>
                            <tr>
                                <td><%= rs.getInt(1) %></td>
                                <td><%= rs.getString(2) %></td>
                                <td><%= rs.getDate(3) %></td>
                            </tr>
                <%
                        }
                        rs.close();
                        statement.close();
                        connection.close();
                    } catch (Exception ex) {
                %>
                        <tr>
                            <td colspan="3">Unable to connect to the database.</td>
                        </tr>
                <%
                    }
                %>
            </tbody>
        </TABLE>
        <div>
            <FORM ACTION="markattendance.jsp" method="get">
            </FORM>
        </div>
    </div>
</body>
</html>
