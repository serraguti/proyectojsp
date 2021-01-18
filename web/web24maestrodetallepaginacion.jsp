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
        <style>
            ul#menu li {
                display:inline;
            }
        </style>
    </head>
    <body>
        <h1>Maestro detalle hospitales</h1>
        <%
        String sqlhospital = "select * from hospital";
        Statement st = 
            cn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE
            , ResultSet.CONCUR_READ_ONLY);
        ResultSet rs = st.executeQuery(sqlhospital);
        int posicion = 1;
        int ultimo, siguiente, anterior;
        rs.last();
        ultimo = rs.getRow();
        String dato = request.getParameter("posicion");
        if (dato == null){
            siguiente = posicion + 1;
            anterior = 1;
        }else {
            posicion = Integer.parseInt(dato);
            if (posicion == ultimo){
                siguiente = ultimo;
            }else{
                siguiente = posicion + 1;
            }
            if (posicion == 1){
                anterior = 1;
            }else{
                anterior = posicion - 1;
            }
        }
        rs.absolute(posicion);
        String nombre = rs.getString("NOMBRE");
        String direccion = rs.getString("DIRECCION");
        String telefono = rs.getString("TELEFONO");
        String hospitalcod = rs.getString("HOSPITAL_COD");
        rs.close();
        %>
        <dl>
            <dt><b><%=nombre%></b></dt>
            <dd>Dirección: <%=direccion%></dd>
            <dd>Teléfono: <%=telefono%></dd>
        </dl>
        <h3 style="color:blue">
            Hospital <%=posicion%> de <%=ultimo%>
        </h3>
        <ul id="menu">
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=1">Primero</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=anterior%>">anterior</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=siguiente%>">Siguiente</a>
            </li>
            <li>
                <a href="web24maestrodetallepaginacion.jsp?posicion=<%=ultimo%>">Ultimo</a>
            </li>
        </ul>
        <hr/>
        <table border="1">
            <thead>
                <tr>
                    <th>Apellido</th>
                    <th>Especialidad</th>
                </tr>
            </thead>
            <tbody>
                <%
                String sqldoctor = 
                    "select * from doctor where hospital_cod=?";
                PreparedStatement pst = cn.prepareStatement(sqldoctor);
                int codigo = Integer.parseInt(hospitalcod);
                pst.setInt(1, codigo);
                rs = pst.executeQuery();
                while (rs.next()){
                    String ape = rs.getString("APELLIDO");
                    String espe = rs.getString("ESPECIALIDAD");
                    %>
                    <tr>
                        <td><%=ape%></td>
                        <td><%=espe%></td>
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
