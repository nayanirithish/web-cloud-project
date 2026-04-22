<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp"%>
<%@ page import="java.sql.*"%>

<%
String csp = (String)session.getAttribute("cspname");
if(csp == null){
    response.sendRedirect("C_Login.jsp");
    return;
}

int totalUsers=0,totalFiles=0,totalAttacks=0,totalRequests=0;

try{
Statement st = connection.createStatement();

ResultSet rs1 = st.executeQuery("SELECT COUNT(*) FROM user");
if(rs1.next()) totalUsers = rs1.getInt(1);

ResultSet rs2 = st.executeQuery("SELECT COUNT(*) FROM cloudserver");
if(rs2.next()) totalFiles = rs2.getInt(1);

ResultSet rs3 = st.executeQuery("SELECT COUNT(*) FROM attacker");
if(rs3.next()) totalAttacks = rs3.getInt(1);

ResultSet rs4 = st.executeQuery("SELECT COUNT(*) FROM request WHERE SearchPer='Requested'");
if(rs4.next()) totalRequests = rs4.getInt(1);

connection.close();

}catch(Exception e){
out.println(e.getMessage());
}
%>

<!DOCTYPE html>
<html>
<head>
<title>WebCloud CSP Dashboard</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<style>
body{
    background: linear-gradient(135deg,#00c6ff,#0072ff,#6a11cb);
    font-family: 'Poppins', sans-serif;
}

/* Navbar */
.navbar{
    background: linear-gradient(90deg,#ff512f,#dd2476);
    box-shadow:0 5px 20px rgba(0,0,0,0.3);
}

/* Cards */
.card{
    background: rgba(255,255,255,0.95);
    border-radius: 15px;
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    transition: 0.3s;
}
.card:hover{
    transform: translateY(-8px) scale(1.03);
}

/* Card Borders */
.border-users{border-left:6px solid #2979ff;}
.border-files{border-left:6px solid #00c853;}
.border-attacks{border-left:6px solid #ff1744;}
.border-requests{border-left:6px solid #ff9100;}

h3,h5{color:#111;}

.btn{
    border-radius:25px;
    font-weight:600;
}

.btn-danger{ background:#ff4b2b; border:none; }
.btn-warning{ background:#ffcc00; border:none; color:black;}
.btn-success{ background:#00c853; border:none;}
.btn-primary{ background:#2979ff; border:none;}
.btn-info{ background:#00e5ff; border:none; color:black;}

</style>

</head>

<body>

<nav class="navbar navbar-dark px-3">
<span class="navbar-brand fs-4">☁ WebCloud CSP Dashboard</span>
<span class="text-white">Welcome, <b><%=csp%></b></span>
<a href="C_Login.jsp" class="btn btn-danger btn-sm">Logout</a>
</nav>

<div class="container mt-4">

<h3 class="mb-4 text-white">📊 System Overview</h3>

<div class="row g-4">

<div class="col-md-3">
<div class="card border-users p-3 text-center">
<h5 class="text-primary fw-bold">👥 Users</h5>
<h2><%=totalUsers%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card border-files p-3 text-center">
<h5 class="text-success fw-bold">📁 Files</h5>
<h2><%=totalFiles%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card border-attacks p-3 text-center">
<h5 class="text-danger fw-bold">⚠ Attacks</h5>
<h2 class="text-danger"><%=totalAttacks%></h2>
</div>
</div>

<div class="col-md-3">
<div class="card border-requests p-3 text-center">
<h5 class="text-warning fw-bold">⏳ Requests</h5>
<h2 class="text-warning"><%=totalRequests%></h2>
</div>
</div>

</div>

<!-- GRAPH + ACTIONS -->
<div class="row mt-5 g-4">

<!-- GRAPH -->
<div class="col-md-7">
<div class="card p-4 h-100">
<h5>📈 System Analytics</h5>
<div style="height:300px;">
<canvas id="chart"></canvas>
</div>
</div>
</div>

<!-- QUICK ACTIONS -->
<div class="col-md-5">
<div class="card p-4 h-100">
<h5>⚡ Quick Actions</h5>

<div class="d-grid gap-2 mt-3">

<a href="C_UserAutho.jsp" class="btn btn-primary">👤 Manage Users</a>
<a href="C_OwnerAutho.jsp" class="btn btn-success">🧑 Manage Owners</a>
<a href="C_ViewFiles.jsp" class="btn btn-info">📂 View Files</a>
<a href="C_Attackers.jsp" class="btn btn-danger">🚨 Attack Logs</a>
<a href="C_GrantSearch.jsp" class="btn btn-warning">🔐 Requests</a>
<a href="C_TopSearched.jsp" class="btn btn-secondary">🔍 Keywords</a>

<a href="File_Audit.jsp" class="btn btn-warning m-2">
📜 File Audit Trail
</a>

</div>

</div>
</div>

</div>

</div>

<script>
new Chart(document.getElementById("chart"), {
    type: 'bar',
    data: {
        labels: ['Users','Files','Attacks','Requests'],
        datasets: [{
            label: 'System Metrics',
            data: [<%=totalUsers%>,<%=totalFiles%>,<%=totalAttacks%>,<%=totalRequests%>],
            borderWidth: 1
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false
    }
});
</script>

</body>
</html>