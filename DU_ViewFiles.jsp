<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*,javax.crypto.*,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | View Files</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#0f2027,#203a43,#2c5364);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:25px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
</style>
</head>

<body>

<div class="container mt-5">

<h2 class="text-center mb-4">📂 Available Cloud Files</h2>

<div class="card-box">

<table class="table table-bordered table-hover text-center">

<thead class="table-dark">
<tr>
<th>ID</th>
<th>File Name</th>
<th>Data Owner</th>
<th>Uploaded Date</th>
</tr>
</thead>

<tbody>

<%
try{

String uname=(String)application.getAttribute("uname");

if(uname==null){
    response.sendRedirect("DU_Login.jsp");
    return;
}

/* Correct Query */
PreparedStatement ps = connection.prepareStatement(
"SELECT id,fname,dt,downer FROM cloudserver ORDER BY id DESC");

ResultSet rs = ps.executeQuery();

String keys="ef50a0ef2c3e3a5f";

byte[] keyValue = keys.getBytes();
SecretKeySpec key = new SecretKeySpec(keyValue,"AES");

Cipher cipher = Cipher.getInstance("AES");
cipher.init(Cipher.DECRYPT_MODE,key);

while(rs.next()){

String encryptedDate = rs.getString("dt");

/* Decode Date */
String decryptedDate = new String(Base64.decode(encryptedDate.getBytes()));

%>

<tr>

<td><%=rs.getInt("id")%></td>

<td><%=rs.getString("fname")%></td>

<td><%=rs.getString("downer")%></td>

<td><%=decryptedDate%></td>

</tr>

<%
}

connection.close();

}catch(Exception e){

out.println("<tr><td colspan='4'>Error : "+e.getMessage()+"</td></tr>");

}
%>

</tbody>

</table>

</div>

<div class="text-end mt-3">
<a href="DU_Main.jsp" class="btn btn-outline-light">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>