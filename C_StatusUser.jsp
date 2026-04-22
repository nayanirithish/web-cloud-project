<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<%
/* SESSION VALIDATION */
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}

int userId = 0;

try{
    userId = Integer.parseInt(request.getParameter("id"));
}catch(Exception e){
    response.sendRedirect("C_UserAutho.jsp");
    return;
}

try{

/* Check if user exists */
PreparedStatement checkPs = connection.prepareStatement(
"SELECT name,status FROM user WHERE id=?");

checkPs.setInt(1, userId);
ResultSet rs = checkPs.executeQuery();

if(rs.next()){

    String userName = rs.getString("name");
    String status = rs.getString("status");

    if(status.equalsIgnoreCase("Waiting")){

        /* Secure Update */
        PreparedStatement updatePs = connection.prepareStatement(
        "UPDATE user SET status=? WHERE id=?");

        updatePs.setString(1, "Authorized");
        updatePs.setInt(2, userId);
        updatePs.executeUpdate();

        /* Audit Logging */
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String dt = sdf.format(new Date());

        PreparedStatement logPs = connection.prepareStatement(
        "INSERT INTO transaction(user,fname,task,dt) VALUES(?,?,?,?)");

        logPs.setString(1, csp);
        logPs.setString(2, userName);
        logPs.setString(3, "User Authorized");
        logPs.setString(4, dt);
        logPs.executeUpdate();
    }
}

connection.close();
response.sendRedirect("C_UserAutho.jsp");

}catch(Exception e){
out.println("<h3>Error: "+e.getMessage()+"</h3>");
}
%>