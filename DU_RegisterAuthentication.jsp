<title>Registration Authentication</title>

<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="connect.jsp" %>

<%
try {

    ServletContext context = getServletContext();
    String dirName = context.getRealPath("Gallery");

    MultipartRequest multi = new MultipartRequest(request, dirName, 10 * 1024 * 1024);

    String uname = multi.getParameter("userid");
    String pass  = multi.getParameter("pass");
    String email = multi.getParameter("email");
    String mno   = multi.getParameter("mobile");
    String addr  = multi.getParameter("address");
    String dob   = multi.getParameter("dob");
    String gender= multi.getParameter("gender");
    String pincode = multi.getParameter("pincode");
    String location = multi.getParameter("location");

    String status = "Waiting";

    /* ---------- CHECK USER EXISTS (SECURE) ---------- */

    String checkQuery = "SELECT * FROM user WHERE name=?";
    PreparedStatement checkPs = connection.prepareStatement(checkQuery);
    checkPs.setString(1, uname);
    ResultSet rs = checkPs.executeQuery();

    if(rs.next()) {

        out.println("<h3 style='color:red;'>Username Already Exists</h3>");
        out.println("<a href='DU_Register.jsp'>Back</a>");

    } else {

        /* ---------- FILE HANDLING ---------- */

        File imageFile = null;
        FileInputStream fis = null;

        Enumeration files = multi.getFileNames();
        if(files.hasMoreElements()){
            String param = (String)files.nextElement();
            String fileName = multi.getFilesystemName(param);

            if(fileName != null){
                String filePath = context.getRealPath("Gallery/" + fileName);
                imageFile = new File(filePath);
                fis = new FileInputStream(imageFile);
            }
        }

        /* ---------- INSERT USER ---------- */

        String insertQuery = "INSERT INTO user(name,pass,email,mobile,addr,dob,gender,pin,location,imagess,status) VALUES(?,?,?,?,?,?,?,?,?,?,?)";

        PreparedStatement ps = connection.prepareStatement(insertQuery);

        ps.setString(1, uname);
        ps.setString(2, pass);   // (We can hash later if you want)
        ps.setString(3, email);
        ps.setString(4, mno);
        ps.setString(5, addr);
        ps.setString(6, dob);
        ps.setString(7, gender);
        ps.setString(8, pincode);
        ps.setString(9, location);

        if(fis != null)
            ps.setBinaryStream(10, fis, (int)imageFile.length());
        else
            ps.setNull(10, java.sql.Types.BLOB);

        ps.setString(11, status);

        int x = ps.executeUpdate();

        if(x > 0){
            response.sendRedirect("DU_Login.jsp?msg=registered");
        }

        ps.close();
    }

    rs.close();
    checkPs.close();
    connection.close();

} catch(Exception e){
    out.println("<h3 style='color:red;'>Error: "+e.getMessage()+"</h3>");
}
%>