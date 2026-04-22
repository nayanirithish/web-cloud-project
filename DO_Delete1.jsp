<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*,java.text.SimpleDateFormat,java.util.Date"%>

<!DOCTYPE html>
<html>
<head>
<title>Delete Status</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #121212;
    color: white;
    font-family: Arial;
}

.status-box {
    max-width: 600px;
    margin: 120px auto;
    background: #1f2a36;
    padding: 50px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 0 25px rgba(255,0,0,0.4);
}
</style>
</head>

<body>

<div class="status-box">

<%
try {

    int uid = Integer.parseInt(request.getParameter("usid"));
    String file=request.getParameter("fname");
    String dname=(String)application.getAttribute("doname");

    String task="Delete";

    SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
    SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");
    Date now = new Date();
    String dt = sdfDate.format(now)+"   "+sdfTime.format(now);

    Statement st=connection.createStatement();

    // Insert transaction
    st.executeUpdate("insert into transaction(user,fname,task,dt) values('"+dname+"','"+file+"','"+task+"','"+dt+"')");

    // Delete file
    int rs3=st.executeUpdate("delete from cloudserver where id='"+uid+"'");

    if(rs3==1){
%>
        <div class="alert alert-success">
        File "<strong><%=file%></strong>" Deleted Successfully!
        </div>
<%
    } else {
%>
        <div class="alert alert-danger">
        File Not Found!
        </div>
<%
    }

    connection.close();

} catch(Exception e){
    out.println("<div class='alert alert-danger'>"+e.getMessage()+"</div>");
}
%>

<div class="mt-4">
<a href="DO_Delete.jsp" class="btn btn-danger">Back to Delete Page</a>
</div>

<div class="mt-2">
<a href="DO_Main.jsp" class="btn btn-outline-light btn-sm">Dashboard</a>
</div>

</div>

</body>
</html>