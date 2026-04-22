<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>Results 3 - Throughput Analysis</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background:#121212;
    color:white;
    font-family:Arial;
}
.card-box{
    max-width:1000px;
    margin:80px auto;
    background:#1f2a36;
    padding:40px;
    border-radius:20px;
    box-shadow:0 0 25px rgba(0,255,255,0.2);
}
</style>
</head>

<body>

<div class="card-box">
<h3>File Upload Throughput Analysis</h3>
<canvas id="throughputChart"></canvas>
</div>

<script>

var labels = [];
var throughput = [];

<%
try{
    PreparedStatement ps = connection.prepareStatement("SELECT * FROM results");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
labels.push("<%=rs.getString(1)%>");
throughput.push(<%=rs.getLong(3)%>);
<%
    }
    connection.close();
}catch(Exception e){
    e.printStackTrace();
}
%>

new Chart(document.getElementById('throughputChart'), {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Throughput (KB/sec)',
            data: throughput,
            backgroundColor: '#00FFFF'
        }]
    },
    options: {
        responsive: true,
        scales: {
            x: { ticks: { color: 'white' } },
            y: { ticks: { color: 'white' }, beginAtZero: true }
        },
        plugins: {
            legend: { labels: { color: 'white' } }
        }
    }
});

</script>

</body>
</html>