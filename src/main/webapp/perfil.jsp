<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>
<%@page import="com.blog.dao.DaoComentario"%>

<%
    String headerAdm = "'hide'";
    Usuario uLogado = (Usuario) session.getAttribute("usuario");

    if(uLogado!=null){
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
    <link rel="stylesheet" href="./css/pagina-perfil.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="index.jsp">Voltar para página inicial</a>
        <a href="gerenciamento.jsp" class=<%out.write(headerAdm);%>>Ir para página de Gerenciamento</a>
        <a href="deslogar.jsp">Deslogar</a>
    </header>
    <section>
        <div class="section-title">
            <h1 class="fs-1 text-decoration-underline">Meu perfil</h1>
        </div>
        <div class="d-flex pp-custom-container">
            <div>
                <img src=<%out.write("'./image/avatar/"+uLogado.getAvatarNum()+".png'");%> alt="">
            </div>
            <div class="pp-custom-container1">
                <div>
                    <b>Nome:</b>
                    <p><%out.write(uLogado.getNome());%></p>
                </div>
                <div class="mt-3">
                    <b>Sobrenome:</b>
                    <p><%out.write(uLogado.getSobrenome());%></p>
                </div>
                <div class="mt-3 mb-4">
                    <b>Email:</b>
                    <p><%out.write(uLogado.getEmail());%></p>
                </div>
                <a class="btn custom-btn" href=<%out.write("'editarPerfil.jsp?id="+uLogado.getId()+"'");%>>Editar meus dados</a>
                <button class="btn custom-btn mx-2" onclick="toggleBtnExcluir()">Excluir minha conta</button>
            </div>
        </div>
    </section>

    <div class="custom-popup-excluir hide" id="custom-popup-excluir">
        <div class="text-end">
            <button type="button" class="btn-close" onclick="toggleBtnExcluir()"></button>
        </div>
        <div>
          <p>Você deseja mesmo excluir sua conta?</p>
        </div>
        <form action="perfil.jsp" method="POST">
            <button class="btn custom-btn" type="submit" name="excluir" value="Sim">Sim</button>
            <button class="btn custom-btn" onclick="toggleBtnExcluir()" type="button">Não</button>
        </form>
    </div>
    <%
        String excluir = request.getParameter("excluir");

        if(excluir!=null){
            DaoComentario.excluirComentarioUsuario(uLogado.getId());
            DaoUsuario.excluirUsuario(uLogado.getId());
            response.sendRedirect("deslogar.jsp");
        }
    %>
    <script>
        function toggleBtnExcluir(){
            document.getElementById("custom-popup-excluir").classList.toggle('hide')
        }
    </script>

</body>
<footer>
    Developed by @HalineTamaoki
</footer>
</html>