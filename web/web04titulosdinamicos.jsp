<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Titulos dinámicos JSP</h1>
        <%
            for (int i = 1; i <=6; i++){
                //CERRAMOS JAVA Y ABRIMOS JAVA
                %>
                <h<%=i%> style="color:blue">Titulo <%=i%></h<%=i%>>
                <%
            }
        %>
        
        <h1>Titulo 1</h1>
        <h2>Titulo 2</h2>
        <h3>Titulo 3</h3>
        <h4>Titulo 4</h4>
        <h5>Titulo 5</h5>
        <h6>Titulo 6</h6>
    </body>
</html>
