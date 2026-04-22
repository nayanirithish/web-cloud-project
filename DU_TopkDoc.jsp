<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Top K Documents</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#1f4037,#99f2c8);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:25px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
.rank-badge{
    font-weight:bold;
    color:#ff6a00;
}
h2{
    font-weight:600;
}
</style>
</head>

<body>

<div class="container mt-5">

<h2 class="text-center mb-4">🏆 Top K Ranked Documents</h2>

<div class="card-box">

<table class="table table-bordered table-hover text-center">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>File Name</th>
<th>Rank</th>
</tr>
</thead>
<tbody>

<%
try{

String uname=(String)application.getAttribute("uname");
if(uname==null){
    response.sendRedirect("DU_Login.jsp");
    return;
}

/* ✅ FIXED QUERY (NO ERROR) */
PreparedStatement ps = connection.prepareStatement(
"SELECT id,fname,rank FROM cloudserver ORDER BY rank DESC LIMIT 5");

ResultSet rs = ps.executeQuery();

while(rs.next()){
%>

<tr>
<td><%=rs.getInt("id")%></td>
<td><%=rs.getString("fname")%></td>
<td class="rank-badge"><%=rs.getInt("rank")%></td>
</tr>

<%
}

connection.close();

}catch(Exception e){
out.println("<tr><td colspan='3'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

</div>

<div class="text-end mt-3">
<a href="DU_Main.jsp" class="btn btn-dark">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>