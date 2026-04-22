<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>PKG Login - WebCloud</title>

    <meta charset="UTF-8">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            height: 100vh;
            background: linear-gradient(-45deg, #000000, #1f1c2c, #928dab, #f7971e);
            background-size: 400% 400%;
            animation: gradientMove 12s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            color: white;
        }

        @keyframes gradientMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .login-card {
            width: 420px;
            padding: 45px;
            border-radius: 20px;
            background: rgba(255,255,255,0.08);
            backdrop-filter: blur(18px);
            box-shadow: 0 0 50px rgba(255,165,0,0.5);
            transition: 0.4s;
        }

        .login-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 0 70px rgba(255,165,0,0.8);
        }

        .login-card h2 {
            text-align: center;
            font-weight: 700;
            margin-bottom: 10px;
        }

        .role-tag {
            text-align: center;
            font-size: 14px;
            margin-bottom: 30px;
            color: #ffcc70;
        }

        .form-control {
            background: transparent;
            border: 1px solid rgba(255,255,255,0.3);
            color: white;
            border-radius: 10px;
        }

        .form-control:focus {
            background: transparent;
            border-color: orange;
            box-shadow: 0 0 15px orange;
            color: white;
        }

        .btn-login {
            background: linear-gradient(45deg, orange, #ff9800);
            border: none;
            border-radius: 30px;
            font-weight: 600;
            padding: 10px;
            transition: 0.3s;
            color: black;
        }

        .btn-login:hover {
            transform: scale(1.05);
            box-shadow: 0 0 25px orange;
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 12px;
            opacity: 0.8;
        }
    </style>
</head>

<body>

<div class="login-card">
    <h2><i class="fa-solid fa-key"></i> WebCloud</h2>
    <div class="role-tag">Private Key Generator Access</div>

    <!-- BACKEND SAME -->
    <form action="PKG_Authentication.jsp" method="post">

        <div class="mb-3">
            <label>User ID</label>
            <input type="text" name="userid" class="form-control" required>
        </div>

        <div class="mb-3">
            <label>Password</label>
            <input type="password" name="pass" class="form-control" required>
        </div>

        <div class="d-grid mt-4">
            <button type="submit" class="btn btn-login">
                Login
            </button>
        </div>

        <div class="d-grid mt-3">
            <button type="reset" class="btn btn-outline-light">
                Reset
            </button>
        </div>

    </form>

    <div class="footer-text">
        Secure Cryptographic Key Authority Module
    </div>
</div>

</body>
</html>