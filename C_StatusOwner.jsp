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

int ownerId = 0;

try{
    ownerId = Integer.parseInt(request.getParameter("id"));
}catch(Exception e){
    response.sendRedirect("C_OwnerAutho.jsp");
    return;
}

try{

/* Check if owner exists and is Waiting */
PreparedStatement checkPs = connection.prepareStatement(
"SELECT name,status FROM downer WHERE id=?");

checkPs.setInt(1, ownerId);
ResultSet rs = checkPs.executeQuery();

if(rs.next()){

    String ownerName = rs.getString("name");
    String status = rs.getString("status");

    if(status.equalsIgnoreCase("Waiting")){

        /* Update status securely */
        PreparedStatement updatePs = connection.prepareStatement(
        "UPDATE downer SET status=? WHERE id=?");

        updatePs.setString(1, "Authorized");
        updatePs.setInt(2, ownerId);
        updatePs.executeUpdate();

        /* Audit Log */
        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
        String dt = sdf.format(new Date());

        PreparedStatement logPs = connection.prepareStatement(
        "INSERT INTO transaction(user,fname,task,dt) VALUES(?,?,?,?)");

        logPs.setString(1, csp);
        logPs.setString(2, ownerName);
        logPs.setString(3, "Owner Authorized");
        logPs.setString(4, dt);
        logPs.executeUpdate();
    }
}

connection.close();
response.sendRedirect("C_OwnerAutho.jsp");

}catch(Exception e){
out.println("<h3>Error: "+e.getMessage()+"</h3>");
}
%>