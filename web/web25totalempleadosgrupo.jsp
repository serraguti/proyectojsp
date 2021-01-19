<%-- 
Realizar una vista en ORACLE llamada TODOSEMPLEADOS para poder 
mostrar apellido, oficio/funcion/especialidad y salario 
de todos los empleados de la bbdd. 
(Doctor, plantilla y emp)
Paginar dicha vista en grupo.
create view todosempleados
as
       select apellido, oficio, salario
       from emp
       union
       select apellido, especialidad, salario
       from doctor
       union 
       select apellido, funcion, salario
       from plantilla;
--%>

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
    DriverManager.getConnection(cadena,"system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            ul#menu li {
                display: inline;                
            }
        </style>
    </head>
    <body>
        <h1>Paginación todos empleados</h1>
        <%
        String sql = "select * from todosempleados";
        Statement st = 
            cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sql);
        rs.last();
        int numeroregistros = rs.getRow();
        int posicion = 1;
        String dato = request.getParameter("posicion");
        if (dato != null){
            posicion = Integer.parseInt(dato);
        }
        rs.absolute(posicion);
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Oficio</th>
                    <th>Salario</th>
                </tr>
            </thead>
            <tbody>
        <%
        for (int i = 1; i <= 5 && !rs.isAfterLast();i++){
            String apellido = rs.getString("APELLIDO");
            String oficio = rs.getString("OFICIO");
            String salario = rs.getString("SALARIO");
            %>
            <tr>
                <td><%=apellido%></td>
                <td><%=oficio%></td>
                <td><%=salario%></td>
            </tr>
            <%
            rs.next();
        }
        %>
            </tbody>
        </table>
        <%
        rs.close();
        cn.close();
        %>
        <ul id="menu">
            <%
            int numeropagina = 1;
            for (int i = 1; i <= numeroregistros; i+=5){
                %>
                <li>
                    <a href="web25totalempleadosgrupo.jsp?posicion=<%=i%>">
                        <%=numeropagina%>
                    </a>
                </li>
                <%
                numeropagina += 1;
            }
            %>
        </ul>
    </body>
</html>
