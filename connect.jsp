<%@ page import="java.sql.*"%>
<%
Connection connection = null;

try {

    // MySQL 5 Driver
    Class.forName("com.mysql.jdbc.Driver");

    connection = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/webcloud",
        "root",
        "root"
    );

    if(connection != null){
        out.println("Database Connected Successfully");
    }

} catch(Exception e) {
    out.println("Database Connection Failed: " + e);
}
%>