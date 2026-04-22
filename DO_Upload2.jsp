<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@page import ="java.util.*"%>
<%@ include file="connect.jsp" %>
<%@page import ="java.security.Key,javax.crypto.Cipher,javax.crypto.spec.SecretKeySpec,org.bouncycastle.util.encoders.Base64"%>
<%@ page import="java.sql.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<title>Upload Status</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:#121212;
    color:white;
}
.status-box{
    max-width:600px;
    margin:100px auto;
    background:#1f2a36;
    padding:50px;
    border-radius:20px;
    text-align:center;
    box-shadow:0 0 30px rgba(168,85,247,0.5);
}
.success-icon{
    font-size:60px;
    color:#a855f7;
}
</style>
</head>

<body>

<div class="status-box">

<%
try{

long stime = System.currentTimeMillis();

/* ✅ GET CONTENT FROM SESSION (MAIN FIX) */
String cont = (String)session.getAttribute("fileContent");

/* NULL SAFETY */
if(cont == null){
%>
<div class="alert alert-danger">
⚠ Session expired or file missing. Please upload again.
</div>
<%
return;
}

/* FORM DATA */
String file  = request.getParameter("fname");
String mac   = request.getParameter("mac");
String index = request.getParameter("index");

/* OWNER */
String dname = (String)application.getAttribute("doname");

/* DATE TIME */
SimpleDateFormat sdfDate = new SimpleDateFormat("dd/MM/yyyy");
SimpleDateFormat sdfTime = new SimpleDateFormat("HH:mm:ss");

java.util.Date now = new java.util.Date();
String dt = sdfDate.format(now) + "   " + sdfTime.format(now);

/* ENCRYPT DATE */
String keys = "ef50a0ef2c3e3a5f";

byte[] keyValue = keys.getBytes();
Key key = new SecretKeySpec(keyValue,"AES");

Cipher c = Cipher.getInstance("AES");
c.init(Cipher.ENCRYPT_MODE,key);

String dt1 = new String(Base64.encode(dt.getBytes()));

/* DEFAULT VALUES */
String rank="0";
String skstatus="No";
String task="Upload";

Statement st = connection.createStatement();

/* TRANSACTION LOG */
st.executeUpdate(
"insert into transaction(user,fname,task,dt) values('"+dname+"','"+file+"','"+task+"','"+dt+"')"
);

/* CLOUD SERVER STORAGE */
st.executeUpdate(
"insert into cloudserver(fname,ct,findex,trapdoor,sk,rank,dt,downer) values('"+file+"','"+cont+"','"+index+"','"+mac+"','"+skstatus+"','"+rank+"','"+dt1+"','"+dname+"')"
);

/* BACKUP TABLE */
st.executeUpdate(
"insert into DataOwner(fname,ct,findex,trapdoor,sk,rank,dt,downer) values('"+file+"','"+cont+"','"+index+"','"+mac+"','"+skstatus+"','"+rank+"','"+dt1+"','"+dname+"')"
);

/* TIME + THROUGHPUT */
long etime = System.currentTimeMillis();
long ttime = etime - stime;

long tpt = 0;
if(ttime != 0){
    tpt = ((cont.length())/ttime)*1024;
}

/* RESULTS */
st.executeUpdate(
"insert into results values('"+file+"','"+ttime+"','"+tpt+"')"
);

/* ✅ CLEAR SESSION AFTER USE */
session.removeAttribute("fileContent");

connection.close();
%>

<div class="success-icon">✔</div>

<h3 class="mt-3">File Uploaded Successfully!</h3>

<p class="mt-3">
<strong>File Name :</strong> <%=file%><br>
<strong>Owner :</strong> <%=dname%>
</p>

<a href="DO_Main.jsp" class="btn btn-success mt-4">
Back to Dashboard
</a>

<%
}
catch(Exception e){
%>

<div class="alert alert-danger">
Error : <%=e.getMessage()%>
</div>

<%
}
%>

</div>

</body>
</html>