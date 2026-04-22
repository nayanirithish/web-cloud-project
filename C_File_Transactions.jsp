<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* Session validation */
if(session.getAttribute("cspname")==null){
    response.sendRedirect("C_Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | File Transaction Monitor</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#000428,#004e92);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center mb-4 text-warning">📊 Cloud File Transactions Monitor</h2>

<div class="card-box">

<table class="table table-bordered table-hover">
<thead class="table-warning">
<tr>
<th>ID</th>
<th>User Name</th>
<th>File Name</th>
<th>Task</th>
<th>Date & Time</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT * FROM transaction ORDER BY id DESC");

ResultSet rs = ps.executeQuery();
int total = 0;

while(rs.next()){
total++;
%>

<tr>
<td><%=rs.getInt(1)%></td>
<td class="fw-bold text-primary"><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td>
<%
String task = rs.getString(4);
if(task.equalsIgnoreCase("Download")){
%>
<span class="badge bg-success"><%=task%></span>
<%
}else if(task.equalsIgnoreCase("Search")){
%>
<span class="badge bg-info"><%=task%></span>
<%
}else{
%>
<span class="badge bg-secondary"><%=task%></span>
<%
}
%>
</td>
<td><%=rs.getString(5)%></td>
</tr>

<%
}
connection.close();
%>

</tbody>
</table>

<hr>

<div class="alert alert-dark text-center">
Total Transactions Recorded: <strong><%=total%></strong>
</div>

<%
}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

<div class="text-end">
<a href="C_Main.jsp" class="btn btn-dark">⬅ Back</a>
</div>

</div>
</div>

</body>
</html>