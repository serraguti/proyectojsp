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
        <h1>Plantilla Radios</h1>
        <form method="post">
            <ul>
                <%
                String sqlfuncion = "select distinct funcion from plantilla";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlfuncion);
                while (rs.next()){
                    String fun = rs.getString("FUNCION");
                    %>
                    <li>
                        <input type="radio" name="funcion" value="<%=fun%>"/><%=fun%>
                    </li>
                    <%
                }
                rs.close();
                %>
            </ul>
            <button type="submit">Mostrar plantilla</button>
        </form>
        <hr/>
        <%
        String funcion = request.getParameter("funcion");
        if (funcion != null){
            String sqlplantilla = "select * from plantilla where funcion=?";
            PreparedStatement pst = cn.prepareStatement(sqlplantilla);
            pst.setString(1, funcion);
            rs = pst.executeQuery();
            %>
            <table border="1">
            <%
            while (rs.next()){
                String ape = rs.getString("APELLIDO");
                String sal = rs.getString("SALARIO");
                %>
                <tr>
                    <td><%=ape%></td>
                    <td><%=sal%></td>
                </tr>
                <%
            }
            rs.close();
            %>
            </table>
            <%
        }
        cn.close();
        %>            
    </body>
</html>
