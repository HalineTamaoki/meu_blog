<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>
<%@page import="com.blog.entidades.Comentario"%>
<%@ page import ="java.util.List"%>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    Post p = DaoPosts.consultarPost(id);
    List<Comentario> listaComentario = DaoComentario.consultarComentarioPostAprovado(id);
%>
<%
    String headerLogar = "";
    String headerAdm = "'hide'";
    String headerUser = "'hide'";
    String nomeUser = "";
    Boolean isLogado = false;
    int idUser = 0;
    Usuario uLogado = DaoUsuario.getUsuarioLogado();

    if(uLogado!=null){
        isLogado=true;
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
    <title>Meu blog - <%out.write(""+p.getTitulo());%></title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-post.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="index.jsp">Voltar para página inicial</a>
        <a href="gerenciamento.jsp" class=<%out.write(headerAdm);%>>Ir para página de Gerenciamento</a>
        <a href="login.jsp" class=<%out.write(headerLogar);%>><img src="./image/login.png" alt="Logar ou cadastrar" class="mx-3">Logar/Cadastrar</a>
        <div class=<%out.write(headerUser);%>>
            <a class="dropdown-toggle mx-3" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Olá, <%out.write(nomeUser);%></a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href=<%out.write("perfil.jsp?id="+idUser);%>>Perfil</a></li>
                <li><a class="dropdown-item" href="deslogar.jsp">Deslogar</a></li>
            </ul>
        </div>
    </header>

    <section>
        <div class="section-title text-start">
            <h1><%out.write(""+p.getTitulo());%></h1>
            <p>Publicado em <%out.write(""+p.getData());%></p>
        </div>
        <div class="mb-5">
            <p><%out.write(""+p.getTexto());%></p>
        </div>
        <p class="text-end px-3">Gostou? 😄 Então comente abaixo!</p>
        <hr />
        <div>
            <p class="fs-5 mt-3 text-decoration-underline">Comentários:</p>
            <p class=<%if(!listaComentario.isEmpty()){out.write("'hide'");};%>>Ainda não tem nenhum comentário 🙁</p>
            <div class=<%if(listaComentario.isEmpty()){out.write("'hide'");}
                            else{out.write("'mb-3'");};%>>

                <%
                    for(Comentario c:listaComentario){
                        out.write("<div class='card pp-custom-card'>"+
                                       "<img src='./image/avatar/"+c.getUsuario().getAvatarNum()+".png' alt='imagem do avatar'>"+
                                       "<div>"+
                                           "<p class='card-title'>Postado por "+c.getUsuario().getNome()+" "+c.getUsuario().getSobrenome()+", em "+c.getDataComentario()+"</p>"+
                                           "<p class='card-text'>"+c.getComentario()+"</p>"+
                                       "</div>"+
                                   "</div>");
                    }
                %>
        </div>
        <button class="btn custom-btn mb-1" onclick=<%out.write("'abrirPopup("+isLogado+")'");%>>Deixe aqui seu comentário</button>
        <p style="font-size:0.9em;">Seu comentário será exibido neste post após a aprovação de um administrador</p>

    </section>

    <div class="custom-popup-logar hide" id="custom-popup-logar">
        <div class="text-end">
            <button type="button" class="btn-close" onclick="abrirPopup(false)"></button>
        </div>
        <div>
          <p>Para comentar é necessário efetuar o login.</p>
          <form action="login.jsp" method="POST">
            <button class="btn custom-btn" name="irParaLogin" value="true">CLIQUE AQUI</button></form>
        </div>
        <%
            String irParaLogin = request.getParameter("irParaLogin");
            if(irParaLogin!=null){
                DaoUsuario.deslogar();
            }
        %>
    </div>

    <div class="custom-popup-comentar hide" id="custom-popup-comentar">
        <div class="d-flex justify-content-between">
            <strong>Comentar</strong>
            <button type="button" class="btn-close" onclick="abrirPopup(true)"></button>
        </div>
        <div class="text-start">
            <form action="post.jsp" method="GET">
                <%out.write("<input class='hide' name='id' value='"+id+"' />");%>

                <div class="mt-3">
                    <label for="comentario" class="form-label">Escreva seu comentário abaixo: </label>
                    <textarea class="form-control" id="comentario-input" name="comentario" rows="6" maxlength="255"></textarea>
                </div>
                <button class="btn mt-3 pp-custom-btn">Enviar para aprovação</button>
            </form>
        </div>
    </div>

    <%
        String comentario = request.getParameter("comentario");
        if(comentario!=null){
            DaoComentario.criarComentario(id, idUser, comentario);
            response.sendRedirect("post.jsp?id="+id);
        }
    %>

    <script>
        function abrirPopup(logado){
            let endereco = document.getElementById("custom-popup-logar")
            if(logado){
                endereco = document.getElementById("custom-popup-comentar")
            }
            endereco.classList.toggle('hide')
        }
    </script>
    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>