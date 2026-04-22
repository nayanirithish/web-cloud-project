<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Authorization Pending | WebCloud</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    font-family: 'Poppins', sans-serif;
}

body{
    margin:0;
    height:100vh;
    background: linear-gradient(-45deg,#141e30,#243b55,#1c92d2,#f2fcfe);
    background-size:400% 400%;
    animation: gradientMove 12s ease infinite;
    display:flex;
    align-items:center;
    justify-content:center;
}

@keyframes gradientMove{
    0%{background-position:0% 50%;}
    50%{background-position:100% 50%;}
    100%{background-position:0% 50%;}
}

.status-card{
    width:600px;
    padding:40px;
    border-radius:20px;
    background:rgba(255,255,255,0.15);
    backdrop-filter:blur(15px);
    box-shadow:0 15px 40px rgba(0,0,0,0.4);
    text-align:center;
    color:white;
}

.icon{
    font-size:70px;
    margin-bottom:20px;
}

.username{
    font-weight:600;
    font-size:20px;
}

.wait-text{
    color:#ff4d4d;
    font-weight:600;
}

.btn-custom{
    margin-top:25px;
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    font-weight:600;
}

.btn-custom:hover{
    transform:scale(1.05);
    transition:0.3s;
}
</style>
</head>

<body>

<div class="status-card">

<div class="icon">⏳</div>

<h2>Authorization Pending</h2>

<p class="username">
Welcome <%=application.getAttribute("uname")%>
</p>

<p>
Your account is currently <span class="wait-text">Not Authorized</span>.
</p>

<p>
Please wait for the <strong>Cloud Service Provider</strong> to approve your access.
</p>

<a href="DU_Login.jsp" class="btn btn-custom btn-lg">
Logout
</a>

</div>

</body>
</html>