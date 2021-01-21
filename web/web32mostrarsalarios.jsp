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
        <title>Mostrar</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <a href="web32almacenarsalarios.jsp">
                        Almacenar salarios
                    </a>
                    <h1>Mostrar Salarios</h1>
                    <a href="web32mostrarsalarios.jsp?eliminar=ok"
                        class="btn btn-danger">
                           Borrar datos Session
                    </a>
                    <%
                    //SI RECIBIMOS ELIMINAR, BORRAMOS LA SESSION
                    //UNA SESSION SIEMPRE DEBE BORRARSE ANTES DE DIBUJAR
                    if (request.getParameter("eliminar") != null){
                        session.setAttribute("SUMASALARIAL", null);
                    }
                    
                    if (session.getAttribute("SUMASALARIAL")==null){
                        //NO HAY NADA EN LA SESSION
                        %>
                        <h1 style="color:red">
                            No hay datos en Session
                        </h1>
                        <%
                    }else{
                        //TENEMOS DATOS
                        String datos = 
                            session.getAttribute("SUMASALARIAL").toString();
                        %>
                        <h1 style="color:blue">
                            Suma salarial: <%=datos%>
                        </h1>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
