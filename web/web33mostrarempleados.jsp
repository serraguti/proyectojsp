<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.ArrayList"%>
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
        <title>Mostrar empleados almacenados</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Mostrar empleados almacenados</h1>
                    <a href="web33almacenarempleados.jsp">
                        Almacenar empleados
                    </a>
                    <%
                    //session.setAttribute("EMPLEADOS", null);
                    String dato = request.getParameter("eliminar");
                    if (dato != null){
                        int idempleado = Integer.parseInt(dato);
                        ArrayList<Integer> idempleados = (ArrayList)
                                session.getAttribute("EMPLEADOS");
                        //DEBEMOS ELIMINAR EL EMPLEADO QUE HA VENIDO
                        idempleados.remove((Integer)idempleado);
                        //SI HEMOS ELIMINADO TODOS LOS EMPLEADOS
                        //ELIMINAMOS LA SESSION
                        if (idempleados.size() == 0){
                            session.setAttribute("EMPLEADOS", null);
                        }else{
                            //REFRESCAMOS LOS VALORES DE LA SESSION
                            session.setAttribute("EMPLEADOS", idempleados);                        
                        }
                    }
                       
                    if (session.getAttribute("EMPLEADOS") == null){
                        //NO EXISTE
                        %>
                        <h1 style="color:red">
                            No existen empleados almacenados
                        </h1>
                        <%
                    }else{
                        //RECUPERAMOS LOS EMPLEADOS ALMACENADOS
                        ArrayList<Integer> empleados =
                            (ArrayList)session.getAttribute("EMPLEADOS");
                        //TENEMOS MULTIPLES IDs DE EMPLEADOS
                        //DEBEMOS HACER UNA CONSULTA PARA BUSCAR TODOS
                        //LOS EMPLEADOS POR SU ID
                        //VAMOS A SEPARAR LOS EMPLEADOS POR , PARA
                        //HACER UNA CONSULTA IN ()
                        // select * from emp where emp_no in (888,999)
                        //PARA PODER UTILIZAR join Y SEPARAR UN STRING POR COMAS
                        //ES NECESARIO TENER UN ARRAY, NOSOTROS TENEMOS UNA COLECCION
                        //CONVERTIR LA COLECCION EN ARRAY DE STRING
                        String datos = "";
                        for (int id: empleados){
                            datos += id + ",";
                        }
                        int ultimacoma = datos.lastIndexOf(",");
                        datos = datos.substring(0,ultimacoma);
                        String sqlselect = 
                            "select * from emp where emp_no in (" + datos + ")";
                        Statement st = cn.createStatement();
                        ResultSet rs = st.executeQuery(sqlselect);
                        %>
                        <table class="table table-bordered">
                            <thead>
                                <tr>
                                    <th>Apellido</th>
                                    <th>Oficio</th>
                                    <th>Salario</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>                    
                        <%
                        while (rs.next()){
                            String ape = rs.getString("APELLIDO");
                            String ofi = rs.getString("OFICIO");
                            String sal = rs.getString("SALARIO");
                            String id = rs.getString("EMP_NO");
                            %>
                            <tr>
                                <td><%=ape%></td>
                                <td><%=ofi%></td>
                                <td><%=sal%></td>
                                <td>
                                    <a class="btn btn-danger"
                                        href="web33mostrarempleados.jsp?eliminar=<%=id%>">
                                        Quitar
                                    </a>
                                </td>
                            </tr>
                            <%
                        }
                        %>
                            </tbody>
                        </table>
                        <%
                        rs.close();
                        cn.close();
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
