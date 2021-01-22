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
                    <h1>Hospitales</h1>
                    <%
                    //CARGAMOS LOS HOSPITALES
                    %>
                    <ul class="list-group">
                        <li class="list-group-item">
                            <a href="web34empleadoshospital.jsp?hospital=22">
                                La Paz
                            </a>
                        </li>
                        <li class="list-group-item">
                            <a href="web34empleadoshospital.jsp?hospital=18">
                                General
                            </a>
                        </li>
                    </ul>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
