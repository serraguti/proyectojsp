<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String dato = request.getParameter("cajainscripcion");
        int eliminados = -1;
        if (dato != null){
            int inscripcion = Integer.parseInt(dato);
            String sqldelete = "delete from enfermo where inscripcion=?";
            PreparedStatement pst = cn.prepareStatement(sqldelete);
            pst.setInt(1, inscripcion);
            eliminados = pst.executeUpdate();
        }        
        %>
        <h1>Eliminar enfermos</h1>
        <form method="post">
            <label>Inscripción: </label>
            <input type="text" name="cajainscripcion" required/>
            <button type="submit">Eliminar enfermo</button>
        </form>
        <ul>
            <%
            String sqlenfermos = "select * from enfermo";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqlenfermos);
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String ins = rs.getString("INSCRIPCION");
                %>
                <li><%=ape%>, <%=ins%></li>
                <%
            }
            rs.close();
            %>
        </ul>
        <%
        //SOLO PARA EL DIBUJO
        if (dato != null){
            %>
            <h1 style="color:red">Registros eliminados: <%=eliminados%></h1>
            <%
        }
        cn.close();
        %>
    </body>
</html>
