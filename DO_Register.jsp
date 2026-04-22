<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Data Owner Register - WebCloud</title>

<meta charset="UTF-8">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: linear-gradient(-45deg, #141e30, #243b55, #3a1c71, #000000);
    background-size: 400% 400%;
    animation: gradientMove 12s ease infinite;
    margin: 0;
    color: white;
}

@keyframes gradientMove {
    0% { background-position: 0% 50%; }
    50% { background-position: 100% 50%; }
    100% { background-position: 0% 50%; }
}

.register-card {
    max-width: 700px;
    margin: 60px auto;
    padding: 40px;
    border-radius: 20px;
    background: rgba(255,255,255,0.08);
    backdrop-filter: blur(15px);
    box-shadow: 0 0 40px rgba(168,85,247,0.5);
}

.register-card h2 {
    text-align: center;
    margin-bottom: 30px;
}

.form-control, .form-select {
    background: transparent;
    border: 1px solid rgba(255,255,255,0.3);
    color: white;
}

.form-control:focus, .form-select:focus {
    background: transparent;
    border-color: #a855f7;
    box-shadow: 0 0 10px #a855f7;
    color: white;
}

.btn-register {
    background: linear-gradient(45deg, #a855f7, #6d28d9);
    border: none;
    border-radius: 30px;
    font-weight: 600;
    padding: 10px;
}

.btn-register:hover {
    box-shadow: 0 0 20px #a855f7;
}

a {
    color: #d8b4fe;
}
</style>

</head>
<body>

<div class="register-card">
<h2><i class="fa fa-user-plus"></i> Data Owner Registration</h2>

<form action="DO_RegisterAuthentication.jsp" method="post" enctype="multipart/form-data">

<div class="row">

<div class="col-md-6 mb-3">
<label>Name</label>
<input type="text" name="userid" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Password</label>
<input type="password" name="pass" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Email</label>
<input type="email" name="email" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Mobile</label>
<input type="text" name="mobile" class="form-control" required>
</div>

<div class="col-md-12 mb-3">
<label>Address</label>
<textarea name="address" class="form-control" rows="2"></textarea>
</div>

<div class="col-md-6 mb-3">
<label>Date of Birth</label>
<input type="date" name="dob" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Gender</label>
<select name="gender" class="form-select" required>
<option value="">-Select-</option>
<option>Male</option>
<option>Female</option>
</select>
</div>

<div class="col-md-6 mb-3">
<label>Pincode</label>
<input type="text" name="pincode" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<label>Location</label>
<input type="text" name="location" class="form-control" required>
</div>

<div class="col-md-12 mb-3">
<label>Profile Picture</label>
<input type="file" name="pic" class="form-control" required>
</div>

</div>

<div class="d-grid mt-3">
<button type="submit" name="submit" class="btn btn-register text-white">
REGISTER
</button>
</div>

<div class="text-center mt-3">
Already registered? <a href="DO_Login.jsp">Login here</a>
</div>

</form>

</div>

</body>
</html>