<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*"%>
<%@ include file="connect.jsp" %>
<%@page import ="java.security.Key,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<title>PKG - View Files</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #121212;
    margin: 0;
    color: white;
}

.sidebar {
    height: 100vh;
    background: #1c1c1c;
    padding-top: 20px;
    position: fixed;
    width: 250px;
}

.sidebar h4 {
    color: orange;
    text-align: center;
    margin-bottom: 30px;
}

.sidebar a {
    color: #ccc;
    padding: 12px 20px;
    display: block;
    text-decoration: none;
}

.sidebar a:hover {
    background: orange;
    color: black;
}

.content {
    margin-left: 250px;
    padding: 40px;
}

.table thead {
    background: orange;
    color: black;
}

.btn-generate {
    background: orange;
    border: none;
    font-weight: 600;
}

.btn-generate:hover {
    background: #ff9800;
}
</style>

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4><i class="fa fa-key"></i> PKG Module</h4>
    <a href="PKG_Main.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="PKG_Login.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Content -->
<div class="content">

<h2 class="mb-4">View Files & Generate Key</h2>

<div class="table-responsive">
<table class="table table-dark table-hover table-bordered text-center align-middle">

<thead>
<tr>
<th>ID</th>
<th>File Name</th>
<th>Index Name</th>
<th>Date & Time</th>
<th>Data Owner</th>
<th>Secret Key</th>
</tr>
</thead>

<tbody>

<%
String s1="",s2="",s3="",s4="",s5="";
int i=0;

try {
    String query1="Select * from cloudserver";
    Statement st=connection.createStatement();
    ResultSet rs1=st.executeQuery(query1);

    while(rs1.next()==true)
    {
        i=rs1.getInt(1);
        s1=rs1.getString(2);
        s2=rs1.getString(3);
        s5=rs1.getString(6);
        s3=rs1.getString(8);
        s4=rs1.getString(9);

        String keys = "ef50a0ef2c3e3a5f";
        byte[] keyValue = keys.getBytes();
        Key key = new SecretKeySpec(keyValue, "AES");
        Cipher c = Cipher.getInstance("AES");
        c.init(Cipher.DECRYPT_MODE, key);
        String dt1 = new String(Base64.decode(s3.getBytes()));
%>

<tr>
<td><%=i%></td>
<td><%=s1%></td>
<td><%=s2%></td>
<td><%=dt1%></td>
<td><%=s4%></td>

<%
if(s5.equalsIgnoreCase("No")) {
%>
<td>
<a href="PKG_Genkey1.jsp?fid=<%=i%>&fname=<%=s1%>&owner=<%=s4%>" 
   class="btn btn-generate btn-sm text-dark">
   Generate Key
</a>
</td>
<%
} else {
%>
<td><strong><%=s5%></strong></td>
<%
}
%>

</tr>

<%
    }
    connection.close();
}
catch(Exception e){
    out.println(e.getMessage());
}
%>

</tbody>
</table>
</div>

<a href="PKG_Main.jsp" class="btn btn-outline-light mt-3">Back</a>

</div>

</body>
</html>