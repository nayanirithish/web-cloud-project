<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
/* SESSION VALIDATION */
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}

StringBuilder labels = new StringBuilder();
StringBuilder values = new StringBuilder();
boolean hasData = false;

try{

PreparedStatement ps = connection.prepareStatement(
"SELECT fname, timedelay FROM performance ORDER BY timedelay ASC");

ResultSet rs = ps.executeQuery();

while(rs.next()){
    hasData = true;
    labels.append("'").append(rs.getString("fname")).append("',");
    values.append(rs.getDouble("timedelay")).append(",");
}

connection.close();

}catch(Exception e){
out.println("Error: "+e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>Time Delay Analysis</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background:#0f2027;
    color:white;
}
.card{
    background:rgba(255,255,255,0.08);
}
</style>

</head>
<body>

<nav class="navbar navbar-dark bg-dark">
<div class="container-fluid">
<span class="navbar-brand">System Time Delay Analysis</span>
<span>Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</div>
</nav>

<div class="container mt-4">

<div class="card p-4">

<h4 class="mb-3">File Processing Time Delay</h4>

<%
if(hasData){
%>

<canvas id="delayChart"></canvas>

<script>
const ctx = document.getElementById('delayChart');

new Chart(ctx, {
    type: 'line',
    data: {
        labels: [<%=labels.toString()%>],
        datasets: [{
            label: 'Time Delay (ms)',
            data: [<%=values.toString()%>],
            borderWidth: 2,
            tension: 0.3
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: { display: true }
        },
        scales: {
            y: { beginAtZero: true }
        }
    }
});
</script>

<%
}else{
%>

<div class="alert alert-warning">
No time delay data available.
</div>

<%
}
%>

</div>

<a href="C_Main.jsp" class="btn btn-secondary mt-3">Back</a>

</div>

</body>
</html>