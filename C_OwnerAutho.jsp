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
%>

<!DOCTYPE html>
<html>
<head>
<title>Authorize Owners</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{background:#0f2027;color:white;}
.table{background:rgba(255,255,255,0.08);}
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">Owner Authorization Panel</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<h3 class="mb-4">Authorize Data Owners</h3>

<table class="table table-bordered text-white text-center">
<thead class="table-warning text-dark">
<tr>
<th>Owner ID</th>
<th>Owner Name</th>
<th>Status</th>
<th>Action</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement("SELECT id,name,status FROM downer");
ResultSet rs = ps.executeQuery();

while(rs.next()){

int id = rs.getInt("id");
String name = rs.getString("name");
String status = rs.getString("status");
%>

<tr>
<td><%=id%></td>
<td><a href="C_OwnerDetails.jsp?name=<%=name%>" class="text-info"><%=name%></a></td>
<td>
<% if(status.equalsIgnoreCase("Waiting")){ %>
<span class="badge bg-warning text-dark">Waiting</span>
<% } else { %>
<span class="badge bg-success">Authorized</span>
<% } %>
</td>

<td>
<% if(status.equalsIgnoreCase("Waiting")){ %>
<a href="C_StatusOwner.jsp?id=<%=id%>" class="btn btn-sm btn-success">
Authorize
</a>
<% } else { %>
-
<% } %>
</td>
</tr>

<%
}

connection.close();

}catch(Exception e){
out.println("<tr><td colspan='4'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

<a href="C_Main.jsp" class="btn btn-secondary">Back</a>

</div>

</body>
</html>