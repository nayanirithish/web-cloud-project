<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* Session validation */
if(session.getAttribute("cspname")==null){
    response.sendRedirect("C_Login.jsp");
    return;
}

int uid = 0;
try{
    uid = Integer.parseInt(request.getParameter("usid"));
}catch(Exception e){
    response.sendRedirect("C_ViewFiles.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | File Details</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#1f4037,#99f2c8);
    font-family:'Poppins',sans-serif;
}
.card-box{
    background:white;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center mb-4 text-dark">📂 File Security Details</h2>

<div class="card-box">

<%
try{

PreparedStatement ps = connection.prepareStatement(
"SELECT * FROM cloudserver WHERE id=?");

ps.setInt(1, uid);
ResultSet rs = ps.executeQuery();

if(rs.next()){

String fileName = rs.getString(2);
String index = rs.getString(3);
String content = rs.getString(4);
String mac = rs.getString(5);
String secretKey = rs.getString(6);
String rank = rs.getString(7);
String dateTime = rs.getString(8);
String owner = rs.getString(9);

/* Mask Secret Key for security */
String maskedKey = "****" + secretKey.substring(Math.max(0, secretKey.length()-4));

%>

<table class="table table-bordered">
<tr><th>ID</th><td><%=uid%></td></tr>
<tr><th>File Name</th><td><%=fileName%></td></tr>
<tr><th>Index</th><td><%=index%></td></tr>
<tr><th>Encrypted Content</th>
<td><textarea class="form-control" rows="6" readonly><%=content%></textarea></td></tr>
<tr><th>MAC (Trapdoor)</th><td><%=mac%></td></tr>
<tr><th>Rank</th><td><%=rank%></td></tr>
<tr><th>Date & Time</th><td><%=dateTime%></td></tr>
<tr><th>Data Owner</th><td><%=owner%></td></tr>
<tr><th>Secret Key</th><td><%=maskedKey%></td></tr>
</table>

<%
}else{
%>
<div class="alert alert-danger">File Not Found</div>
<%
}

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

<div class="text-end">
<a href="C_ViewFiles.jsp" class="btn btn-dark">⬅ Back</a>
</div>

</div>
</div>

</body>
</html>