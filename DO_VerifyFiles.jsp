<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Verify File Integrity</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

<style>
body {
    font-family: 'Poppins', sans-serif;
    background: #121212;
    color: white;
}

.verify-box {
    max-width: 600px;
    margin: 100px auto;
    background: #1f2a36;
    padding: 50px;
    border-radius: 20px;
    box-shadow: 0 0 25px rgba(168,85,247,0.5);
}

.btn-verify {
    background: linear-gradient(45deg,#a855f7,#6d28d9);
    border: none;
}

.btn-verify:hover {
    box-shadow: 0 0 15px #a855f7;
}
</style>
</head>

<body>

<div class="verify-box">

<h3 class="mb-4 text-center">Verify File Integrity</h3>

<form method="post" action="ConfirmVerify.jsp">

<div class="mb-3">
<label class="form-label">Enter File Name</label>
<input required name="fname" type="text" class="form-control" placeholder="Enter exact file name">
</div>

<div class="d-grid">
<button type="submit" name="Submit" class="btn btn-verify text-white">
Verify
</button>
</div>

</form>

<div class="text-end mt-4">
<a href="DO_Main.jsp" class="btn btn-outline-light btn-sm">Back</a>
</div>

</div>

</body>
</html>