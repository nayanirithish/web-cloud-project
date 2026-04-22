<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="connect.jsp" %>
<%@ page import="java.sql.*,java.io.*,java.text.SimpleDateFormat,java.util.Date,org.bouncycastle.util.encoders.Base64"%>

<%
try {

    String file = request.getParameter("t1");
    String trapdoor = request.getParameter("t12");
    String sk = request.getParameter("t13");
    String user = (String)application.getAttribute("uname");

    /* ---------- VALIDATE FILE ---------- */
    String query = "SELECT * FROM cloudserver WHERE fname=? AND trapdoor=?";
    PreparedStatement ps = connection.prepareStatement(query);
    ps.setString(1,file);
    ps.setString(2,trapdoor);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        String ct = rs.getString("ct");   // encrypted content
        String dbsk = rs.getString("sk"); // secret key

        if(dbsk.equals(sk)){

            /* ---------- UPDATE RANK ---------- */
            int rank = rs.getInt("rank");
            PreparedStatement updateRank = connection.prepareStatement(
                "UPDATE cloudserver SET rank=? WHERE fname=?");
            updateRank.setInt(1,rank+1);
            updateRank.setString(2,file);
            updateRank.executeUpdate();

            /* ---------- INSERT TRANSACTION ---------- */
            String dt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

            PreparedStatement trans = connection.prepareStatement(
                "INSERT INTO transaction(user,fname,task,dt) VALUES(?,?,?,?)");
            trans.setString(1,user);
            trans.setString(2,file);
            trans.setString(3,"Download");
            trans.setString(4,dt);
            trans.executeUpdate();

            /* ---------- 🔓 DECODE BASE64 ---------- */
            byte[] fileBytes = Base64.decode(ct);

            /* ---------- 📂 SET CONTENT TYPE ---------- */
            if(file.endsWith(".jpg") || file.endsWith(".jpeg")){
                response.setContentType("image/jpeg");
            }else if(file.endsWith(".png")){
                response.setContentType("image/png");
            }else if(file.endsWith(".gif")){
                response.setContentType("image/gif");
            }else if(file.endsWith(".pdf")){
                response.setContentType("application/pdf");
            }else if(file.endsWith(".mp4")){
                response.setContentType("video/mp4");
            }else if(file.endsWith(".mp3")){
                response.setContentType("audio/mpeg");
            }else if(file.endsWith(".txt")){
                response.setContentType("text/plain");
            }else{
                response.setContentType("application/octet-stream");
            }

            /* ---------- ⬇ FORCE DOWNLOAD ---------- */
            response.setHeader("Content-Disposition",
                "attachment; filename=\"" + file + "\"");

            /* ---------- WRITE FILE ---------- */
            OutputStream os = response.getOutputStream();
            os.write(fileBytes);
            os.flush();
            os.close();

        } else {

            /* ---------- SECRET KEY ATTACK ---------- */
            String dt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

            PreparedStatement attack = connection.prepareStatement(
                "INSERT INTO attacker(user,fname,sk,dt,attacktype) VALUES(?,?,?,?,?)");
            attack.setString(1,user);
            attack.setString(2,file);
            attack.setString(3,sk);
            attack.setString(4,dt);
            attack.setString(5,"SecretKey Mismatch");
            attack.executeUpdate();

            out.println("<h3 style='color:red;text-align:center;'>❌ Secret Key Mismatch</h3>");
        }

    } else {

        /* ---------- TRAPDOOR ATTACK ---------- */
        String dt = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss").format(new Date());

        PreparedStatement attack = connection.prepareStatement(
            "INSERT INTO attacker(user,fname,sk,dt,attacktype) VALUES(?,?,?,?,?)");
        attack.setString(1,user);
        attack.setString(2,file);
        attack.setString(3,trapdoor);
        attack.setString(4,dt);
        attack.setString(5,"Trapdoor Mismatch");
        attack.executeUpdate();

        out.println("<h3 style='color:red;text-align:center;'>❌ MAC (Trapdoor) Mismatch</h3>");
    }

    connection.close();

} catch(Exception e){
    out.println("<h3 style='color:red;text-align:center;'>Error: "+e.getMessage()+"</h3>");
}
%>