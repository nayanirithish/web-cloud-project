<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WebCloud | My Profile</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    font-family:'Poppins',sans-serif;
    background:#0f2027;
    color:white;
}

.profile-container{
    margin-top:50px;
}

.profile-card{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}

.profile-img{
    width:180px;
    height:180px;
    border-radius:50%;
    object-fit:cover;
    border:5px solid #1c92d2;
}

.label-title{
    font-weight:600;
    color:#1c92d2;
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

<div class="container profile-container">

<h2 class="text-center mb-4">
👤 <%=application.getAttribute("uname")%>'s Profile
</h2>

<%
String uname = (String)application.getAttribute("uname");

try {

    String query = "SELECT * FROM user WHERE name=?";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.setString(1, uname);
    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        int id = rs.getInt(1);
        String username = rs.getString(2);
        String email = rs.getString(4);
        String mobile = rs.getString(5);
        String address = rs.getString(6);
        String dob = rs.getString(7);
%>

<div class="row justify-content-center">
<div class="col-md-8">

<div class="profile-card">

<div class="row">

<div class="col-md-4 text-center">
<img src="profileimage.jsp?imgid=<%=id%>" class="profile-img mb-3"/>
<h5><%=username%></h5>
</div>

<div class="col-md-8">

<p><span class="label-title">Email:</span> <%=email%></p>
<p><span class="label-title">Mobile:</span> <%=mobile%></p>
<p><span class="label-title">Date of Birth:</span> <%=dob%></p>
<p><span class="label-title">Address:</span> <%=address%></p>

</div>

</div>

</div>

</div>
</div>

<%
    }

    rs.close();
    ps.close();
    connection.close();

} catch(Exception e){
    out.println("<p class='text-danger'>Error: "+e.getMessage()+"</p>");
}
%>

<div class="text-end mt-4">
<a href="DU_Main.jsp" class="btn btn-back text-white">⬅ Back to Dashboard</a>
</div>

</div>

</body>
</html>