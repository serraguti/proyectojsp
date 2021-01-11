<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Recuperar información GET</h1>
        <a href="web02informacionservidor.jsp">Volver a enviar información</a>
        <%
            //LOS PARAMETROS SIEMPRE SE RECUPERAN CON STRING
            //AUNQUE SEAN NUMEROS
            String nombre = request.getParameter("nombre");
            String apellidos = request.getParameter("apellidos");
        %>
        <h1 style="color:blue">&
            Nombre: <%=nombre%>
        </h1>
        <h1 style="color:red">
            Apellidos: <%=apellidos%>
        </h1>
    </body>
</html>
