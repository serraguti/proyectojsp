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
        <%
        String dato = request.getParameter("cajanumero");
        String nombre = request.getParameter("cajanombre");
        String localidad = request.getParameter("cajalocalidad");
        int insertados = -1;
        if (dato != null){
            int numero = Integer.parseInt(dato);
            String sqlinsert = "insert into dept values (?,?,?)";
            PreparedStatement pst = cn.prepareStatement(sqlinsert);
            pst.setInt(1, numero);
            pst.setString(2, nombre);
            pst.setString(3, localidad);
            insertados = pst.executeUpdate();
        }
        %>
        <h1>Insertar departamentos</h1>
        <form method="post">
            <label>Número: </label>
            <input type="number" name="cajanumero" required/><br/>
            <label>Nombre: </label>
            <input type="text" name="cajanombre" required/><br/>
            <label>Localidad: </label>
            <input type="text" name="cajalocalidad" required/><br/>
            <button type="submit">Insertar departamento</button>
        </form>
        <%
        if (dato != null){
            %>
            <h1 style="color:blue">Insertados: <%=insertados%></h1>
            <%
        }
        %>
        <hr/>
        <table border="2">
            <thead>
                <tr>
                    <th>Número</th>
                    <th>Nombre</th>
                    <th>Localidad</th>
                </tr>
            </thead>
            <tbody>
            <%
            String sqlselect = "select * from dept";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqlselect);
            while (rs.next()){
                String num = rs.getString("DEPT_NO");
                String nom = rs.getString("DNOMBRE");
                String loc = rs.getString("LOC");
                %>
                <tr>
                    <td><%=num%></td>
                    <td><%=nom%></td>
                    <td><%=loc%></td>
                </tr>
                <%
            }
            rs.close();
            cn.close();
            %>                
            </tbody>
        </table>
    </body>
</html>
