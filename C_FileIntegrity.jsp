<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*,java.security.*,java.math.BigInteger,org.bouncycastle.util.encoders.Base64"%>

<!DOCTYPE html>
<html>
<head>
<title>File Integrity Check</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#0f2027,#2c5364);
    color:white;
    font-family:'Poppins',sans-serif;
}
.container-box{
    max-width:700px;
    margin:80px auto;
    background:#1e2a38;
    padding:40px;
    border-radius:20px;
    box-shadow:0 0 30px rgba(0,0,0,0.6);
}
.result-safe{
    background:#1f6f3e;
    padding:15px;
    border-radius:10px;
}
.result-danger{
    background:#7a1f1f;
    padding:15px;
    border-radius:10px;
}
.hash-box{
    background:#111;
    padding:10px;
    border-radius:8px;
    word-break:break-all;
}
</style>
</head>

<body>

<div class="container-box">

<h3 class="text-center mb-4">File Integrity Verification</h3>

<form method="get">
<input type="text" name="fname" class="form-control mb-3" placeholder="Enter File Name" required>
<button class="btn btn-primary w-100">Check Integrity</button>
</form>

<%
String fname = request.getParameter("fname");

/* SHOW RESULT ONLY AFTER CLICK */
if(fname != null && !fname.trim().equals("")){

PreparedStatement ps = connection.prepareStatement(
"SELECT ct,trapdoor FROM cloudserver WHERE fname=?");

ps.setString(1,fname);

ResultSet rs = ps.executeQuery();

if(rs.next()){

String enc = rs.getString("ct");
String dbHash = rs.getString("trapdoor");

// decode Base64
byte[] fileBytes = Base64.decode(enc);

// generate SHA-256
MessageDigest md = MessageDigest.getInstance("SHA1");
byte[] digest = md.digest(fileBytes);

BigInteger bi = new BigInteger(1,digest);
String newHash = bi.toString(16);

/* RESULT DISPLAY */
if(newHash.equals(dbHash)){
%>

<div class="result-safe mt-4">
<h4> File Integrity: VERIFIED</h4>

<p><strong>Status:</strong> File is original and unchanged.</p>

<p><strong>Explanation:</strong></p>
<ul>
<li>Generated hash matches stored hash.</li>
<li>No modification detected after upload.</li>
<li>File integrity is maintained.</li>
</ul>

<p class="text-success"> Safe to download</p>
</div>

<%
}else{
%>

<div class="result-danger mt-4">
<h4>File Integrity: TAMPERED</h4>

<p><strong>Status:</strong> File has been modified after upload.</p>

<p><strong>Reason:</strong></p>
<ul>
<li>Hash mismatch detected.</li>
<li>File content is altered.</li>
</ul>

<p><strong>Possible Causes:</strong></p>
<ul>
<li>Unauthorized access</li>
<li>Data corruption</li>
<li>Malicious modification</li>
</ul>

<p><strong>Original Hash:</strong></p>
<div class="hash-box"><%=dbHash%></div>

<p class="mt-2"><strong>Current Hash:</strong></p>
<div class="hash-box"><%=newHash%></div>

<p class="text-warning mt-3">⚠ Do not trust this file</p>
</div>

<%
}

}else{
%>

<div class="alert alert-warning mt-4">
❌ File not found in server
</div>

<%
}
}
%>

</div>

</body>
</html>