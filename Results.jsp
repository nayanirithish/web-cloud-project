<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="connect.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>User Group Results</title>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background:#121212;
    color:white;
    font-family:Arial;
}

.card-box{
    max-width:900px;
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

<h3 class="text-center mb-4">User Group Statistics</h3>

<canvas id="myChart" height="120"></canvas>

</div>

<script>

var labels = [];
var dataValues = [];

<%
try{

    PreparedStatement ps = connection.prepareStatement(
        "SELECT ugroup, COUNT(name) FROM user GROUP BY ugroup"
    );

    ResultSet rs = ps.executeQuery();

    while(rs.next()){
%>

labels.push("<%=rs.getString(1)%>");
dataValues.push(<%=rs.getInt(2)%>);

<%
    }

    connection.close();

}catch(Exception e){
    e.printStackTrace();
}
%>

const ctx = document.getElementById('myChart').getContext('2d');

new Chart(ctx, {
    type: 'bar',
    data: {
        labels: labels,
        datasets: [{
            label: 'Number of Users',
            data: dataValues,
            backgroundColor: '#42aBdB',
            borderColor: '#ffffff',
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        plugins: {
            legend: {
                labels: {
                    color: 'white'
                }
            }
        },
        scales: {
            x: {
                ticks: { color: 'white' }
            },
            y: {
                ticks: { color: 'white' },
                beginAtZero: true
            }
        }
    }
});
</script>

</body>
</html>