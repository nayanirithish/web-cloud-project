<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Secure File Request</title>

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

<%
String fname = request.getParameter("fname");
%>

<div class="container mt-5">

<h2 class="text-center mb-4">🔐 Secure Download Request</h2>

<div class="row justify-content-center">
<div class="col-md-6">

<div class="card-box">

<form action="DU_Download1.jsp" method="post">

<div class="mb-3">
<label class="form-label">File Name</label>
<input type="text" name="t1" class="form-control" value="<%=fname%>" readonly>
</div>

<div class="mb-3">
<label class="form-label">MAC (Trapdoor)</label>
<input type="text" name="t12" class="form-control" placeholder="Enter MAC">
</div>

<div class="mb-3">
<label class="form-label">Secret Key</label>
<input type="text" name="t13" class="form-control" placeholder="Enter Secret Key">
</div>

<div class="d-grid">
<button type="submit" class="btn btn-premium text-white">
🔓 Proceed to Verification
</button>
</div>

</form>

</div>
</div>
</div>

<div class="text-end mt-4">
<a href="DU_Search.jsp" class="btn btn-outline-light">⬅ Back to Search</a>
</div>

</div>

</body>
</html>