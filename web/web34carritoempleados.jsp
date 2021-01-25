<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.Connection"%>
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
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Carrito</h1>
                    <a href="web34hospitales.jsp">Hospitales</a>
                    <%
                    String datoalmacenar = request.getParameter("almacenar");
                    ArrayList<String> lista;
                    String datoeliminar = request.getParameter("eliminar");
                    if (datoeliminar != null){
                        lista = (ArrayList)session.getAttribute("ALMACENADOS");
                        lista.remove(datoeliminar);
                        if (lista.size() == 0){
                            session.setAttribute("ALMACENADOS", null);
                        }else{
                            session.setAttribute("ALMACENADOS", lista);
                        }
                    }
                    
                    if (datoalmacenar != null){
                        //SI LA BUSQUEDA DE EMPLEADOS FUERA POR PARAMETRO (int)
                        //HAREMOS LA LISTA DE INTEGER
                        //SI LA BUSQUEDA FUERA POR CONCATENACION IN(...)
                        //DA IGUAL INTEGER QUE STRING
                        if (session.getAttribute("ALMACENADOS") == null){
                            lista = new ArrayList();
                        }else{
                            lista = (ArrayList)
                                    session.getAttribute("ALMACENADOS");
                        }
                        lista.add(datoalmacenar);
                        session.setAttribute("ALMACENADOS", lista);
                    }
                    //TANTO SI HEMOS RECIBIDO DATOS PARA ALMACENAR COMO SINO,
                    //PREGUNTAMOS SI EXISTEN DATOS EN SESSION PARA DIBUJAR
                    if (session.getAttribute("ALMACENADOS") != null){
                        lista = (ArrayList)session.getAttribute("ALMACENADOS");
                        String datos = "";
                        for (String id: lista){
                            datos += id + ",";
                        }
                        datos = datos.substring(0, datos.lastIndexOf(","));
                        String sql = "select * from empleadoshospital where idempleado in ("
                                + datos + ")";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sql);
                        %>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Apellido</th>
                                    <th>Función</th>
                                    <th>Hospital</th>
                                    <td></td>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                while (rs.next()){
                                    String ape = rs.getString("APELLIDO");
                                    String fun = rs.getString("FUNCION");
                                    String hosp = rs.getString("HOSPITAL_COD");
                                    String id = rs.getString("IDEMPLEADO");
                                    %>
                                    <tr>
                                        <td><%=ape%></td>
                                        <td><%=fun%></td>
                                        <td><%=hosp%></td>
                                        <td>
                                            <a href="web34carritoempleados.jsp?eliminar=<%=id%>"
                                               class="btn btn-danger">
                                                Quitar de sesión
                                            </a>
                                        </td>
                                    </tr>
                                    <%
                                }
                                rs.close();
                                cn.close();
                                %>
                            </tbody>
                        </table>
                        <%
                    }else{
                        %>
                        <h1 style="color:red">No hay dato en la sesión</h1>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
