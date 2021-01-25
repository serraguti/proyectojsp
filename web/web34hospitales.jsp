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
        <title>JSP Page</title>
    </head>
    <body>
        <jsp:include page="includes/webmenu.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Hospitales</h1>
                    <%
                    //CARGAMOS LOS HOSPITALES
                    String sql = "select * from hospital";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <ul class="list-group">
                        <%
                        while (rs.next()){
                            String codigo = rs.getString("HOSPITAL_COD");
                            String nombre = rs.getString("NOMBRE");
                        %>
                        <li class="list-group-item">
                            <a href="web34empleadoshospital.jsp?hospital=<%=codigo%>">
                                <%=nombre%>
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
