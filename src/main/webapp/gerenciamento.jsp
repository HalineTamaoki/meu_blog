<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>
<%@page import="com.blog.entidades.Comentario"%>
<%@ page import ="java.util.List"%>

<%
    Usuario uLogado = (Usuario) session.getAttribute("usuario");
    Boolean administrador = false;

    if(uLogado!=null){
       if(uLogado.isAdministrador()){
            administrador = true;
       }
    }
    List <Comentario> listaAguardando = DaoComentario.consultarComentarioAguardandoAprovacao();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - Gerenciamento</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-gerenciamento.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body onload=<%out.write("'liberarAcesso("+administrador+")'");%>>
    <header class="d-flex justify-content-between align-items-center">
        <a href="index.jsp">Voltar para página inicial</a>
        <a href="gerenciarPost.jsp">Gerenciar Posts</a>
        <a href="gerenciarComentario.jsp">Gerenciar Comentários</a>
        <a class="dropdown-toggle mx-3" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Olá, <%out.write(""+uLogado.getNome());%></a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href=<%out.write("perfil.jsp?id="+uLogado.getId());%>>Perfil</a></li>
            <li><a class="dropdown-item" href="deslogar.jsp">Deslogar</a></li>
        </ul>
    </header>

    <section>
        <div class="section-title text-start">
            <h1 class="fs-2">MEU BLOG</h1>
            <h2 class="text-decoration-underline fs-4">COMENTÁRIOS AGUARDANDO MINHA APROVAÇÃO</h2>
        </div>
        <div class=<%if(listaAguardando.isEmpty()){out.write("'hide'");}%>>
            <%
                for(Comentario c:listaAguardando){
                    out.write("<div class='pg-custom-card'>"+
                                   "<div class='pg-custom-card-div'>"+
                                       "<p>Referente ao post: <span>"+c.getPost().getTitulo()+"</span></p>"+
                                       "<p>Postado por: <span>"+c.getUsuario().getNome()+" "+c.getUsuario().getSobrenome()+"</span></p>"+
                                       "<p>Data: <span>"+c.getDataComentario()+"</span></p>"+
                                       "<p>Comentário: <span>"+c.getComentario()+"</span></p>"+
                                   "</div>"+
                                   "<form action='gerenciamento.jsp' method='POST' class='pg-custom-btn-aprovar d-flex justify-content-center'><button name='aprovar' value='"+c.getId()+"'>Aprovar</button></form>"+
                                   "<form action='gerenciamento.jsp' method='POST' class='pg-custom-btn-reprovar d-flex justify-content-center'><button name='reprovar' value='"+c.getId()+"'>Reprovar</button></form>"+
                               "</div>");
                }
                String idAprovado = request.getParameter("aprovar");
                String idReprovado = request.getParameter("reprovar");

                if(idAprovado!=null){
                    DaoComentario.alterarSituacao(Integer.parseInt(idAprovado),"Aprovado");
                    response.sendRedirect("gerenciamento.jsp");
                }
                if(idReprovado!=null){
                    DaoComentario.alterarSituacao(Integer.parseInt(idReprovado),"Reprovado");
                    response.sendRedirect("gerenciamento.jsp");
                }
            %>
        </div>
        <p class=<%if(!listaAguardando.isEmpty()){out.write("'hide'");}%>>Nenhum comentário precisando de aprovação 😄</p>
    </section>
</body>

<script>
    function liberarAcesso(liberar){
        if(liberar==false){
            document.getElementsByTagName('body')[0].innerHTML=`<header class='d-flex justify-content-between align-items-center'>
                                                                       <a href='index.jsp'>Voltar para página inicial</a>
                                                                   </header>

                                                                   <section>
                                                                      <div class="section-title text-start">
                                                                          <h1 class="fs-1 text-center">ACESSO NEGADO 🙁</h1>
                                                                      </div>
                                                                   </section>`
        }
    }
</script>
<footer>
    Developed by @HalineTamaoki
</footer>
</html>