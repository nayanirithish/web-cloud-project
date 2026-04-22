<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>End User Login | WebCloud</title>

<!-- Bootstrap 5 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg, #0f2027, #203a43, #2c5364);
    height: 100vh;
    display: flex;
    flex-direction: column;
}

.navbar {
    background-color: rgba(0,0,0,0.7);
}

.login-container {
    flex: 1;
    display: flex;
    justify-content: center;
    align-items: center;
}

.login-card {
    width: 420px;
    border-radius: 15px;
    padding: 30px;
    background: #ffffff;
    box-shadow: 0 15px 40px rgba(0,0,0,0.3);
}

.login-title {
    font-weight: bold;
    color: #2c5364;
}

.btn-custom {
    background-color: #2c5364;
    color: white;
}

.btn-custom:hover {
    background-color: #203a43;
}

.footer {
    background: rgba(0,0,0,0.7);
    color: white;
    text-align: center;
    padding: 10px;
}
</style>
</head>

<body>

<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container">
    <a class="navbar-brand fw-bold" href="index.html">
      WEBCLOUD
    </a>
    <div>
      <a href="DO_Login.jsp" class="btn btn-outline-light btn-sm me-2">Data Owner</a>
      <a href="C_Login.jsp" class="btn btn-outline-light btn-sm">Cloud Provider</a>
    </div>
  </div>
</nav>

<!-- Login Section -->
<div class="login-container">
    <div class="login-card">

        <h3 class="text-center login-title mb-4">End User Login</h3>

        <form action="DU_Authentication.jsp" method="post">
            
            <div class="mb-3">
                <label class="form-label">Username</label>
                <input type="text" name="userid" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="pass" class="form-control" required>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-custom">Login</button>
            </div>

            <div class="text-center mt-3">
                <button type="reset" class="btn btn-outline-secondary btn-sm">Reset</button>
            </div>

            <div class="text-center mt-3">
                <small>New User? 
                <a href="DU_Register.jsp" class="text-decoration-none fw-bold">
                Register Here
                </a></small>
            </div>

        </form>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    © 2026 WebCloud Secure Storage System
</div>

</body>
</html>