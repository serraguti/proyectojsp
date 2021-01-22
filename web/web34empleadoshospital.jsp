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
                    <%
                    //RECIBIMOS UN CODIGO (hospital)
                    //Y BUSCAMOS LOS EMPLEADOS DE ESE HOSPITAL
                    //Y LOS DIBUJAMOS
                    %>
                    <ul class="list-group">
                        <li class="list-group-item">
                            Doctor House. 
                            <a class="btn btn-success"
                                href="web34detallesempleado.jsp?idempleado=355">
                                Detalles
                            </a>
                        </li>
                        <li class="list-group-item">
                            Doctor Cabeza. 
                            <a class="btn btn-success"
                                href="web34detallesempleado.jsp?idempleado=355">
                                Detalles
                            </a>
                        </li>                        
                    </ul>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
