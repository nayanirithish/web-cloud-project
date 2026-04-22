<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* SESSION VALIDATION */
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}

boolean hasData = false;
%>

<!DOCTYPE html>
<html>
<head>
<title>Authorize Users</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#0f2027;
    color:white;
}
.table{
    background:rgba(255,255,255,0.08);
}
</style>

</head>
<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">User Authorization Panel</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<h3 class="mb-4">Registered Users</h3>

<table class="table table-bordered text-center text-white">
<thead class="table-primary text-dark">
<tr>
<th>ID</th>
<th>User Name</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT id, name, status FROM user ORDER BY id DESC");

ResultSet rs = ps.executeQuery();

while(rs.next()){
    hasData = true;
%>

<tr>
<td><%=rs.getInt("id")%></td>

<td>
<a href="C_UserDetails.jsp?name=<%=rs.getString("name")%>" 
class="text-warning text-decoration-none">
<%=rs.getString("name")%>
</a>
</td>

<td>
<%
String status = rs.getString("status");

if(status.equalsIgnoreCase("Waiting")){
%>
<span class="badge bg-warning text-dark">Waiting</span>
<%
}else{
%>
<span class="badge bg-success">Authorized</span>
<%
}
%>
</td>

<td>
<%
if(status.equalsIgnoreCase("Waiting")){
%>
<a href="C_StatusUser.jsp?id=<%=rs.getInt("id")%>" 
class="btn btn-sm btn-success">
Authorize
</a>
<%
}else{
%>
<span class="text-success">✔ Approved</span>
<%
}
%>
</td>

</tr>

<%
}

connection.close();

}catch(Exception e){
out.println("<tr><td colspan='4'>Error: "+e.getMessage()+"</td></tr>");
}

if(!hasData){
%>
<tr>
<td colspan="4">No users available.</td>
</tr>
<% } %>

</tbody>
</table>

<a href="C_Main.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>