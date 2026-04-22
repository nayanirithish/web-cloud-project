<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*,java.security.*,java.math.BigInteger,org.bouncycastle.util.encoders.Base64"%>
<%@ page import="java.sql.*,java.io.*,javax.servlet.http.Part"%>
<%@ include file="connect.jsp" %>

<!DOCTYPE html>
<html>
<head>
<title>Encryption Preview</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}
.container-box{
    max-width:800px;
    margin:60px auto;
    background:#1e2a38;
    padding:30px;
    border-radius:15px;
}
input{
    background:#0f1722 !important;
    color:white !important;
}
</style>
</head>

<body>

<div class="container-box">

<h3 class="mb-4">🔐 Encryption Preview</h3>

<form action="DO_Upload2.jsp" method="post">

<%
try{

// ✅ GET FILE FROM upload.jsp
Part filePart = request.getPart("file");

// META DATA
String file = request.getParameter("filename");
String index = request.getParameter("indexname");

// READ FILE AS BYTES (supports ALL file types)
InputStream is = filePart.getInputStream();
ByteArrayOutputStream buffer = new ByteArrayOutputStream();

byte[] data = new byte[8192];
int n;
while ((n = is.read(data)) != -1) {
    buffer.write(data, 0, n);
}

byte[] fileBytes = buffer.toByteArray();

// ❗ EMPTY CHECK
if(fileBytes.length == 0){
%>
<div class="alert alert-danger">
⚠ File is empty. Please upload again.
</div>
<%
return;
}

// ❗ DUPLICATE CHECK
PreparedStatement ps = connection.prepareStatement(
"SELECT * FROM cloudserver WHERE fname=?");
ps.setString(1,file);
ResultSet rs = ps.executeQuery();

if(rs.next()){
%>
<div class="alert alert-danger">
❌ File already exists!
</div>
<%
}else{

String encContent = new String(Base64.encode(fileBytes));
String encIndex = new String(Base64.encode(index.getBytes()));

// 🔐 MAC (SHA1)
MessageDigest md = MessageDigest.getInstance("SHA1");
byte[] digest = md.digest(fileBytes);
BigInteger bi = new BigInteger(1,digest);
String mac = bi.toString(16);

// ✅ STORE LARGE DATA IN SESSION (IMPORTANT FIX)
session.setAttribute("fileContent", encContent);

%>

<div class="mb-3">
<label>File Name</label>
<input class="form-control" value="<%=file%>" readonly>
</div>

<div class="mb-3">
<label>Encrypted Index</label>
<input class="form-control" value="<%=encIndex%>" readonly>
</div>

<div class="mb-3">
<label>MAC (SHA1)</label>
<input class="form-control" value="<%=mac%>" readonly>
</div>

<!-- ✅ ONLY SMALL DATA PASSED -->
<input type="hidden" name="fname" value="<%=file%>">
<input type="hidden" name="index" value="<%=encIndex%>">
<input type="hidden" name="mac" value="<%=mac%>">

<div class="d-grid mt-3">
<button type="submit" class="btn btn-success">
⬆ Upload to Cloud
</button>
</div>

<%
}

connection.close();

}catch(Exception e){
out.println("<div class='alert alert-danger'>Error: "+e.getMessage()+"</div>");
}
%>

</form>

</div>

</body>
</html>