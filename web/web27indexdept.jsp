<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="oracle.jdbc.OracleDriver"%>
<%@page import="java.sql.DriverManager"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
DriverManager.registerDriver(new OracleDriver());
String cadena = "jdbc:oracle:thin:@LOCALHOST:1521:XE";
Connection cn = 
    DriverManager.getConnection(cadena,"system","oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="includes/webhead.jsp"/>
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String eliminar = request.getParameter("eliminar");
        if (eliminar != null){
            int numero = Integer.parseInt(eliminar);
            String sqldelete = "delete from dept where dept_no=?";
            PreparedStatement pst = cn.prepareStatement(sqldelete);
            pst.setInt(1, numero);
            pst.executeUpdate();
        }
        %>
        <jsp:include page="includes/webmenudepartamentos.jsp"/>
        <section>
            <main role="main" class="container">
                <div class="starter-template">
                    <h1>Home departamentos</h1>
                    <%
                    String sql = "select * from dept";
                    Statement st = cn.createStatement();
                    ResultSet rs = st.executeQuery(sql);
                    %>
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Número</th>
                                <th>Nombre</th>
                                <th>Localidad</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                            while (rs.next()){
                                String num = rs.getString("DEPT_NO");
                                String nom = rs.getString("DNOMBRE");
                                String loc = rs.getString("LOC");
                                %>
                                <tr>
                                    <td><%=num%></td>
                                    <td><%=nom%></td>
                                    <td><%=loc%></td>
                                    <td>
                                        <a class="btn btn-primary"
                                           href="web30detailsdept.jsp?deptno=<%=num%>">Detalles</a>
                                        <a href="web29updatedept.jsp?deptno=<%=num%>"
                                              class="btn btn-info">Modificar</a>
                                        <a href="web27indexdept.jsp?eliminar=<%=num%>"
                                           class="btn btn-danger">
                                            Eliminar
                                        </a>
                                    </td>
                                </tr>
                                <%
                            }
                            rs.close();
                            cn.close();
                            %>
                        </tbody>
                    </table>
                </div>
            </main><!-- /.container -->            
        </section>
        <jsp:include page="includes/webfooter.jsp"/>
    </body>
</html>
