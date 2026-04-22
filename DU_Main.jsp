<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WebCloud | End User Dashboard</title>

<!-- Bootstrap -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    font-family: 'Poppins', sans-serif;
}

body{
    margin:0;
    background:#0f2027;
    color:white;
}

.sidebar{
    width:250px;
    height:100vh;
    position:fixed;
    background:linear-gradient(180deg,#141e30,#243b55);
    padding-top:30px;
}

.sidebar h4{
    text-align:center;
    margin-bottom:30px;
    font-weight:600;
}

.sidebar a{
    display:block;
    padding:12px 20px;
    color:white;
    text-decoration:none;
    transition:0.3s;
}

.sidebar a:hover{
    background:#1c92d2;
    padding-left:25px;
}

.main-content{
    margin-left:250px;
    padding:40px;
}

.topbar{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:30px;
}

.card-premium{
    background:linear-gradient(135deg,#1c92d2,#f2fcfe);
    color:black;
    border-radius:15px;
    padding:20px;
    box-shadow:0 10px 25px rgba(0,0,0,0.4);
}

.btn-logout{
    background:#ff4b5c;
    border:none;
}

.btn-logout:hover{
    background:#ff1e3c;
}
</style>
</head>

<body>

<!-- Sidebar -->
<div class="sidebar">
    <h4>☁ WebCloud</h4>
    <a href="DU_Main.jsp">🏠 Home</a>
    <a href="DU_Profile.jsp">👤 My Profile</a>
    <a href="DU_ViewFiles.jsp">📂 View Files</a>
    <a href="DU_Search.jsp">🔎 Search Files</a>
    <a href="DU_Ratio.jsp">📊 Search Ratio</a>
    <a href="C_FileIntegrity.jsp" class="btn btn-outline-info m-2">

🔐 File Integrity Check
</a>
    <a href="DU_TopkDoc.jsp">⭐ Top K Search</a>
    <a href="DU_SearchReq.jsp">📩 Request Search Control</a>
    <a href="DU_Login.jsp">🚪 Logout</a>
</div>

<!-- Main Content -->
<div class="main-content">

<div class="topbar">
    <h2>Welcome, <%=application.getAttribute("uname")%> 👋</h2>
    <a href="DU_Login.jsp" class="btn btn-logout">Logout</a>
</div>

<div class="row">

<div class="col-md-6 mb-4">
<div class="card-premium">
<h4>🔐 Secure Cloud Storage</h4>
<p>
WebCloud provides browser-based encryption ensuring secure file access,
robust authorization control, and cross-platform usability.
</p>
</div>
</div>

<div class="col-md-6 mb-4">
<div class="card-premium">
<h4>⚡ Fast & Efficient Search</h4>
<p>
Supports Top-K search, ranking ratio analysis,
and secure search control mechanisms for encrypted documents.
</p>
</div>
</div>

<div class="col-md-6 mb-4">
<div class="card-premium">
<h4>🛡 Attribute-Based Encryption</h4>
<p>
Implements Ciphertext-Policy Attribute-Based Key Encapsulation
for fine-grained access control and secure sharing.
</p>
</div>
</div>

<div class="col-md-6 mb-4">
<div class="card-premium">
<h4>🌐 Cross Platform Access</h4>
<p>
Accessible via browsers, mobile devices, and PC applications
without requiring additional plugins.
</p>
</div>
</div>

</div>

</div>

</body>
</html>