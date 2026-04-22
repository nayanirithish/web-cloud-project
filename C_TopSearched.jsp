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

int rank = 0;
boolean hasData = false;
%>

<!DOCTYPE html>
<html>
<head>
<title>Top Searched Keywords</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{background:#0f2027;color:white;}
.table{background:rgba(255,255,255,0.08);}
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">Top Searched Keywords</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<h3 class="mb-4">Top 10 Most Searched Keywords</h3>

<table class="table table-bordered text-center text-white">
<thead class="table-danger text-dark">
<tr>
<th>Rank</th>
<th>Keyword</th>
<th>Search Count</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT keyword, COUNT(keyword) AS totalCount " +
"FROM search GROUP BY keyword ORDER BY totalCount DESC LIMIT 10");

ResultSet rs = ps.executeQuery();

while(rs.next()){
    hasData = true;
    rank++;
%>

<tr>
<td><%=rank%></td>
<td><%=rs.getString("keyword")%></td>
<td><%=rs.getInt("totalCount")%></td>
</tr>

<%
}

connection.close();

}catch(Exception e){
out.println("<tr><td colspan='3'>Error: "+e.getMessage()+"</td></tr>");
}

if(!hasData){
%>
<tr>
<td colspan="3">No search data available.</td>
</tr>
<% } %>

</tbody>
</table>

<a href="C_Main.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>