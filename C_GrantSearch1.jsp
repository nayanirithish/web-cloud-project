<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<%
/* CSP Session Validation */
if(session.getAttribute("cspname")==null){
    response.sendRedirect("C_Login.jsp");
    return;
}

int uid = 0;

try{
    uid = Integer.parseInt(request.getParameter("usid"));
}catch(Exception e){
    response.sendRedirect("C_GrantSearch.jsp");
    return;
}

try{

/* Check if request exists and is in Requested state */
PreparedStatement checkPs = connection.prepareStatement(
"SELECT * FROM request WHERE id=? AND SearchPer='Requested'");

checkPs.setInt(1, uid);
ResultSet rs = checkPs.executeQuery();

if(rs.next()){

    /* Grant permission securely */
    PreparedStatement updatePs = connection.prepareStatement(
    "UPDATE request SET SearchPer=? WHERE id=?");

    updatePs.setString(1, "Granted");
    updatePs.setInt(2, uid);
    updatePs.executeUpdate();

    /* Audit log */
    String username = rs.getString("user");

    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
    String dt = sdf.format(new Date());

    PreparedStatement logPs = connection.prepareStatement(
    "INSERT INTO transaction(user,fname,task,dt) VALUES(?,?,?,?)");

    logPs.setString(1, username);
    logPs.setString(2, "-");
    logPs.setString(3, "Search Permission Granted by CSP");
    logPs.setString(4, dt);
    logPs.executeUpdate();
}

/* Redirect back */
response.sendRedirect("C_GrantSearch.jsp");

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>