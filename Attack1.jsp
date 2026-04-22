<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Attack Simulation</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#000000,#434343);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center mb-4 text-danger">🚨 Attack Simulation Panel</h2>

<div class="card-box">

<%
try{

String file = request.getParameter("t1");
String attackerName = request.getParameter("ot");

if(file==null || attackerName==null){
    out.println("<div class='alert alert-danger'>Invalid Request</div>");
    return;
}

PreparedStatement ps = connection.prepareStatement(
"SELECT fname,ct,trapdoor,sk FROM cloudserver WHERE fname=?");

ps.setString(1,file);
ResultSet rs = ps.executeQuery();

if(rs.next()){

String fname = rs.getString("fname");
String content = rs.getString("ct");

%>

<div class="alert alert-warning text-center">
⚠ You are attempting to modify encrypted cloud content.
</div>

<form action="Attack2.jsp" method="post">

<div class="mb-3">
<label class="form-label">File Name</label>
<input type="text" name="t1" class="form-control" value="<%=fname%>" readonly>
</div>

<div class="mb-3">
<label class="form-label">Attacker Name</label>
<input type="text" name="t12" class="form-control" value="<%=attackerName%>" readonly>
</div>

<div class="mb-3">
<label class="form-label">Encrypted File Content</label>
<textarea name="text" class="form-control" rows="10"><%=content%></textarea>
</div>

<div class="text-center">
<button type="submit" class="btn btn-danger btn-lg">
🔥 Perform Attack
</button>
</div>

</form>

<%
}else{
%>

<div class="alert alert-danger text-center">
❌ File Doesn't Exist!
</div>

<%
}

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

</div>

<div class="text-end mt-3">
<a href="attack.jsp" class="btn btn-outline-light">⬅ Back</a>
</div>

</div>

</body>
</html>