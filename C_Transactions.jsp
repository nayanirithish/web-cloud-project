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
int serial = 0;
%>

<!DOCTYPE html>
<html>
<head>
<title>Keyword Transactions</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{background:#0f2027;color:white;}
.table{background:rgba(255,255,255,0.08);}
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">Keyword Search Transactions</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<h3 class="mb-4">Search Activity Log</h3>

<table class="table table-bordered text-center text-white">
<thead class="table-warning text-dark">
<tr>
<th>#</th>
<th>User Name</th>
<th>Keyword</th>
<th>Date & Time</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT user, keyword, dt FROM search ORDER BY dt DESC LIMIT 100");

ResultSet rs = ps.executeQuery();

while(rs.next()){
    hasData = true;
    serial++;
%>

<tr>
<td><%=serial%></td>
<td><%=rs.getString("user")%></td>
<td><%=rs.getString("keyword")%></td>
<td><%=rs.getString("dt")%></td>
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
<td colspan="4">No search transactions available.</td>
</tr>
<% } %>

</tbody>
</table>

<a href="C_Main.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>