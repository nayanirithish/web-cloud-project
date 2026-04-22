<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebCloud | Security Attack Simulation</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#1f1c2c,#928dab);
    font-family:'Poppins',sans-serif;
    color:white;
}
.card-box{
    background:white;
    color:black;
    border-radius:15px;
    padding:30px;
    box-shadow:0 10px 30px rgba(0,0,0,0.4);
}
.warning{
    color:red;
    font-weight:bold;
}
</style>
</head>
<body>

<div class="container mt-5">

<h2 class="text-center mb-4">🚨 Attack Simulation Panel</h2>

<div class="card-box">

<div class="alert alert-danger text-center">
⚠ This module simulates unauthorized access attempts for security monitoring.
</div>

<form action="Attack1.jsp" method="post">

<div class="mb-3">
<label class="form-label">Target File Name</label>
<input type="text" name="t1" class="form-control" required>
</div>

<div class="mb-3">
<label class="form-label">Attacker Name</label>
<input type="text" name="ot" class="form-control" required>
</div>

<div class="text-center">
<button type="submit" class="btn btn-danger btn-lg">
🔥 Launch Attack
</button>
</div>

</form>

</div>

<div class="text-end mt-3">
<a href="index.html" class="btn btn-outline-light">⬅ Back</a>
</div>

</div>

</body>
</html>