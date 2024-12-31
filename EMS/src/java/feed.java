
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Scanner;

@WebServlet(urlPatterns = {"/feed"})
public class feed extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Retrieve form parameters
        String employeeName = request.getParameter("fname");
        String department = request.getParameter("fdepartment");
        String feedbackType = request.getParameter("feedbackType");
        String comments = request.getParameter("comments");

        // Register JDBC driver (assuming MySQL)
        Class.forName("org.apache.derby.jdbc.ClientDriver");

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
        preparedStatement.executeUpdate();

        // Provide a success message (optional)
        System.out.println("Feedback submitted successfully!");

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Provide an error message (optional)
        System.out.println("Error: Unable to submit feedback. Please try again later.");
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
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
