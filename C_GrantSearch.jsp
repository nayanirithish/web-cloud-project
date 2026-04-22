<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* CSP Session Validation */
if(session.getAttribute("cspname")==null){
    response.sendRedirect("C_Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Grant Search Control</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#232526,#414345);
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
<h2 class="text-center mb-4 text-warning">🔐 Search Permission Control Panel</h2>

<div class="card-box">

<table class="table table-bordered table-hover">
<thead class="table-warning">
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
"SELECT * FROM request ORDER BY id DESC");

ResultSet rs = ps.executeQuery();

while(rs.next()){

int id = rs.getInt(1);
String username = rs.getString(2);
String status = rs.getString(3);
%>

<tr>
<td><%=id%></td>

<td class="fw-bold text-primary">
<a href="C_UserSGDetails.jsp?uname=<%=username%>">
<%=username%>
</a>
</td>

<td>
<%
if(status.equalsIgnoreCase("Requested")){
%>
<span class="badge bg-warning text-dark">Requested</span>
<%
}else if(status.equalsIgnoreCase("Granted")){
%>
<span class="badge bg-success">Granted</span>
<%
}else{
%>
<span class="badge bg-secondary"><%=status%></span>
<%
}
%>
</td>

<td>
<%
if(status.equalsIgnoreCase("Requested")){
%>
<a href="C_GrantSearch1.jsp?usid=<%=id%>" 
   class="btn btn-sm btn-success">
Grant Access
</a>
<%
}else{
%>
<span class="text-muted">No Action Needed</span>
<%
}
%>
</td>

</tr>

<%
}

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

</tbody>
</table>

<div class="text-end">
<a href="C_Main.jsp" class="btn btn-dark">⬅ Back</a>
</div>

</div>
</div>

</body>
</html>