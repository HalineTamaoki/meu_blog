<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>
<%@page import="com.blog.entidades.Comentario"%>
<%@ page import ="java.util.List"%>

<%
    Usuario u = DaoUsuario.getUsuarioLogado();
    Usuario uLogado = new Usuario();
    String usuario = (String) session.getAttribute("usuario");
    Boolean administrador = false;

    if(usuario!=null){
       uLogado = u;
       if(usuario.equals("administrador")){
            administrador = true;
       }
    }
    List <Comentario> listaComentarios = DaoComentario.consultar();

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - Gerenciar Comentários</title>
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
        <a href="gerenciarPost.jsp">Gerenciar Posts</a>
        <a class="dropdown-toggle mx-3" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Olá, <%out.write(""+uLogado.getNome());%></a>
        <ul class="dropdown-menu">
            <li><a class="dropdown-item" href=<%out.write("perfil.jsp?id="+uLogado.getId());%>>Perfil</a></li>
            <li><a class="dropdown-item" href="deslogar.jsp">Deslogar</a></li>
        </ul>
    </header>

    <section>
        <div class="section-title text-start mb-4">
            <h1 class="fs-2">MEU BLOG</h1>
            <h2 class="text-decoration-underline fs-4">TODOS OS COMENTÁRIOS</h2>
        </div>
        <div>
          <table class=<%if(!listaComentarios.isEmpty()){
                         out.write("'table'");}
                         else{out.write("'hide'");}%>>
            <thead>
                <tr>
                    <th>Referente a</th>
                    <th class="text-center">Postado por</th>
                    <th class="text-center">Data</th>
                    <th class="text-center">Situação</th>
                    <th class="text-center">Mudar situação</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int i = 0;
                    for(Comentario c: listaComentarios){
                        out.write("<tr>"+
                                  "<td><a href='post.jsp?id="+c.getPost().getId()+"'>"+c.getPost().getTitulo()+"</a></td>"+
                                   "<td class='text-center'>"+c.getUsuario().getNome()+" "+c.getUsuario().getSobrenome()+"</td>"+
                                   "<td class='text-center'>"+c.getDataComentario()+"</td>"+
                                   "<td class='text-center'>"+c.getSituacao()+"</td>"+
                                   "<td class='text-center'><form action='gerenciarComentario.jsp' method='POST'><button class='table-button' name='editar' value='"+c.getId()+"'><img onmouseenter='mudarImagemEditar(true,"+i+")' onmouseleave='mudarImagemEditar(false, "+i+")' src='./image/editar.png' alt='editar item' class='action-img action-editar'/></button></form></th>"+
                                   "</tr>");
                        i++;
                    }

                    String editar = request.getParameter("editar");
                    String editarValue="";
                    if(editar!=null){
                        editarValue = editar;
                    }
                %>

            </tbody>
          </table>
        </div>
        <p class=<%if(!listaComentarios.isEmpty()){out.write("'hide'");}%>>Ainda não existe nenhum comentário 🙁</p>

    </section>
    <div class=<%if(editar!=null){out.write("custom-popup-excluir");}else{out.write("hide");}%>>
        <div class="d-flex justify-content-between mb-3">
            <strong>Alterar Situação</strong>
            <form action="gerenciarComentario.jsp" method="POST"><button class="btn btn-close" name="editar1" value="nao"></button></form>
        </div>
        <div>
        <p>Escolha a situação desejada</p>
        </div>
        <div>
            <form action="gerenciarComentario.jsp" method="POST">
                <button type="submit" class="btn custom-btn custom-btn-popup-aprovar" name="aprovar" value=<%out.write(editarValue);%>>Aprovado</button>
                <button type="submit" class="btn custom-btn custom-btn-popup-reprovar" name="reprovar" value=<%out.write(editarValue);%>>Reprovado</button>
            </form>
        </div>
    </div>
    <%
        String aprovar = request.getParameter("aprovar");
        if(aprovar!=null){
            DaoComentario.alterarSituacao(Integer.parseInt(aprovar),"Aprovado");
            response.sendRedirect("gerenciarComentario.jsp");
        }
        String reprovar = request.getParameter("reprovar");
        if(reprovar!=null){
            DaoComentario.alterarSituacao(Integer.parseInt(reprovar),"Reprovado");
            response.sendRedirect("gerenciarComentario.jsp");
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

    </section

</body>
<footer>
    Developed by @HalineTamaoki
</footer>
</html>