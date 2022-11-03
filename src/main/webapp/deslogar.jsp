<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>

<%
    DaoUsuario.deslogar();
    response.sendRedirect("index.jsp");
%>