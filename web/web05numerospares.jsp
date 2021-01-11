<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Números Pares</h1>
        <form method="post">
            <label>Número final: </label>
            <input type="number" name="cajafinal" required/>
            <button type="submit">Mostrar pares</button>
        </form>
        <%
        String dato = request.getParameter("cajafinal");
        if (dato != null){
            int numero = Integer.parseInt(dato);
            %>
            <ul>
            <%
            for (int i = 2; i <=numero; i+=2){
                //UNA ETIQUETA <li> POR CADA VUELTA
                %>
                <li> <%=i%> </li>
                <%
            }
            %>
            </ul>
            <%
        }
        %>
    </body>
</html>
