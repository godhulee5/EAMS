package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import java.sql.*;
import java.io.PrintWriter;

public final class feed_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent {

  private static final JspFactory _jspxFactory = JspFactory.getDefaultFactory();

  private static java.util.List<String> _jspx_dependants;

  private org.glassfish.jsp.api.ResourceInjector _jspx_resourceInjector;

  public java.util.List<String> getDependants() {
    return _jspx_dependants;
  }

  public void _jspService(HttpServletRequest request, HttpServletResponse response)
        throws java.io.IOException, ServletException {

    PageContext pageContext = null;
    HttpSession session = null;
    ServletContext application = null;
    ServletConfig config = null;
    JspWriter out = null;
    Object page = this;
    JspWriter _jspx_out = null;
    PageContext _jspx_page_context = null;

    try {
      response.setContentType("text/html;charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;
      _jspx_resourceInjector = (org.glassfish.jsp.api.ResourceInjector) application.getAttribute("com.sun.appserv.jsp.resource.injector");

      out.write("\n");
      out.write("\n");
      out.write("\n");
      out.write("\n");

    Connection connection = null;
    PreparedStatement preparedStatement = null;

    try {
        // Retrieve form parameters
        String employeeName = request.getParameter("fname");
        String department = request.getParameter("fdepartment");
        String feedbackType = request.getParameter("feedbackType");
        String comments = request.getParameter("comments");

        // Register Oracle JDBC driver
        Class.forName("oracle.jdbc.driver.OracleDriver");

        // Open a connection to Oracle
        connection = DriverManager.getConnection("jdbc:oracle:thin:@192.168.1.40:1521:xe", "system", "dbms123");

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

        // Provide a success message
        out.println("Feedback submitted successfully!");

    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        // Provide an error message
        out.println("Error: Unable to submit feedback. Please try again later.");
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

      out.write('\n');
    } catch (Throwable t) {
      if (!(t instanceof SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          out.clearBuffer();
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}
