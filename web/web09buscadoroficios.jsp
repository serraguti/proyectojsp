<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = 
    DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Buscador empleados Oficio</h1>
        <form method="post">
            <label>Oficio: </label>
            <input type="text" name="cajaoficio" required/>
            <button type="submit">Buscar empleados</button>
        </form>
        <%
        String oficio = request.getParameter("cajaoficio");
        if (oficio != null){
            String sql = "select * from emp where lower(oficio) = lower(?)";
            PreparedStatement pst = cn.prepareStatement(sql);
            pst.setString(1, oficio);
            ResultSet rs = pst.executeQuery();
            %>
            <table border="1">
                <thead>
                    <tr>
                        <th>APELLIDO</th>
                        <th>OFICIO</th>
                    </tr>
                </thead>
                <tbody>
            <%
            while(rs.next()){
                String ape = rs.getString("APELLIDO");
                String ofi = rs.getString("OFICIO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=ofi%></td>
                </tr>
                <%
            }
            %>
                </tbody>
            </table>
            <%
            rs.close();
            cn.close();
        }
        %>
    </body>
</html>
