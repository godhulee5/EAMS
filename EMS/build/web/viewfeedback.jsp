<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Details</title>
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <header>
        <h1>Employee Feedback!</h1>
    </header>
    <main>
        <table>
            <tr>
                <th>Employee Name</th>
                <th>Department</th>
                <th>Feedback Type</th>
                <th>Comments</th>
            </tr>
            <tbody>
            <% 
                try {
                    Connection connection = null;
                    Statement statement = null;
                    ResultSet rs = null;

                    Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();

                    connection = DriverManager.getConnection("jdbc:derby://localhost:1527/sample", "app", "app");
                    statement = connection.createStatement();

                    String queryString = "SELECT * FROM FEEDBACK";
                    rs = statement.executeQuery(queryString);

                    while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
                <td><%= rs.getString(4) %></td>
            </tr>
            <%
                    }
                    rs.close();
                    statement.close();
                    connection.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            %>
            </tbody>
        </table>
    </main>
</body>
</html>
