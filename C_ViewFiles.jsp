<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>

<%
/* SESSION VALIDATION */
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<title>View Files - CSP</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#0f2027;
    color:white;
}
.table{
    background:rgba(255,255,255,0.05);
}
</style>

</head>
<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">Cloud File Repository</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<h4 class="mb-3">All Uploaded Files</h4>

<input type="text" id="searchInput" class="form-control mb-3" placeholder="Search file name...">

<div class="table-responsive">
<table class="table table-bordered table-hover text-white" id="fileTable">
<thead class="table-warning text-dark">
<tr>
<th>ID</th>
<th>File Name</th>
<th>Index Name</th>
<th>Date & Time</th>
<th>Data Owner</th>
</tr>
</thead>
<tbody>

<%
try{

PreparedStatement ps = connection.prepareStatement("SELECT * FROM cloudserver");
ResultSet rs = ps.executeQuery();

while(rs.next()){

int id = rs.getInt(1);
String fname = rs.getString(2);
String index = rs.getString(3);
String encDate = rs.getString(8);
String owner = rs.getString(9);

/* AES Decrypt */
String decryptedDate = "";
try{
String keyStr = "ef50a0ef2c3e3a5f";
SecretKeySpec key = new SecretKeySpec(keyStr.getBytes(), "AES");
Cipher cipher = Cipher.getInstance("AES");
cipher.init(Cipher.DECRYPT_MODE, key);
decryptedDate = new String(Base64.decode(encDate.getBytes()));
}catch(Exception ex){
decryptedDate = "Invalid Data";
}
%>

<tr>
<td><%=id%></td>
<td><a href="C_FileDetails.jsp?usid=<%=id%>" class="text-info"><%=fname%></a></td>
<td><%=index%></td>
<td><%=decryptedDate%></td>
<td><%=owner%></td>
</tr>

<%
}
connection.close();
}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

</tbody>
</table>
</div>

<a href="C_Main.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

<script>
document.getElementById("searchInput").addEventListener("keyup", function() {
    let filter = this.value.toLowerCase();
    let rows = document.querySelectorAll("#fileTable tbody tr");
    rows.forEach(row => {
        let text = row.innerText.toLowerCase();
        row.style.display = text.includes(filter) ? "" : "none";
    });
});
</script>

</body>
</html>