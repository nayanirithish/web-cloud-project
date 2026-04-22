<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Secure Search</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:#0f2027;
    color:white;
    font-family:'Poppins',sans-serif;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
.btn-search{
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    font-weight:600;
}
.btn-search:hover{
    transform:scale(1.05);
    transition:0.3s;
}
</style>
</head>

<body>

<div class="container mt-5">

<h2 class="text-center mb-4">🔎 Secure Multi-Keyword Search</h2>

<%
String user = (String)application.getAttribute("uname");

try {

    String query = "SELECT * FROM request WHERE user=?";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.setString(1,user);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        String searchPermission = rs.getString(3);

        if("Granted".equalsIgnoreCase(searchPermission)){
%>

<div class="row justify-content-center">
<div class="col-md-6">
<div class="card-box">

<form method="post" action="DU_Search1.jsp">

<div class="mb-3">
<label class="form-label">Enter Multi Keywords</label>
<input type="text" name="t14" class="form-control"
placeholder="Example: cloud security encryption"
required>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-search text-white">
🔍 Search Data
</button>
</div>

</form>

</div>
</div>
</div>

<%
        } else {
%>

<div class="alert alert-warning text-center">
⚠ Search Control Not Granted by Cloud Service Provider.
</div>

<div class="text-center">
<a href="DU_Main.jsp" class="btn btn-outline-light">⬅ Back</a>
</div>

<%
        }

    } else {
%>

<div class="alert alert-danger text-center">
❌ You Have Not Requested Search Control.
</div>

<div class="text-center">
<a href="DU_SearchReq.jsp" class="btn btn-search text-white">
📩 Request Search Access
</a>
</div>

<%
    }

    connection.close();

} catch(Exception e){
    out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

<div class="text-end mt-4">
<a href="DU_Main.jsp" class="btn btn-outline-light">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>