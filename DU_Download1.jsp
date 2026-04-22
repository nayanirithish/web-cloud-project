<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WebCloud | Secure Download</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#0f2027;
    color:white;
}

.download-card{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

.btn-secure{
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    font-weight:600;
}

.btn-secure:hover{
    transform:scale(1.05);
    transition:0.3s;
}
</style>
</head>

<body>

<div class="container mt-5">

<h2 class="text-center mb-4">🔐 Secure File Download</h2>

<%
try {

    String file = request.getParameter("t1");
    String trapdoor="";
    String sk="";
    String skgenerate="No";

    String query = "SELECT * FROM cloudserver WHERE fname=? AND sk<>?";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.setString(1,file);
    ps.setString(2,skgenerate);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        trapdoor = rs.getString(5);
        sk = rs.getString(6);
%>

<div class="row justify-content-center">
<div class="col-md-6">

<div class="download-card">

<form action="DU_Download2.jsp" method="post">

<div class="mb-3">
<label class="form-label">File Name</label>
<input type="text" name="t1" value="<%=file%>" class="form-control" readonly>
</div>

<div class="mb-3">
<label class="form-label">MAC (Trapdoor)</label>
<input type="text" name="t12" value="<%=trapdoor%>" class="form-control" readonly>
</div>

<div class="mb-3">
<label class="form-label">Secret Key</label>
<input type="text" name="t13" value="<%=sk%>" class="form-control" readonly>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-secure btn-lg">
🔓 Decrypt & Download
</button>
</div>

</form>

</div>
</div>
</div>

<%
    } else {
%>

<div class="alert alert-danger text-center">
❌ File Doesn't Exist or Secret Key Not Generated!
</div>

<%
    }

    rs.close();
    ps.close();
    connection.close();

} catch(Exception e){
    out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

<div class="text-end mt-4">
<a href="DU_Search.jsp" class="btn btn-outline-light">⬅ Back</a>
</div>

</div>

</body>
</html>