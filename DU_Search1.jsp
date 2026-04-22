<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date,
javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,
org.bouncycastle.util.encoders.Base64" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Search Results</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#0f2027;
    color:white;
    font-family:Poppins, sans-serif;
}
.table-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:20px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
</style>
</head>
<body>

<div class="container mt-5">
<h2 class="text-center mb-4">🔎 Search Results</h2>

<div class="table-box">

<table class="table table-bordered table-hover text-center">
<thead class="table-dark">
<tr>
<th>ID</th>
<th>File Name</th>
<th>Index Name</th>
<th>Rank</th>
<th>Download</th>
</tr>
</thead>
<tbody>

<%
try{

String user = (String)application.getAttribute("uname");
String keyword = request.getParameter("t14");

String dt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

/* Insert Transaction */
PreparedStatement trans = connection.prepareStatement(
"INSERT INTO transaction(user,fname,task,dt) VALUES(?,?,?,?)");
trans.setString(1,user);
trans.setString(2,keyword);
trans.setString(3,"Search");
trans.setString(4,dt);
trans.executeUpdate();

/* Insert Search */
PreparedStatement searchLog = connection.prepareStatement(
"INSERT INTO search(user,keyword,dt) VALUES(?,?,?)");
searchLog.setString(1,user);
searchLog.setString(2,keyword);
searchLog.setString(3,dt);
searchLog.executeUpdate();

/* Fetch All Files */
PreparedStatement ps = connection.prepareStatement("SELECT * FROM cloudserver");
ResultSet rs = ps.executeQuery();

int total=0;
int found=0;

String aesKey="ef50a0ef2c3e3a5f";
SecretKeySpec keySpec=new SecretKeySpec(aesKey.getBytes(),"AES");
Cipher cipher=Cipher.getInstance("AES");

while(rs.next()){

    total++;

    int id=rs.getInt(1);
    String fname=rs.getString(2);
    String encIndex=rs.getString(3);
    String encDesc=rs.getString(4);
    int rank=rs.getInt(7);

    cipher.init(Cipher.DECRYPT_MODE,keySpec);
    String decryptedIndex=new String(Base64.decode(encIndex.getBytes()));
    String decryptedDesc=new String(Base64.decode(encDesc.getBytes()));

    if(decryptedIndex.toLowerCase().contains(keyword.toLowerCase()) ||
       decryptedDesc.toLowerCase().contains(keyword.toLowerCase()) ||
       fname.toLowerCase().contains(keyword.toLowerCase())){

        found++;

        /* Update Rank */
        PreparedStatement updateRank=connection.prepareStatement(
        "UPDATE cloudserver SET rank=? WHERE fname=?");
        updateRank.setInt(1,rank+1);
        updateRank.setString(2,fname);
        updateRank.executeUpdate();

        /* Insert Search History */
        PreparedStatement history=connection.prepareStatement(
        "INSERT INTO searchhistory(user,keyword,fname,dt) VALUES(?,?,?,?)");
        history.setString(1,user);
        history.setString(2,keyword);
        history.setString(3,fname);
        history.setString(4,dt);
        history.executeUpdate();
%>

<tr>
<td><%=id%></td>
<td><%=fname%></td>
<td><%=decryptedIndex%></td>
<td><%=rank%></td>
<td>
<a href="DU_DownloadSearch.jsp?fname=<%=fname%>" 
class="btn btn-sm btn-primary">Download</a>
</td>
</tr>

<%
    }
}

/* Insert Search Ratio */
PreparedStatement ratio=connection.prepareStatement(
"INSERT INTO searchratio(user,keyword,total,found,dt) VALUES(?,?,?,?,?)");
ratio.setString(1,user);
ratio.setString(2,keyword);
ratio.setInt(3,total);
ratio.setInt(4,found);
ratio.setString(5,dt);
ratio.executeUpdate();

connection.close();

}catch(Exception e){
out.println("<tr><td colspan='5' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>

</div>

<div class="text-end mt-4">
<a href="DU_Search.jsp" class="btn btn-outline-light">⬅ Back</a>
</div>

</div>

</body>
</html>