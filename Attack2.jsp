<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date,java.security.MessageDigest,java.math.BigInteger,org.bouncycastle.util.encoders.Base64"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Attack Executed</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#20002c,#cbb4d4);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.5);
    text-align:center;
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center text-danger mb-4">🚨 Malicious Data Attack Executed</h2>

<div class="card-box">

<%
try{

String file = request.getParameter("t1");
String attacker = request.getParameter("t12");
String modifiedContent = request.getParameter("text");

if(file==null || attacker==null || modifiedContent==null){
    out.println("<div class='alert alert-danger'>Invalid Request</div>");
    return;
}

/* Create new fake trapdoor using SHA1 */
MessageDigest md = MessageDigest.getInstance("SHA1");
md.update(modifiedContent.getBytes());
BigInteger hash = new BigInteger(1, md.digest());
String fakeTrapdoor = hash.toString(16);

/* Fake secret key */
String fakeSK = "CORRUPTED_KEY";

/* Encrypt modified content */
String encryptedValue = new String(Base64.encode(modifiedContent.getBytes()));

/* Update cloudserver safely */
PreparedStatement updatePs = connection.prepareStatement(
"UPDATE cloudserver SET ct=?, trapdoor=?, sk=? WHERE fname=?");

updatePs.setString(1, encryptedValue);
updatePs.setString(2, fakeTrapdoor);
updatePs.setString(3, fakeSK);
updatePs.setString(4, file);

updatePs.executeUpdate();

/* Log attack */
SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
String dt = sdfDate.format(new Date());

PreparedStatement logPs = connection.prepareStatement(
"INSERT INTO attacker(user,fname,sk,dt,attacktype) VALUES(?,?,?,?,?)");

logPs.setString(1, attacker);
logPs.setString(2, file);
logPs.setString(3, fakeSK);
logPs.setString(4, dt);
logPs.setString(5, "Malicious Data Tampering");

logPs.executeUpdate();

connection.close();
%>

<div class="alert alert-danger">
🔥 File Successfully Tampered!
</div>

<p>
Attack has been logged in the system.<br>
Trapdoor and Secret Key have been corrupted.
</p>

<%
}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

<br>
<a href="attack.jsp" class="btn btn-outline-dark">Back</a>

</div>
</div>

</body>
</html>