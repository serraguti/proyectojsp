<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:xe";
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
        String dato = request.getParameter("selectsalacod");
        String nuevonombre = request.getParameter("cajanuevonombre");
        int modificados = -1;
        if (dato != null){
            int codigo = Integer.parseInt(dato);
            String sqlupdate = "update sala set nombre=? where sala_cod=?";
            PreparedStatement pst = cn.prepareStatement(sqlupdate);
            pst.setString(1, nuevonombre);
            pst.setInt(2, codigo);
            modificados = pst.executeUpdate();
        }
        %>
        <h1>Modificar Salas</h1>
        <form method="post">
            <label>Seleccione sala: </label>
            <select name="selectsalacod">
                <%
                String sqlsalas = "select distinct sala_cod, nombre from sala";
                Statement st = cn.createStatement();
                ResultSet rs = st.executeQuery(sqlsalas);
                //NECESITAMOS SABER SI NOS HA MANDADO ALGUN DATO EL USUARIO
                String seleccionado = request.getParameter("selectsalacod");
                while (rs.next()){
                    String salacod = rs.getString("SALA_COD");
                    String nombre = rs.getString("NOMBRE");
                    if (seleccionado == null){
                        //NO HA ENVIADO INFORMACION, NO SELECCIONAMOS NADA
                        %>
                        <option value="<%=salacod%>"><%=nombre%></option>
                        <%
                    }else{
                        //TENEMOS ALGUN DATO PARA SELECCIONAR, DEBEMOS COMPARAR
                        //CON EL VALUE
                        if (seleccionado.equals(salacod)){
                            //SELECCIONAMOS EL ELEMENTO
                            %>
                            <option value="<%=salacod%>" selected><%=nombre%></option>
                            <%
                        }else{
                            //PINTAMOS SIN SELECCIONAR
                            %>
                            <option value="<%=salacod%>"><%=nombre%></option>
                            <%
                        }
                    }
                }
                rs.close();
                cn.close();
                %>
            </select><br/>
            <label>Nuevo nombre: </label>
            <input type="text" name="cajanuevonombre" required/><br/>
            <button type="submit">
                Modificar salas
            </button>
        </form>
        <%
        if (dato != null){
            %>
            <h1 style="color:red">Registros modificados: <%=modificados%></h1>
            <%
        }
        %>
    </body>
</html>
