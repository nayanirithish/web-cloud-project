<%
String csmac = null;
String ownermac = null;

try {

    String file = request.getParameter("fname");
    String owner = (String) application.getAttribute("doname");

    if(file == null || file.trim().equals("")){
        out.println("<h2>Please Enter File Name</h2>");
        return;
    }

    // ------------------ FETCH FROM CLOUD SERVER ------------------
    PreparedStatement ps1 = connection.prepareStatement(
        "SELECT trapdoor FROM cloudserver WHERE fname=? AND downer=?"
    );
    ps1.setString(1, file);
    ps1.setString(2, owner);

    ResultSet rs1 = ps1.executeQuery();

    if(rs1.next()){
        csmac = rs1.getString("trapdoor");
    } else {
%>
        <h2><%=file%> is Not Found in Cloud Server !!!</h2>
<%
        return;
    }

    // ------------------ FETCH FROM DATA OWNER ------------------
    PreparedStatement ps2 = connection.prepareStatement(
        "SELECT trapdoor FROM dataowner WHERE fname=? AND downer=?"
    );
    ps2.setString(1, file);
    ps2.setString(2, owner);

    ResultSet rs2 = ps2.executeQuery();

    if(rs2.next()){
        ownermac = rs2.getString("trapdoor");
    } else {
%>
        <h2><%=file%> is Missing in Data Owner Backup !!!</h2>
<%
        return;
    }

    // ------------------ VERIFY INTEGRITY ------------------
    if(csmac != null && csmac.equals(ownermac)){
%>
        <h1 style="color:green;"><%=file%> is Secured ✔</h1>
<%
    } else {
%>
        <h2 style="color:red;"><%=file%> is Attacked / Modified ❌</h2>
<%
    }

    connection.close();

} catch(Exception e){
    out.println("Error : " + e.getMessage());
}
%>