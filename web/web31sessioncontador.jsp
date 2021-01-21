<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ejemplo simple Session</h1>
        <form method="post">
            <button type="submit">
                Incrementar contador
            </button>
        </form>
        <%
        int contador = 1;
        //NECESITAMOS UN OBJETO SESSION
        HttpSession sesion = request.getSession();
        //DESEAMOS ALMACENAR EL NUMERO DE FORMA PERMANENTE
        //POR LO QUE HAREMOS UNA VARIABLE DE SESSION
        //PERO EL CONTADOR VA A TENER DOS POSIBILIDADES
        //1) QUE TODAVIA NO HEMOS ALMACENADO INFORMACION
        //2) SI HEMOS ALMACENADO INFORMACION, DEBEMOS
        //IGUALAR EL CONTADOR A LA session
        if (sesion.getAttribute("CONTADOR") != null){
            //HEMOS ALMACENADO ALGO PREVIAMENTE
            contador = Integer.parseInt(sesion.getAttribute("CONTADOR").toString());
        }
        %>
        <h1 style="color:red">
            Contador: <%=contador%>
        </h1>
        <%
        contador++;
        //ALMACENAMOS EL NUMERO EN LA SESSION
        sesion.setAttribute("CONTADOR", contador);        
        %>
    </body>
</html>
