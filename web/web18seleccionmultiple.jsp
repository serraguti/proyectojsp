<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Selección múltiple elementos</h1>
        <form method="post">
            <ul>
                <li>
                    <input type="checkbox" name="color"
                           value="rojo"/>Rojo
                </li>
                <li>
                    <input type="checkbox" name="color"
                           value="verde"/>Verde
                </li>
                <li>
                    <input type="checkbox" name="color"
                           value="fuchsia"/>Fuchsia
                </li>
                                <li>
                    <input type="checkbox" name="color"
                           value="amarillo"/>Amarillo
                </li>
            </ul>
            <button type="submit">Mostrar seleccionados</button>
        </form>
        <hr/>
        <%
        //CAPTURAMOS TODOS LOS SELECCIONADOS
        String[] colores = request.getParameterValues("color");
        //LA PREGUNTA ES LA MISMA, SI NO RECIBIMOS NADA ES null
        if (colores != null){
            //RECORREMOS TODO EL ARRAY PARA MOSTRAR LOS DATOS
            for (String color: colores){
                %>
                <h2><%=color%></h2>
                <%
            }
        }
        %>
    </body>
</html>
