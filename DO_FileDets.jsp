<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>File Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}

.card-box{
    max-width:900px;
    margin:60px auto;
    background:#1f2a36;
    padding:40px;
    border-radius:20px;
    box-shadow:0 0 25px rgba(255,0,0,0.3);
}

label{
    font-weight:bold;
}

input, textarea{
    background:#2a3b4c !important;
    color:white !important;
    border:none !important;
}

textarea{
    resize:none;
}
</style>

</head>
<body>

<div class="card-box">

<h3 class="text-center mb-4">File Details</h3>

<%
String fname=request.getParameter("fname");

try{

    String query="Select * from cloudserver where fname='"+fname+"'";
    Statement st=connection.createStatement();
    ResultSet rs=st.executeQuery(query);

    if(rs.next()){
%>

<div class="row mb-3">
<div class="col-md-3"><label>ID</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getInt(1)%>" readonly>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>File Name</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(2)%>" readonly>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>Index</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(3)%>" readonly>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>Contents</label></div>
<div class="col-md-9">
<textarea rows="6" class="form-control" readonly><%=rs.getString(4)%></textarea>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>MAC</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(5)%>" readonly>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>Rank</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(7)%>" readonly>
</div>
</div>

<div class="row mb-3">
<div class="col-md-3"><label>Date & Time</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(8)%>" readonly>
</div>
</div>

<div class="row mb-4">
<div class="col-md-3"><label>Data Owner</label></div>
<div class="col-md-9">
<input type="text" class="form-control" value="<%=rs.getString(9)%>" readonly>
</div>
</div>

<%
    }

    connection.close();

}catch(Exception e){
    out.println("<div class='alert alert-danger'>"+e.getMessage()+"</div>");
}
%>

<div class="text-end">
<a href="DO_Delete.jsp" class="btn btn-danger">Back</a>
<a href="DO_Main.jsp" class="btn btn-outline-light ms-2">Dashboard</a>
</div>

</div>

</body>
</html>