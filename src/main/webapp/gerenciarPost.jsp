<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>
<%@ page import ="java.util.List"%>

<%
    Usuario uLogado = (Usuario) session.getAttribute("usuario");
    Boolean administrador = false;

    if(uLogado!=null){
       if(uLogado.isAdministrador()){
            administrador = true;
       }
    }

    List<Post> listaPosts = DaoPosts.consultarInvertido();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - Gerenciar Posts</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-gerenciamento.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body onload=<%out.write("'liberarAcesso("+administrador+")'");%>>
    <header class="d-flex justify-content-between align-items-center">
        <a href="index.jsp">Voltar para página inicial</a>
        <a href="gerenciamento.jsp">Voltar para gerenciamento</a>
        <a href="gerenciarComentario.jsp">Gerenciar Comentários</a>
        <a class="dropdown-toggle mx-3" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Olá, <%out.write(""+uLogado.getNome());%></a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href=<%out.write("perfil.jsp?id="+uLogado.getId());%>>Perfil</a></li>
            <li><a class="dropdown-item" href="deslogar.jsp">Deslogar</a></li>
        </ul>
    </header>

    <section>
        <div class="section-title text-start mb-4">
            <h1 class="fs-2">MEU BLOG</h1>
            <h2 class="text-decoration-underline fs-4">TODOS OS POSTS</h2>
        </div>
        <a class="btn custom-btn mb-4" href="criarPost.jsp">Criar post</a>
        <div>
          <table class=<%if(!listaPosts.isEmpty()){
                            out.write("'table'");}
                         else{out.write("'hide'");}%>>
            <thead>
                <tr>
                    <th>Nome</th>
                    <th class="text-center">Data</th>
                    <th class="text-center">Editar</th>
                    <th class="text-center">Excluir</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int i = 0;
                    for(Post p: listaPosts){
                        out.write("<tr>"+
                                  "<td><a href='post.jsp?id="+p.getId()+"'>"+p.getTitulo()+"</a></td>"+
                                   "<td class='text-center'>"+p.getData()+"</td>"+
                                   "<td class='text-center'><form action='gerenciarPost.jsp' method='POST'><button class='table-button' name='editar' value='"+p.getId()+"'><img onmouseenter='mudarImagemEditar(true,"+i+")' onmouseleave='mudarImagemEditar(false, "+i+")' src='./image/editar.png' alt='editar item' class='action-img action-editar'/></button></form></td>"+
                                   "<td class='text-center'><form action='gerenciarPost.jsp' method='POST'><button class='table-button' name='excluir' value='"+p.getId()+"'><img onmouseenter='mudarImagemExcluir(true,"+i+")' onmouseleave='mudarImagemExcluir(false, "+i+")' src='./image/excluir.png' alt='excluir item' class='action-img action-excluir'></button></form></td>"+
                                   "</tr>");
                        i++;
                    }

                    String editar = request.getParameter("editar");
                    if(editar!=null){
                        response.sendRedirect("editarPost.jsp?id="+Integer.parseInt(editar));
                    }
                    String excluir = request.getParameter("excluir");
                    String excluirValue = "";
                    if (excluir!=null){
                        excluirValue = excluir;
                    }
                %>

            </tbody>
          </table>
        </div>
        <p class=<%if(!listaPosts.isEmpty()){out.write("'hide'");}%>>Ainda não existe nenhum post 🙁</p>

    </section>
    <div class=<%if(excluir!=null){out.write("custom-popup-excluir");}else{out.write("hide");}%>>
        <div class="d-flex justify-content-between mb-3">
            <strong>Alerta</strong>
        </div>
        <div>
        <p>Você deseja mesmo excluir esse post e todos os comentários dele?</p>
        </div>
        <div>
            <form action="gerenciarPost.jsp" method="POST">
                <button class="btn custom-btn" name="excluirConfirmado" value=<%out.write(excluirValue);%>>Sim</button>
                <button class="btn custom-btn" name="excluirConfirmado" value="nao">Não</button>
            </form>
        </div>
    </div>
    <%
        String excluirConfirmado = request.getParameter("excluirConfirmado");
        if(excluirConfirmado!=null){
            if(!excluirConfirmado.equals("nao")){
                DaoComentario.excluirComentarioPost(Integer.parseInt(excluirConfirmado));
                DaoPosts.excluirPost(Integer.parseInt(excluirConfirmado));
            }
            response.sendRedirect("gerenciarPost.jsp");
        }
    %>

    <script>
        function mudarImagemEditar(action, id){
            document.getElementsByClassName('action-editar')[id].setAttribute('src',`./image/editar${action?'1':''}.png`)
        }
        function mudarImagemExcluir(action, id){
            document.getElementsByClassName('action-excluir')[id].setAttribute('src',`./image/excluir${action?'1':''}.png`)
        }
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


</body>
<footer>
    Developed by @HalineTamaoki
</footer>
</html>