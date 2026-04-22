<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
String username = request.getParameter("userid");
String password = request.getParameter("pass");

if(username == null || password == null){
response.sendRedirect("C_Login.jsp?error=1");
return;
}

try {

PreparedStatement ps = connection.prepareStatement(
"SELECT * FROM cloud WHERE name=? AND pass=?");

ps.setString(1, username.trim());
ps.setString(2, password.trim());

ResultSet rs = ps.executeQuery();

if(rs.next()){
session.setAttribute("cspname", username);
response.sendRedirect("C_Main.jsp");
} else {
response.sendRedirect("C_Login.jsp?error=1");
}

connection.close();

} catch(Exception e){
out.println("Error: " + e.getMessage());
}
%>
