<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Search Control Request</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:#0f2027;
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
    text-align:center;
}
.btn-premium{
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    font-weight:600;
}
.btn-premium:hover{
    transform:scale(1.05);
    transition:0.3s;
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center mb-4">📩 Request Search Control</h2>

<div class="row justify-content-center">
<div class="col-md-6">

<div class="card-box">

<%
try{

String uname=(String)application.getAttribute("uname");

PreparedStatement ps=connection.prepareStatement(
"SELECT * FROM request WHERE user=?");
ps.setString(1,uname);
ResultSet rs=ps.executeQuery();

if(rs.next()){

    String searchStatus=rs.getString(3);

    if("Requested".equalsIgnoreCase(searchStatus)){
%>

<div class="alert alert-warning">
⏳ Request Already Sent. Please wait for Cloud Service Provider approval.
</div>
<a href="DU_Main.jsp" class="btn btn-outline-dark">Back</a>

<%
    }
    else if("Granted".equalsIgnoreCase(searchStatus)){
%>

<div class="alert alert-success">
✅ Search Control Granted!
</div>

<a href="DU_Search.jsp" class="btn btn-premium text-white">
🔎 Go To Search
</a>

<%
    }

}else{
%>

<form action="DU_SearchReq1.jsp" method="post">
<button type="submit" class="btn btn-premium text-white btn-lg">
🚀 Request Search Access
</button>
</form>

<%
}

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

</div>
</div>
</div>

<div class="text-end mt-4">
<a href="DU_Main.jsp" class="btn btn-outline-light">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>