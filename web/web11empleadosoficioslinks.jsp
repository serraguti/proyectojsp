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
    DriverManager.getConnection(cadena, "system", "oracle");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Empleados Oficios Links</h1>
        <ul>
            <%
            String sqloficios = "select distinct oficio from emp";
            Statement st = cn.createStatement();
            ResultSet rs = st.executeQuery(sqloficios);
            while (rs.next()){
                String ofi = rs.getString("OFICIO");
                %>
                <li>
                    <a href="web11empleadosoficioslinks.jsp?oficio=<%=ofi%>"><%=ofi%></a>
                </li>
                <%
            }
            rs.close();
            %>
        </ul>
        <%
        String oficio = request.getParameter("oficio");
        if (oficio != null){
            String sqlemp = "select * from emp where lower(oficio)=lower(?)";
            PreparedStatement pst = cn.prepareStatement(sqlemp);
            pst.setString(1, oficio);
            rs = pst.executeQuery();
            %>
            <ul>
            <%
            while (rs.next()){
                String apellido = rs.getString("APELLIDO");
                %>
                <li><%=apellido%></li>
                <%
            }
            %>
            </ul>
            <%
            rs.close();
            cn.close();
        }
        %>
    </body>
</html>
