<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
String uname = (String) session.getAttribute("doname");

if(uname == null){
    response.sendRedirect("DO_Login.jsp");
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Not Authorized</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}

.auth-box{
    max-width:600px;
    margin:120px auto;
    background:#1f2a36;
    padding:50px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 0 25px rgba(255,0,0,0.3);
}
</style>

</head>
<body>

<div class="auth-box">

<h3 class="text-warning mb-4">Account Pending Authorization</h3>

<p class="fs-5">
Welcome <strong><%=uname%></strong>
</p>

<div class="alert alert-danger mt-3">
You are not authorized yet.<br>
Please wait for <strong>Cloud Service Provider</strong> to approve your account.
</div>

<div class="mt-4">
<a href="DO_Login.jsp" class="btn btn-danger">Logout</a>
</div>

</div>

</body>
</html>