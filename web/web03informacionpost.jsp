<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Información POST</h1>
        <form method="post">
            <label>Nombre: </label>
            <input type="text" name="cajanombre" />
            <button type="submit">Enviar información</button>
        </form>
        <%
            String dato = request.getParameter("cajanombre");
            //DEBEMOS COMPROBAR SI HEMOS RECIBIDO EL DATO ANTES
            //DE PINTARLO
            if (dato != null){
                //DEBEMOS DE PINTAR CODIGO HTML
                //DE JAVA ENTRE HTML
                //DEBEMOS CERRAR JAVA Y ABRIR JAVA
                %>
                <h1 style="color:red">
                    <%=dato%>
                </h1>
                <%
            }
        %>
    </body>
</html>
