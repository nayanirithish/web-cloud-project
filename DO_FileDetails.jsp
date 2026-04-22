<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>File Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #121212;
    color: white;
}

.details-box {
    max-width: 900px;
    margin: 60px auto;
    background: #1f2a36;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 0 25px rgba(168,85,247,0.5);
}

label {
    font-weight: 600;
}

input, textarea {
    background: #111 !important;
    color: white !important;
    border: 1px solid #444 !important;
}
</style>
</head>

<body>

<div class="details-box">

<h3 class="mb-4">File Details</h3>

<%
String fname=request.getParameter("fname");

try {
    String query="Select * from cloudserver where fname='"+fname+"'";
    Statement st=connection.createStatement();
    ResultSet rs=st.executeQuery(query);

    if(rs.next()) {

        int id=rs.getInt(1);
        String file=rs.getString(2);
        String index=rs.getString(3);
        String content=rs.getString(4);
        String mac=rs.getString(5);
        String rank=rs.getString(7);
        String dt=rs.getString(8);
        String owner=rs.getString(9);
%>

<div class="row mb-3">
<div class="col-md-6">
<label>ID</label>
<input class="form-control" value="<%=id%>" readonly>
</div>

<div class="col-md-6">
<label>File Name</label>
<input class="form-control" value="<%=file%>" readonly>
</div>
</div>

<div class="mb-3">
<label>Encrypted Index</label>
<input class="form-control" value="<%=index%>" readonly>
</div>

<div class="mb-3">
<label>Encrypted Content</label>
<textarea rows="6" class="form-control" readonly><%=content%></textarea>
</div>

<div class="row mb-3">
<div class="col-md-6">
<label>MAC (Trapdoor)</label>
<input class="form-control" value="<%=mac%>" readonly>
</div>

<div class="col-md-3">
<label>Rank</label>
<input class="form-control" value="<%=rank%>" readonly>
</div>

<div class="col-md-3">
<label>Owner</label>
<input class="form-control" value="<%=owner%>" readonly>
</div>
</div>

<div class="mb-3">
<label>Date & Time</label>
<input class="form-control" value="<%=dt%>" readonly>
</div>

<%
    }

    connection.close();
}
catch(Exception e){
    out.println("<div class='alert alert-danger'>"+e.getMessage()+"</div>");
}
%>

<div class="text-end mt-4">
<a href="DO_ViewFiles.jsp" class="btn btn-outline-light btn-sm">Back</a>
</div>

</div>

</body>
</html>