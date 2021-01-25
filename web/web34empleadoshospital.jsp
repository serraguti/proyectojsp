<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<!--
create view empleadoshospital
as
       select empleado_no as idempleado,
       apellido, funcion, hospital_cod
       from plantilla
       union
       select doctor_no, apellido
       , especialidad, hospital_cod
       from doctor;
-->
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
                    <h1>Empleados</h1>
                    <a href="web34hospitales.jsp">
                        Volver a Hospitales
                    </a>
                    <%
                    //RECIBIMOS UN CODIGO (hospital)
                    //Y BUSCAMOS LOS EMPLEADOS DE ESE HOSPITAL
                    //Y LOS DIBUJAMOS
                    String dato = request.getParameter("hospital");
                    if (dato == null){
                        %>
                        <h1 style="color:red">No se ha enviado código de hospital</h1>
                        <%
                    }else{
                        String sql = "select * from empleadoshospital where hospital_cod=?";
                        int hospitalcod = Integer.parseInt(dato);
                        PreparedStatement pst = cn.prepareStatement(sql);
                        pst.setInt(1, hospitalcod);
                        ResultSet rs = pst.executeQuery();
                        %>
                        <ul class="list-group">
                            <%
                            while (rs.next()){
                                String apellido = rs.getString("APELLIDO");
                                String idempleado = rs.getString("IDEMPLEADO");
                            %>
                            <li class="list-group-item">
                                <%=apellido%>
                                <a class="btn btn-success"
                                    href="web34detallesempleado.jsp?idempleado=<%=idempleado%>&hospital=<%=dato%>">
                                    Detalles
                                </a>
                            </li>
                        </ul>
                    <%
                        }
                        rs.close();
                        cn.close();
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
