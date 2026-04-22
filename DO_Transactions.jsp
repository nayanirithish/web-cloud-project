<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Transactions</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}

.main-box{
    margin-top:50px;
}

.table{
    background:#1f2a36;
    color:white;
}

.table th{
    background:#dc3545;
    color:white;
}

.card-box{
    background:#1f2a36;
    padding:25px;
    border-radius:15px;
    box-shadow:0 0 20px rgba(255,0,0,0.3);
}
</style>
</head>

<body>

<div class="container main-box">

<div class="card-box">

<h3 class="text-center mb-4">Transactions On Files</h3>

<table class="table table-bordered text-center">
<thead>
<tr>
<th>ID</th>
<th>User</th>
<th>File Name</th>
<th>Task</th>
<th>Date & Time</th>
</tr>
</thead>
<tbody>

<%
try{

    String dname=(String)application.getAttribute("doname"); 

    String query1="select * from cloudserver where downer='"+dname+"'"; 
    Statement st1=connection.createStatement();
    ResultSet rs1=st1.executeQuery(query1);

    while(rs1.next()){

        String fname=rs1.getString(2);     

        String query="select * from transaction where fname='"+fname+"'"; 
        Statement st=connection.createStatement();
        ResultSet rs=st.executeQuery(query);

        while(rs.next()){
%>
<tr>
<td><%=rs.getInt(1)%></td>
<td><%=rs.getString(2)%></td>
<td><%=rs.getString(3)%></td>
<td>
<% 
String task = rs.getString(4);
if(task.equalsIgnoreCase("Upload")){
%>
<span class="badge bg-success">Upload</span>
<%
}else if(task.equalsIgnoreCase("Delete")){
%>
<span class="badge bg-danger">Delete</span>
<%
}else{
%>
<span class="badge bg-warning text-dark"><%=task%></span>
<%
}
%>
</td>
<td><%=rs.getString(5)%></td>
</tr>
<%
        }
    }

    connection.close();

}catch(Exception e){
    out.println("<tr><td colspan='5'>"+e.getMessage()+"</td></tr>");
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