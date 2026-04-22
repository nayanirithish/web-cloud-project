<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%
session.invalidate();   // Prevent session fixation
%>
<!DOCTYPE html>
<html>
<head>
<title>Cloud Service Provider Login</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body{
    margin:0;
    font-family:'Poppins',sans-serif;
    height:100vh;
    background:linear-gradient(-45deg,#0f2027,#203a43,#2c5364,#1c1c1c);
    background-size:400% 400%;
    animation:gradientMove 10s ease infinite;
    display:flex;
    justify-content:center;
    align-items:center;
}
@keyframes gradientMove{
0%{background-position:0% 50%;}
50%{background-position:100% 50%;}
100%{background-position:0% 50%;}
}
.login-card{
    width:420px;
    padding:45px;
    border-radius:20px;
    background:rgba(255,255,255,0.08);
    backdrop-filter:blur(18px);
    box-shadow:0 0 50px rgba(0,255,255,0.4);
    color:white;
}
.form-control{
    background:transparent;
    border:1px solid rgba(255,255,255,0.3);
    color:white;
}
.form-control:focus{
    border-color:cyan;
    box-shadow:0 0 15px cyan;
}
.btn-login{
    background:linear-gradient(45deg,#00f2fe,cyan);
    border:none;
    border-radius:30px;
    font-weight:600;
}
</style>
</head>

<body>

<div class="login-card">
<h2 class="text-center"><i class="fa-solid fa-cloud-lock"></i> WebCloud Secure</h2>

<%
String error=request.getParameter("error");
if(error!=null){
%>
<div class="alert alert-danger text-center">
Invalid Credentials!
</div>
<% } %>

<form action="C_Authentication.jsp" method="post">

<div class="mb-3">
<label>User ID</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-user"></i></span>
<input type="text" name="userid" class="form-control" required autofocus>
</div>
</div>

<div class="mb-3">
<label>Password</label>
<div class="input-group">
<span class="input-group-text"><i class="fa fa-lock"></i></span>
<input type="password" name="pass" id="password" class="form-control" required>
<span class="input-group-text" onclick="togglePassword()" style="cursor:pointer;">
<i class="fa fa-eye"></i>
</span>
</div>
</div>

<div class="d-grid mt-4">
<button type="submit" class="btn btn-login">Secure Login</button>
</div>

</form>

</div>

<script>
function togglePassword(){
var p=document.getElementById("password");
p.type=(p.type==="password")?"text":"password";
}
</script>

</body>
</html>