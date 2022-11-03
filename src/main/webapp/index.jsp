<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>
<%@ page import ="java.util.List"%>

<%
    DaoUsuario.createTable();
    DaoPosts.createTable();
    DaoComentario.createTable();
    String headerLogar = "";
    String headerAdm = "'hide'";
    String headerUser = "'hide'";
    String nomeUser = "";
    int idUser = 0;
    Usuario uLogado = DaoUsuario.getUsuarioLogado();

    if(uLogado!=null){
        nomeUser = uLogado.getNome();
        idUser = uLogado.getId();
        headerLogar = "'hide'";
        headerUser = "";
        if(uLogado.isAdministrador()){
            headerAdm = "";
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - página inicial</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-inicial.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <header class="d-flex justify-content-end align-items-center">
        <a href="gerenciamento.jsp" class=<%out.write(headerAdm);%>>Ir para página de Gerenciamento</a>
        <a href="login.jsp" class=<%out.write(headerLogar);%>><img src="./image/login.png" alt="Logar ou cadastrar" class="mx-3">Logar/Cadastrar</a>
        <div class=<%out.write(headerUser);%>>
            <a class="dropdown-toggle mx-3" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Olá, <%out.write(""+nomeUser);%></a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href=<%out.write("perfil.jsp?id="+idUser);%>>Perfil</a></li>
                <li><a class="dropdown-item" href="deslogar.jsp">Deslogar</a></li>
            </ul>
        </div>
    </header>
    <div class="pi-cover">
        <img src="./image/pagina-inicial.png" alt="">
    </div>
    <section>
        <div class="section-title">
            <h1>MEU BLOG</h1>
            <h2>ÚLTIMAS HISTÓRIAS</h2>
        </div>

        <%
            List<Post> listaPost = DaoPosts.consultar10();

            if(listaPost.size()==0){
                out.write("<p class='text-center fs-5'>Ainda não temos nenhum post 🙁</p>");
            }
            else{
                out.write("<div class='pi-posts-container'>");
                for(Post p:listaPost){
                    out.write("<div class='card custom-pi-card'>"+
                                    "<h5 class='card-title fw-bold'>"+p.getTitulo()+"</h5>"+
                                    "<p class='card-text'>"+p.getTextoCaracteres(15)+"</p>"+
                                    "<a href='post.jsp?id="+p.getId()+"' class='btn'>Ver matéria completa</a>"+
                                    "</div>");
                }
                out.write("</div><div class='pi-custom-a'>"+
                    "<a href='historias.jsp' class='btn'>Ver todas as postagens</a>"+
                    "</div>");
            }
        %>
    </section>

    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>