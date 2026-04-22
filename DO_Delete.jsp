<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*"%>
<%@ include file="connect.jsp" %>
<%@page import ="java.security.Key,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>Delete Files</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #121212;
    color: white;
    font-family: Arial;
}

.container-box {
    max-width: 1000px;
    margin: 60px auto;
    background: #1f2a36;
    padding: 40px;
    border-radius: 20px;
    box-shadow: 0 0 25px rgba(255,0,0,0.4);
}

.table thead {
    background: #dc3545;
    color: white;
}

.btn-delete {
    background: #dc3545;
    border: none;
}

.btn-delete:hover {
    background: #b02a37;
}
</style>
</head>

<body>

<div class="container-box">

<h3 class="mb-4">Delete Uploaded Files</h3>

<table class="table table-bordered table-hover text-center text-white">
<thead>
<tr>
<th>ID</th>
<th>File Name</th>
<th>Uploaded Date</th>
<th>Action</th>
</tr>
</thead>
<tbody>

<%
String dname=(String)application.getAttribute("doname");

try {

    String query="Select * from cloudserver where downer='"+dname+"'";
    Statement st=connection.createStatement();
    ResultSet rs=st.executeQuery(query);

    while(rs.next()) {

        int id=rs.getInt(1);
        String fname=rs.getString(2);
        String encodedDate=rs.getString(8);

        String keys = "ef50a0ef2c3e3a5f";
        byte[] keyValue = keys.getBytes();
        Key key = new SecretKeySpec(keyValue, "AES");
        Cipher c = Cipher.getInstance("AES");
        c.init(Cipher.DECRYPT_MODE, key);

        String dt1 = new String(Base64.decode(encodedDate.getBytes()));
%>

<tr>
<td><%=id%></td>
<td>
<a href="DO_FileDets.jsp?fname=<%=fname%>" class="text-warning">
<%=fname%>
</a>
</td>
<td><%=dt1%></td>
<td>
<a href="DO_Delete1.jsp?usid=<%=id%>&fname=<%=fname%>"
class="btn btn-delete btn-sm text-white">
Delete
</a>
</td>
</tr>

<%
    }

    connection.close();

} catch(Exception e){
    out.println("<tr><td colspan='4'>"+e.getMessage()+"</td></tr>");
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