<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<title>File Audit Trail</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#0f2027,#2c5364);
    color:white;
    font-family:'Poppins',sans-serif;
}
.container-box{
    max-width:900px;
    margin:60px auto;
    background:#1e2a38;
    padding:30px;
    border-radius:20px;
}
.log-box{
    background:#0f1722;
    padding:15px;
    margin-bottom:10px;
    border-radius:10px;
    border-left:5px solid #00c6ff;
}
.time{
    font-size:12px;
    color:#aaa;
}
</style>
</head>

<body>

<div class="container-box">

<h3 class="text-center mb-4">📜 File Audit Trail</h3>

<form method="get" class="mb-4">
<input type="text" name="fname" class="form-control mb-2" placeholder="Enter File Name" required>
<button class="btn btn-info w-100">View History</button>
</form>

<%
String fname = request.getParameter("fname");

if(fname != null && !fname.trim().equals("")){

PreparedStatement ps = connection.prepareStatement(
"SELECT user,task,dt FROM transaction WHERE fname=? ORDER BY dt DESC");

ps.setString(1,fname);

ResultSet rs = ps.executeQuery();

boolean found = false;

while(rs.next()){
found = true;

String user = rs.getString("user");
String task = rs.getString("task");
String dt = rs.getString("dt");
%>

<div class="log-box">
<b><%=user%></b> → <%=task%>
<div class="time">🕒 <%=dt%></div>
</div>

<%
}

if(!found){
%>

<div class="alert alert-warning mt-3">
❌ No activity found for this file
</div>

<%
}

connection.close();
}
%>

</div>

</body>
</html>