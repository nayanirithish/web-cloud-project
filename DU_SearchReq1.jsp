<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Request Sent</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#1d2b64,#f8cdda);
    font-family:'Poppins',sans-serif;
}
.card-box{
    background:white;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.3);
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
<div class="row justify-content-center">
<div class="col-md-6">

<div class="card-box">

<%
try{

String uname=(String)application.getAttribute("uname");

if(uname==null){
    response.sendRedirect("DU_Login.jsp");
    return;
}

// Check if already requested
PreparedStatement checkPs=connection.prepareStatement(
"SELECT SearchPer FROM request WHERE user=?");
checkPs.setString(1,uname);
ResultSet rs=checkPs.executeQuery();

if(rs.next()){
%>

<div class="alert alert-warning">
⏳ Request Already Sent or Processed.
</div>

<a href="DU_SearchReq.jsp" class="btn btn-outline-dark">Back</a>

<%
}else{

PreparedStatement insertPs=connection.prepareStatement(
"INSERT INTO request(user,SearchPer) VALUES(?,?)");
insertPs.setString(1,uname);
insertPs.setString(2,"Requested");
insertPs.executeUpdate();
%>

<div class="alert alert-success">
🚀 Search Control Request Sent Successfully!
</div>

<p>Please wait for Cloud Service Provider approval.</p>

<a href="DU_Main.jsp" class="btn btn-premium text-white">
Back To Dashboard
</a>

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
</div>

</body>
</html>