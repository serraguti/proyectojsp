<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
                    <h1>Detalles</h1>
                    <a href="web34hospitales.jsp">
                        Hospitales
                    </a>
                    <%
                    //RECIBIMOS idempleado Y BUSCAMOS AL EMPLEADO
                    //CON SU ID Y LO DIBUJAMOS
                    //EN ESTA MISMA PAGINA, RECIBIMOS UN PARAMETRO
                    //LLAMADO almacenar CON EL ID DEL EMPLEADO
                    //Y LO DEBEMOS GUARDAR EN SESSION
                    String dato = request.getParameter("idempleado");
                    if (dato == null){
                        %>
                        <h1 style="color:red">
                            No hemos recibido Id Empleado
                        </h1>
                        <%
                    }else{
                        int idempleado = Integer.parseInt(dato);
                        String codigo = request.getParameter("hospital");
                        String sql = "select * from empleadoshospital where idempleado=?";
                        PreparedStatement pst = cn.prepareStatement(sql);
                        pst.setInt(1, idempleado);
                        ResultSet rs = pst.executeQuery();
                        rs.next();
                        String apellido = rs.getString("APELLIDO");
                        String especialidad = rs.getString("FUNCION");
                        %>
                        <a href="web34empleadoshospital.jsp?hospital=<%=codigo%>">
                            Volver a empleados hospital
                        </a>
                        <h1>Doctor <%=apellido%></h1>
                        <h2>Hospital <%=codigo%></h2>
                        <h2>Especialidad <%=especialidad%></h2>
                        <%
                        ArrayList<String> lista = (ArrayList)
                            session.getAttribute("ALMACENADOS");
                        if (lista == null){
                            %>
                            <a class="btn btn-info"
                               href="web34carritoempleados.jsp?almacenar=<%=idempleado%>">
                                Almacenar empleado
                            </a>
                            <%
                        }else{
                            if (lista.contains(dato)){
                                %>
                                <h4 style="color:blue">Empleado almacenado</h4>
                                <img src="images/ok.png" alt="" style="width: 25px; height: 25px"/>
                                <%                                
                            }else{
                                %>
                                <a class="btn btn-info"
                                   href="web34carritoempleados.jsp?almacenar=<%=idempleado%>">
                                    Almacenar empleado
                                </a>
                                <%
                            }
                        }
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
