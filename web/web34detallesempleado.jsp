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
                    <%
                    //RECIBIMOS idempleado Y BUSCAMOS AL EMPLEADO
                    //CON SU ID Y LO DIBUJAMOS
                    //EN ESTA MISMA PAGINA, RECIBIMOS UN PARAMETRO
                    //LLAMADO almacenar CON EL ID DEL EMPLEADO
                    //Y LO DEBEMOS GUARDAR EN SESSION
                    %>
                    <h1>Doctor House</h1>
                    <h2>Hospital La Paz</h2>
                    <h2>Especialidad Diagnostico</h2>
                    <a class="btn btn-info"
                        href="web34detallesempleado.jsp?almacenar=355">
                        Almacenar empleado
                    </a>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
