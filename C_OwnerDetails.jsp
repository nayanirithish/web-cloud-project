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

String ownerName = request.getParameter("name");
if(ownerName == null || ownerName.trim().equals("")){
    response.sendRedirect("C_OwnerAutho.jsp");
    return;
}

int id=0;
String name="", email="", mobile="", address="", dob="";
boolean found=false;

try{

PreparedStatement ps = connection.prepareStatement(
"SELECT id,name,email,mobile,address,dob FROM downer WHERE name=?");

ps.setString(1, ownerName);

ResultSet rs = ps.executeQuery();

if(rs.next()){
    found=true;
    id = rs.getInt("id");
    name = rs.getString("name");
    email = rs.getString("email");
    mobile = rs.getString("mobile");
    address = rs.getString("address");
    dob = rs.getString("dob");
}

connection.close();

}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Owner Details</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<style>
body{background:#0f2027;color:white;}
.card{background:rgba(255,255,255,0.08);}
</style>
</head>

<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">Owner Details</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<% if(found){ %>

<div class="card p-4">

<div class="row">
<div class="col-md-4 text-center">
<img src="ownprofileimage.jsp?imgid=<%=id%>" 
     class="img-fluid rounded"
     style="max-height:250px;">
</div>

<div class="col-md-8">

<table class="table table-bordered text-white">
<tr><th>Name</th><td><%=name%></td></tr>
<tr><th>Email</th><td><%=email%></td></tr>
<tr><th>Mobile</th><td><%=mobile%></td></tr>
<tr><th>Date of Birth</th><td><%=dob%></td></tr>
<tr><th>Address</th><td><%=address%></td></tr>
</table>

</div>
</div>

</div>

<% } else { %>

<div class="alert alert-danger text-center">
Owner not found.
</div>

<% } %>

<a href="C_OwnerAutho.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>