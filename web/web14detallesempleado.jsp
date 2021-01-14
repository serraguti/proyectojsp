<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <h1>Detalles empleado</h1>
        <form method="post">
            <label>Introduzca Id empleado</label>
            <select name="cajaidempleado">
                <%
                String sqlselect = "select * from emp";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlselect);
                while (rs.next()){
                    String apellido = rs.getString("APELLIDO");
                    String empno = rs.getString("EMP_NO");
                    %>
                    <option value="<%=empno%>"><%=apellido%></option>
                    <%
                }
                rs.close();
                %>
            </select>
            <button type="submit">Buscar empleado</button>
        </form>
        <%
        String dato = request.getParameter("cajaidempleado");
        if (dato != null){
            int idempleado = Integer.parseInt(dato);
            String sqldetalles = "select * from emp where emp_no=?";
            PreparedStatement pst = cn.prepareStatement(sqldetalles);
            pst.setInt(1, idempleado);
            rs = pst.executeQuery();
            if (rs.next()){
                String ape = rs.getString("APELLIDO");
                String ofi = rs.getString("OFICIO");
                String sal = rs.getString("SALARIO");
                %>
                <h1><%=ape%></h1>
                <h2>Oficio: <%=ofi%></h2>
                <h2>Salario: <%=sal%></h2>
                <%
            }else {
                //NO EXISTE EMPLEADO
                %>
                <h1 style="color:red">No existe empleado con id: <%=dato%></h1>
                <%
            }
            rs.close();
            cn.close();
        }
        %>
    </body>
</html>
