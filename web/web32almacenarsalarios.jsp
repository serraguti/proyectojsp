<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
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
        <title>Almacenar</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <a href="web32mostrarsalarios.jsp">
                        Mostrar suma salarios
                    </a>
                    <h1>Almacenar salarios</h1>
                    <%
                    String sql = "select * from emp";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <ul class="list-group">
                        <%
                        while (rs.next()){
                            String apellido = rs.getString("APELLIDO");
                            String sal = rs.getString("SALARIO");
                            %>
                            <li class="list-group-item">
                                <a href="web32almacenarsalarios.jsp?salario=<%=sal%>">
                                    Almacenar salario <%=apellido%>
                                </a>
                            </li>
                            <%
                        }
                        rs.close();
                        cn.close();
                        %>
                    </ul>
                    <%
                    //VAMOS A ALMACENAR CADA SALARIO QUE VENGA DE FORMA 
                    //PERSISTENTE (session)
                    int sumasalarial;
                    //PREGUNTAMOS SI YA HEMOS RECIBIDO ALGUN DATO
                    //EN SESSION
                    if (session.getAttribute("SUMASALARIAL") != null){
                        //TENEMOS ALGO EN SESSION Y RECUPERAMOS SU VALOR
                        sumasalarial = 
                                (Integer)session.getAttribute("SUMASALARIAL");
                    }else{
                        //NO TENEMOS NADA ALMACENADO Y INICIALIZAMOS LA VARIABLE
                        sumasalarial = 0;
                    }
                    String dato = request.getParameter("salario");
                    if (dato != null) {
                        int salario = Integer.parseInt(dato);
                        //NOS HAN MANDADO UN SALARIO Y LO SUMAMOS
                        //A LA SUMA SALARIAL
                        sumasalarial += salario;
                        //ALMACENAMOS LA SUMA SALARIAL EN LA SESSION
                        //PARA HACERLA PERSISTENTE
                        session.setAttribute("SUMASALARIAL", sumasalarial);
                        %>
                        <h1 style="color:blue">Datos almacenados: <%=salario%></h1>
                        <%
                    }
                    %>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
