<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Attackers</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}

.card-box{
    margin-top:50px;
    background:#1f2a36;
    padding:30px;
    border-radius:20px;
    box-shadow:0 0 25px rgba(255,0,0,0.3);
}

.table{
    background:#2a3b4c;
    color:white;
}

.table th{
    background:#dc3545;
    color:white;
}
</style>

</head>
<body>

<div class="container">
<div class="card-box">

<h3 class="text-center mb-4">Attackers Activity</h3>

<table class="table table-bordered text-center">
<thead>
<tr>
<th>ID</th>
<th>Name</th>
<th>File Name</th>
<th>Mismatched Key</th>
<th>Date & Time</th>
<th>Attack Type</th>
</tr>
</thead>
<tbody>

<%
try{

    Statement st=connection.createStatement();
    ResultSet rs=st.executeQuery("select * from attacker");

    while(rs.next()){
%>
<tr>
<td><%=rs.getInt(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td class="text-danger fw-bold"><%=rs.getString(4)%></td>
<td><%=rs.getString(5)%></td>
<td>
<span class="badge bg-danger">
<%=rs.getString(6)%>
</span>
</td>
</tr>
<%
    }

    connection.close();

}catch(Exception e){
    out.println("<tr><td colspan='6'>"+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

<div class="text-end mt-3">
<a href="DO_Main.jsp" class="btn btn-danger">Back to Dashboard</a>
</div>

</div>
</div>

</body>
</html>