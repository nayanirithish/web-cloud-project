<%@ page language="java" contentType="image/jpeg"%>
<%@ page import="java.sql.*,java.io.*"%>
<%@ include file="connect.jsp" %>

<%
try{

    int id = Integer.parseInt(request.getParameter("imgid"));

    PreparedStatement ps = connection.prepareStatement(
        "SELECT imagess FROM downer WHERE id=?"
    );
    ps.setInt(1, id);

    ResultSet rs = ps.executeQuery();

    if(rs.next()){

        Blob imageBlob = rs.getBlob("imagess");

        if(imageBlob != null){

            byte[] imageBytes = imageBlob.getBytes(1, (int)imageBlob.length());

            response.reset();
            response.setContentType("image/jpeg");  // Change if PNG
            response.setContentLength(imageBytes.length);

            OutputStream outStream = response.getOutputStream();
            outStream.write(imageBytes);
            outStream.flush();
            outStream.close();
        }
    }

    connection.close();

}catch(Exception e){
    e.printStackTrace();
}
%>