<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WebCloud | Search Ratio</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#0f2027;
    color:white;
}

.container-box{
    margin-top:40px;
}

.table-custom{
    background:white;
    color:black;
    border-radius:10px;
    overflow:hidden;
}

thead{
    background:linear-gradient(45deg,#ff416c,#ff4b2b);
    color:white;
}

h2{
    font-weight:600;
}

.btn-back{
    background:#1c92d2;
    border:none;
}

.btn-back:hover{
    background:#145da0;
}
</style>
</head>

<body>

<div class="container container-box">

<h2 class="text-center mb-4">
📊 Search Ratio Analytics - <%=application.getAttribute("uname")%>
</h2>

<div class="table-responsive">
<table class="table table-bordered table-hover table-custom text-center align-middle">

<thead>
<tr>
<th>ID</th>
<th>User</th>
<th>Keyword</th>
<th>Total Files</th>
<th>Found Files</th>
<th>Search Ratio</th>
<th>Date & Time</th>
</tr>
</thead>

<tbody>

<%
String user=(String)application.getAttribute("uname");

try {
    String query="select * from searchratio where user=?";
    PreparedStatement ps=connection.prepareStatement(query);
    ps.setString(1,user);
    ResultSet rs=ps.executeQuery();

    while(rs.next()){
        int id=rs.getInt(1);
        String u=rs.getString(2);
        String keyword=rs.getString(3);
        String total=rs.getString(4);
        String found=rs.getString(5);
        String date=rs.getString(6);
%>

<tr>
<td><%=id%></td>
<td><%=u%></td>
<td><%=keyword%></td>
<td><%=total%></td>
<td><%=found%></td>
<td>
<span class="badge bg-success">
<%=found%> / <%=total%>
</span>
</td>
<td><%=date%></td>
</tr>

<%
    }

    rs.close();
    ps.close();
    connection.close();

} catch(Exception e){
    out.println("<tr><td colspan='7' class='text-danger'>Error: "+e.getMessage()+"</td></tr>");
}
%>

</tbody>
</table>
</div>

<div class="text-end mt-3">
<a href="DU_Main.jsp" class="btn btn-back text-white">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>