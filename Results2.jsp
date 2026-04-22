<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>Results 2 - Upload Time Analysis</title>

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
    box-shadow:0 0 25px rgba(0,123,255,0.3);
}
</style>
</head>

<body>

<div class="card-box">

<h3 class="text-center mb-4">Upload Time Analysis</h3>

<canvas id="resultChart"></canvas>

</div>

<script>

var labels = [];
var timeValues = [];

<%
try{

    PreparedStatement ps = connection.prepareStatement("SELECT * FROM results");
    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>
labels.push("<%=rs.getString(1)%>");
timeValues.push(<%=rs.getLong(2)%>);
<%
    }

    connection.close();

}catch(Exception e){
    e.printStackTrace();
}
%>

const ctx = document.getElementById('resultChart').getContext('2d');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Time Taken (ms)',
            data: timeValues,
            backgroundColor: '#42aBdB',
            borderColor: '#ffffff',
            borderWidth: 1
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