<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*"%>
<%@ include file="connect.jsp" %>
<%@page import ="java.security.Key,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>My Uploaded Files</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #121212;
    color: white;
}

.table-container {
    max-width: 1000px;
    margin: 60px auto;
    background: #1f2a36;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 0 25px rgba(168,85,247,0.5);
}

.table {
    color: white;
}

.table thead {
    background: linear-gradient(45deg,#a855f7,#6d28d9);
}

.btn-view {
    background: #a855f7;
    border: none;
}

.btn-view:hover {
    background: #6d28d9;
}
</style>
</head>

<body>

<div class="table-container">

<h3 class="mb-4">My Uploaded Files</h3>

<table class="table table-bordered table-hover text-center">
<thead>
<tr>
<th>ID</th>
<th>File Name</th>
<th>Owner</th>
<th>Date & Time</th>
<th>Action</th>
</tr>
</thead>
<tbody>

<%
String dname=(String)application.getAttribute("doname");

try {

    String query1="Select * from cloudserver where downer='"+dname+"'";
    Statement st=connection.createStatement();
    ResultSet rs1=st.executeQuery(query1);

    while(rs1.next()) {

        int i=rs1.getInt(1);
        String fname=rs1.getString(2);
        String encodedDate=rs1.getString(8);
        String owner=rs1.getString(9);

        String keys = "ef50a0ef2c3e3a5f";
        byte[] keyValue = keys.getBytes();
        Key key = new SecretKeySpec(keyValue, "AES");
        Cipher c = Cipher.getInstance("AES");
        c.init(Cipher.DECRYPT_MODE, key);

        String dt1 = new String(Base64.decode(encodedDate.getBytes()));
%>

<tr>
<td><%=i%></td>
<td><%=fname%></td>
<td><%=owner%></td>
<td><%=dt1%></td>
<td>
<a href="DO_FileDetails.jsp?fname=<%=fname%>" 
class="btn btn-view btn-sm text-white">
View Details
</a>
</td>
</tr>

<%
    }

    connection.close();
}
catch(Exception e){
    out.println("<tr><td colspan='5'>"+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

<div class="text-end mt-3">
<a href="DO_Main.jsp" class="btn btn-outline-light btn-sm">Back</a>
</div>

</div>

</body>
</html>