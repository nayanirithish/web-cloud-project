<title>Authentication Page</title>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*" %>

<%
    String name = request.getParameter("userid");
    String pass = request.getParameter("pass");

    application.setAttribute("uname", name);

    try {

        String sql = "SELECT * FROM user WHERE name=? AND pass=?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setString(1, name);
        ps.setString(2, pass);

        ResultSet rs = ps.executeQuery();

        if (rs.next()) {

            String status = rs.getString("status");

            if ("Authorized".equalsIgnoreCase(status)) {
                response.sendRedirect("DU_Main.jsp");
            } else {
                response.sendRedirect("DU_autho.jsp");
            }

        } else {
            response.sendRedirect("wronglogin.html");
        }

        rs.close();
        ps.close();

    } catch (Exception e) {
        out.println("<h3 style='color:red;'>Error: " + e.getMessage() + "</h3>");
        e.printStackTrace();
    }
%>