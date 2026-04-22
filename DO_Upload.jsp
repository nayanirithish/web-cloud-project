<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload File | WebCloud</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body{
    background:linear-gradient(135deg,#0f2027,#2c5364);
    color:white;
}
.container-box{
    max-width:800px;
    margin:60px auto;
    background:#1e2a38;
    padding:30px;
    border-radius:20px;
    box-shadow:0 0 20px rgba(0,0,0,0.5);
}
input{
    background:#0f1722 !important;
    color:white !important;
}
#previewArea{
    background:#0f1722;
    padding:10px;
    border-radius:10px;
    max-height:300px;
    overflow:auto;
    text-align:center;
}
</style>

<script>
function handleFile(input){
    let file = input.files[0];

    if(file){

        // Auto fill fields
        document.getElementById("filename").value = file.name;
        document.getElementById("indexname").value = file.name.split('.')[0];

        let reader = new FileReader();

        reader.onload = function(e){
            let data = e.target.result;

            let preview = document.getElementById("previewArea");

            // 🔥 PREVIEW LOGIC
            if(file.type.startsWith("image")){
                preview.innerHTML = "<img src='"+data+"' width='250'>";
            }
            else if(file.type.startsWith("video")){
                preview.innerHTML = "<video width='350' controls src='"+data+"'></video>";
            }
            else if(file.type === "application/pdf"){
                preview.innerHTML = "<iframe src='"+data+"' width='100%' height='300'></iframe>";
            }
            else{
                preview.innerHTML = "<p>Preview not available for this file type</p>";
            }
        };

        // Always use DataURL (works for all types)
        reader.readAsDataURL(file);
    }
}
</script>

</head>

<body>

<div class="container-box">

<h3 class="text-center mb-4">⬆ Upload & Encrypt File</h3>

<!-- ✅ IMPORTANT: multipart/form-data -->
<form action="DO_Upload1.jsp" method="post" enctype="multipart/form-data">

<div class="mb-3">
<label>Select File</label>
<input type="file" name="file" class="form-control" onchange="handleFile(this)" required>
</div>

<div class="mb-3">
<label>Index Name</label>
<input type="text" id="indexname" name="indexname" class="form-control" required>
</div>

<div class="mb-3">
<label>File Name</label>
<input type="text" id="filename" name="filename" class="form-control" required>
</div>

<div class="mb-3">
<label>File Preview</label>
<div id="previewArea">
Preview will appear here...
</div>
</div>

<div class="d-grid">
<button type="submit" class="btn btn-primary">
🔐 Encrypt & Preview
</button>
</div>

</form>

</div>

</body>
</html>