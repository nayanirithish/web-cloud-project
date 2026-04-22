<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Data Owner Dashboard - WebCloud</title>

<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #121212;
    margin: 0;
    color: white;
}

.sidebar {
    height: 100vh;
    background: #1c1c1c;
    padding-top: 20px;
    position: fixed;
    width: 250px;
}

.sidebar h4 {
    color: #a855f7;
    text-align: center;
    margin-bottom: 30px;
}

.sidebar a {
    color: #ccc;
    padding: 12px 20px;
    display: block;
    text-decoration: none;
    transition: 0.3s;
}

.sidebar a:hover {
    background: #a855f7;
    color: white;
}

.topbar {
    background: #111;
    padding: 15px 30px;
    position: fixed;
    width: calc(100% - 250px);
    margin-left: 250px;
}

.content {
    margin-left: 250px;
    padding: 40px;
}

.card {
    background: #1f2a36;
    border: none;
    border-radius: 15px;
    transition: 0.3s;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 0 20px #a855f7;
}
</style>

</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4><i class="fa fa-database"></i> Data Owner</h4>

    <a href="DO_Main.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="DO_Attackers.jsp"><i class="fa fa-user-secret"></i> Attackers</a>
    <a href="DO_Upload.jsp"><i class="fa fa-upload"></i> Upload File</a>
    <a href="DO_ViewFiles.jsp"><i class="fa fa-folder"></i> View Files</a>
    <a href="DO_VerifyFiles.jsp"><i class="fa fa-check-circle"></i> Verify Data</a>
    <a href="DO_Delete.jsp"><i class="fa fa-trash"></i> Delete Files</a>
    <a href="DO_Transactions.jsp"><i class="fa fa-exchange-alt"></i> Transactions</a>
    <a href="DO_Login.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Topbar -->
<div class="topbar">
    Welcome, <strong><%=application.getAttribute("doname")%></strong>
</div>

<!-- Content -->
<div class="content" style="margin-top:70px;">

<h2 class="mb-4">Data Owner Control Panel</h2>

<div class="row">

    <div class="col-md-4 mb-4">
        <div class="card p-4 text-white">
            <h5><i class="fa fa-upload"></i> Upload Files</h5>
            <p>Securely upload and encrypt files before storing in cloud.</p>
        </div>
    </div>

    <div class="col-md-4 mb-4">
        <div class="card p-4 text-white">
            <h5><i class="fa fa-folder-open"></i> Manage Files</h5>
            <p>View, verify, and delete your uploaded files.</p>
        </div>
    </div>

    <div class="col-md-4 mb-4">
        <div class="card p-4 text-white">
            <h5><i class="fa fa-chart-line"></i> Monitor Activity</h5>
            <p>Track transactions and monitor suspicious activities.</p>
        </div>
    </div>

</div>

</div>

</body>
</html>