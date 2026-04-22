<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Attack Monitor</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#141e30,#243b55);
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

<h2 class="text-center text-danger mb-4">🚨 Cloud Security - Attack Monitor</h2>

<div class="card-box">

<table class="table table-bordered table-hover">
<thead class="table-danger">
<tr>
<th>ID</th>
<th>Attacker Name</th>
<th>File Name</th>
<th>Corrupted Key</th>
<th>Date & Time</th>
<th>Attack Type</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT * FROM attacker ORDER BY id DESC");

ResultSet rs = ps.executeQuery();

int totalAttacks = 0;

while(rs.next()){
totalAttacks++;
%>

<tr>
<td><%=rs.getInt(1)%></td>
<td class="text-danger fw-bold"><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>
<td class="text-danger"><%=rs.getString(6)%></td>
</tr>

<%
}
connection.close();
%>

</tbody>
</table>

<hr>

<div class="alert alert-warning text-center">
Total Recorded Attacks: <strong><%=totalAttacks%></strong>
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