<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>PKG Dashboard - WebCloud</title>

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
            color: orange;
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
            background: orange;
            color: black;
        }

        .content {
            margin-left: 250px;
            padding: 40px;
        }

        .topbar {
            background: #111;
            padding: 15px 30px;
            color: white;
            position: fixed;
            width: calc(100% - 250px);
            margin-left: 250px;
        }

        .card {
            background: #1f2a36;
            border: none;
            border-radius: 15px;
            color: white;
            transition: 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 20px orange;
        }
    </style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4><i class="fa fa-key"></i> PKG Module</h4>

    <a href="PKG_Main.jsp"><i class="fa fa-home"></i> Dashboard</a>
    <a href="PKG_View_All_Files.jsp"><i class="fa fa-folder"></i> View Files & Generate Key</a>
    <a href="PKG_Login.jsp"><i class="fa fa-sign-out-alt"></i> Logout</a>
</div>

<!-- Topbar -->
<div class="topbar">
    Welcome, Private Key Generator
</div>

<!-- Content -->
<div class="content" style="margin-top:70px;">

    <h2 class="mb-4">PKG Control Panel</h2>

    <div class="row">

        <div class="col-md-6 mb-4">
            <div class="card p-4">
                <h5><i class="fa fa-folder-open"></i> File Access Management</h5>
                <p>View encrypted files and manage key generation requests securely.</p>
            </div>
        </div>

        <div class="col-md-6 mb-4">
            <div class="card p-4">
                <h5><i class="fa fa-lock"></i> Cryptographic Key Authority</h5>
                <p>Generate and manage secure keys for authorized users.</p>
            </div>
        </div>

    </div>

</div>

</body>
</html>