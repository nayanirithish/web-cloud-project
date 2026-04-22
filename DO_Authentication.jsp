<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
String name = request.getParameter("userid");
String pass = request.getParameter("pass");

try{

    // Secure Prepared Statement
    PreparedStatement ps = connection.prepareStatement(
        "SELECT * FROM downer WHERE name=? AND pass=?"
    );

    ps.setString(1, name);
    ps.setString(2, pass);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        // Check authorization
        PreparedStatement ps2 = connection.prepareStatement(
            "SELECT * FROM downer WHERE name=? AND pass=? AND status='Authorized'"
        );

        ps2.setString(1, name);
        ps2.setString(2, pass);

        ResultSet rs1 = ps2.executeQuery();

        if(rs1.next()){

            String uname = rs1.getString("name");

            // Use SESSION (not application)
            session.setAttribute("doname", uname);

            response.sendRedirect("DO_Main.jsp");

        } else {

            response.sendRedirect("DO_autho.jsp");
        }

    } else {

        response.sendRedirect("wronglogin.html");
    }

    connection.close();

}catch(Exception e){
    out.println("<h3 style='color:red;text-align:center;margin-top:100px;'>"+e.getMessage()+"</h3>");
}
%>