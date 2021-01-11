<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Tabla Multiplicar</h1>
        <form method="post">
            <label>Introduzca un número</label>
            <input type="number" name="cajanumero" required/>
            <button type="submit">Mostrar tabla</button>
        </form>
        <%
        String dato = request.getParameter("cajanumero");
        if (dato != null){
            int numero = Integer.parseInt(dato);
            //SI UTILIZAMOS EL CODIGO JAVA, DEBEMOS
            //ESCRIBIR CON out.println() Y UTILIZAR
            //UNA VARIABLE, TAL Y COMO HEMOS VISTO CON JQUERY O JAVASCRIPT
            String html = "<table border='1'>";
            html += "<tr><th>Operación</th><th>Resultado</th></tr>";
            for (int i = 1; i <= 10; i++){
                int operacion = numero * i;
                html += "<tr>";
                html += "<td>" + numero + "*" + i + "</td>";
                html += "<td>" + operacion + "</td>";
                html += "</tr>";
            }
            html += "</table>";
            out.println(html);
        }
        %>
    </body>
</html>
