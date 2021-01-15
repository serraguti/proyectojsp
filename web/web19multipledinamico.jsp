<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
String[] ingredientes = new String[] 
        {"Sal", "Azucar", "Leche", "Mandarinas", "Cacao", "Avellanas"};
//RECUPERAMOS LOS ELEMENTOS SELECCIONADOS
String[] datosseleccionados = request.getParameterValues("ingrediente");
//CREAMOS UNA COLECCION PARA SIMPLIFICAR EL CODIGO
ArrayList<String> listaseleccion = new ArrayList<>();
//SI EXISTEN ELEMENTOS SELECCIONADOS, LOS COPIAMOS A LA COLECCION
//PARA TRABAJAR POSTERIORMENTE EN EL DIBUJO
if (datosseleccionados != null){
    for (String dato: datosseleccionados){
        listaseleccion.add(dato);
    }
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Ingredientes de la nocilla</h1>
        <form method="post">
            <ul>
                <%
                for (String ing: ingredientes){
                    if (listaseleccion.size() == 0){
                        //DIBUJAMOS SIN SELECCIONAR
                        %>
                        <li>
                            <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                        </li>
                        <%                        
                    }else{
                        //PREGUNTAMOS SI EXISTE ALGUN DATO EN LA LISTA DE SELECCION
                        if (listaseleccion.contains(ing)){
                            //SELECCIONAMOS
                            %>
                            <li>
                                <input type="checkbox" name="ingrediente" value="<%=ing%>" checked/><%=ing%>
                            </li>
                            <%
                        }else{
                            //SIN SELECCION
                            %>
                            <li>
                                <input type="checkbox" name="ingrediente" value="<%=ing%>"/><%=ing%>
                            </li>
                            <%
                        }
                    }
                }
                %>
            </ul>
            <button type="submit">Mostrar seleccionados</button>
        </form>
        <hr/>
        <%
        String[] datos = request.getParameterValues("ingrediente");
        if (datos != null){
            for (String dato: datos){
                %>
                <h3 style="color:blue"><%=dato%></h3>
                <%
            }
        }
        %>
    </body>
</html>
