<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* SESSION VALIDATION */
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}

String uname = request.getParameter("uname");

boolean found = false;
int uid = 0;
String name="", email="", mobile="", address="", dob="", status="";

try{

PreparedStatement ps = connection.prepareStatement(
"SELECT id,name,email,mobile,address,dob,status FROM user WHERE name=?");

ps.setString(1, uname);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    found = true;
    uid = rs.getInt("id");
    name = rs.getString("name");
    email = rs.getString("email");
    mobile = rs.getString("mobile");
    address = rs.getString("address");
    dob = rs.getString("dob");
    status = rs.getString("status");
}

connection.close();

}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>User Details (Search Grant)</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#0f2027;
    color:white;
}
.card{
    background:rgba(255,255,255,0.08);
}
</style>

</head>
<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">User Profile (Search Permission)</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<%
if(found){
%>

<div class="card p-4">

<div class="row">
<div class="col-md-4 text-center">
<img src="profileimage.jsp?imgid=<%=uid%>" 
class="img-fluid rounded" 
style="max-height:250px;">
</div>

<div class="col-md-8">

<h4><%=name%></h4>
<hr>

<p><b>Email:</b> <%=email%></p>
<p><b>Mobile:</b> <%=mobile%></p>
<p><b>Date of Birth:</b> <%=dob%></p>
<p><b>Address:</b> <%=address%></p>

<p><b>Status:</b> 
<%
if(status.equalsIgnoreCase("Authorized")){
%>
<span class="badge bg-success">Authorized</span>
<%
}else{
%>
<span class="badge bg-warning text-dark">Waiting</span>
<%
}
%>
</p>

</div>
</div>

</div>

<%
}else{
%>

<div class="alert alert-danger">
User not found.
</div>

<%
}
%>

<a href="C_GrantSearch.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>