<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>WebCloud | End User Registration</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Font -->
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
*{
    font-family: 'Poppins', sans-serif;
}

body{
    margin:0;
    min-height:100vh;
    background: linear-gradient(-45deg,#0f2027,#203a43,#2c5364,#00c6ff);
    background-size:400% 400%;
    animation: gradientMove 12s ease infinite;
    display:flex;
    align-items:center;
    justify-content:center;
}

@keyframes gradientMove{
    0%{background-position:0% 50%;}
    50%{background-position:100% 50%;}
    100%{background-position:0% 50%;}
}

.glass-card{
    width:750px;
    padding:40px;
    border-radius:20px;
    background:rgba(255,255,255,0.1);
    backdrop-filter:blur(15px);
    box-shadow:0 15px 40px rgba(0,0,0,0.4);
    color:white;
}

.title{
    font-weight:700;
    text-align:center;
    margin-bottom:30px;
}

.form-control, .form-select{
    background:rgba(255,255,255,0.2);
    border:none;
    color:white;
}

.form-control::placeholder{
    color:#eee;
}

.form-control:focus, .form-select:focus{
    box-shadow:0 0 10px rgba(0,255,255,0.6);
    background:rgba(255,255,255,0.3);
    color:white;
}

.btn-premium{
    background:linear-gradient(45deg,#00c6ff,#0072ff);
    border:none;
    font-weight:600;
    letter-spacing:1px;
}

.btn-premium:hover{
    transform:scale(1.05);
    transition:0.3s;
}

.login-link{
    text-align:center;
    margin-top:20px;
}

.login-link a{
    color:#00f2fe;
    font-weight:600;
    text-decoration:none;
}

.login-link a:hover{
    text-decoration:underline;
}
</style>
</head>

<body>

<div class="glass-card">

<h2 class="title">🚀 Create Your WebCloud Account</h2>

<form action="DU_RegisterAuthentication.jsp" method="post" enctype="multipart/form-data">

<div class="row">
<div class="col-md-6 mb-3">
<input type="text" name="userid" class="form-control" placeholder="Username" required>
</div>

<div class="col-md-6 mb-3">
<input type="password" name="pass" class="form-control" placeholder="Password" required>
</div>
</div>

<div class="row">
<div class="col-md-6 mb-3">
<input type="email" name="email" class="form-control" placeholder="Email Address" required>
</div>

<div class="col-md-6 mb-3">
<input type="text" name="mobile" class="form-control" placeholder="Mobile Number" required>
</div>
</div>

<div class="mb-3">
<textarea name="address" class="form-control" rows="3" placeholder="Your Address"></textarea>
</div>

<div class="row">
<div class="col-md-6 mb-3">
<input type="date" name="dob" class="form-control" required>
</div>

<div class="col-md-6 mb-3">
<select name="gender" class="form-select" required>
<option value="">Select Gender</option>
<option>Male</option>
<option>Female</option>
</select>
</div>
</div>

<div class="row">
<div class="col-md-6 mb-3">
<input type="text" name="pincode" class="form-control" placeholder="Pincode" required>
</div>

<div class="col-md-6 mb-3">
<input type="text" name="location" class="form-control" placeholder="Location" required>
</div>
</div>

<div class="mb-3">
<input type="file" name="pic" class="form-control" required>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-premium btn-lg">REGISTER NOW</button>
</div>

<div class="login-link">
Already have an account?
<a href="DU_Login.jsp">Login Here</a>
</div>

</form>

</div>

</body>
</html>