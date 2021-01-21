<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <title>Almacenar Empleados</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>ALMACENAR EMPLEADOS</h1>
                    <a href="web33mostrarempleados.jsp">
                        Mostrar empleados almacenados
                    </a>
                    <%
                    //NECESITAMOS ALMACENAR VARIOS ID DE EMPLEADO
                    //VAMOS A RECIBIR UN ID Y LO ALMACENAMOS EN 
                    //UN ARRAYLIST AL RECIBIRLO
                    String dato = request.getParameter("idempleado");
                    if (dato != null){
                        int idempleado = Integer.parseInt(dato);
                        ArrayList<Integer> empleados;
                        //PREGUNTAMOS SI YA TENEMOS EMPLEADOS ALMACENADOS
                        if (session.getAttribute("EMPLEADOS") != null){
                            //RECUPERAMOS LOS EMPLEADOS
                            empleados = (ArrayList)session.getAttribute("EMPLEADOS");
                        }else{
                            //CREAMOS UNA COLECCION PARA ALMACENAR LOS EMPLEADOS
                            empleados = new ArrayList();
                        }
                        //ALMACENAMOS EL IDEMPLEADO QUE VIENE EN LA PETICION
                        empleados.add(idempleado);
                        //GUARDAMOS LOS NUEVOS DATOS EN LA SESSION
                        session.setAttribute("EMPLEADOS", empleados);
                        %>
                        <h1 style="color:blue">Empleados almacenados: <%=empleados.size()%></h1>
                        <%
                    }
                    
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <ul class="list-group">
                        <%
                        while (rs.next()){
                            String ape = rs.getString("APELLIDO");
                            String empno = rs.getString("EMP_NO");
                            %>
                            <li class="list-group-item">
                                <a href="web33almacenarempleados.jsp?idempleado=<%=empno%>">
                                    Almacenar <%=ape%>
                                </a>
                            </li>
                            <%
                        }
                        rs.close();
                        cn.close();
                        %>
                    </ul>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
