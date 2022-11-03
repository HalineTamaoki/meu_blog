<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>

<%
    String headerAdm = "'hide'";
    Usuario uLogado = (Usuario) session.getAttribute("usuario");
    String validacao="'hide'";
    if(!DaoUsuario.isEmailCorretoCadastro()){
        validacao= "'pp-custom-failmsg'";
    }
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
    <title>Meu blog - Editar Perfil</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-perfil.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="voltar.jsp">Voltar para página inicial</a>
        <a href="gerenciamento.jsp" class=<%out.write(headerAdm);%>>Ir para página de Gerenciamento</a>
        <a href="deslogar.jsp">Deslogar</a>
    </header>
    <section id="main-section">
        <div class="section-title">
            <h1 class="fs-1 text-decoration-underline">Meu perfil</h1>
        </div>
        <div class="d-flex pp-custom-container">
            <div class="text-center d-flex flex-column">
                <img src=<%out.write("'./image/avatar/"+uLogado.getAvatarNum()+".png'");%> alt="">
                <button class="pp-custom-container-btn" onclick="toggleAlterarAvatar()">Alterar Avatar</button>
                <button class="pp-custom-container-btn" onclick="toggleAlterarSenha()">Alterar Senha</button>
            </div>
            <form class="pp-custom-container1 w-50" action="editarPerfil.jsp" method="POST">
                <label class="fw-bold">Nome:</label>
                <input type="text" class="form-control" name="nome" maxlength="100" required value=<%out.write("'"+uLogado.getNome()+"'");%>>

                <label class="fw-bold mt-3">Sobrenome:</label>
                <input type="text" class="form-control" name="sobrenome" maxlength="100" required value=<%out.write("'"+uLogado.getSobrenome()+"'");%>>

                <label class="fw-bold mt-3">Email:</label>
                <input type="email" class="form-control" name="email" maxlength="100" required value=<%out.write("'"+uLogado.getEmail()+"'");%>>
                <p class=<%out.write(validacao);%>>Erro. O e-mail que você tentou inserir já está cadastrado</p>

                <button class="btn custom-btn mt-4">Salvar</button>
            </form>
        </div>

        <%
            String nome = request.getParameter("nome");
            String sobrenome = request.getParameter("sobrenome");
            String email = request.getParameter("email");

            if(nome!=null){
                if (!email.equalsIgnoreCase(uLogado.getEmail())){
                    if(!DaoUsuario.isEmailDisponivel(email)){
                        response.sendRedirect("editarPerfil.jsp");
                        return;
                    }
                }

                Usuario user = new Usuario(nome, sobrenome, uLogado.getId(), uLogado.getAvatarNum(), email, uLogado.isAdministrador());
                DaoUsuario.alterarUsuario(user);
                session.setAttribute("usuario",user);
                DaoUsuario.setEmailCorretoCadastro(true);
                response.sendRedirect("perfil.jsp");
            }
        %>
    </section>

    <div class="custom-popup-trocarAvatar hide" id="custom-popup-trocarAvatar">
        <div class="d-flex justify-content-between">
            <strong>Trocar Avatar</strong>
            <button type="button" class="btn-close" onclick="toggleAlterarAvatar()"></button>
        </div>
        <div class="text-start">
            <form action="editarPerfil.jsp" method="POST">
                <label for="comentario" class="form-label mt-3 mb-4">Escolha seu novo avatar</label>
                <div class="custom-avatar-container">
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="1" id="avatar1" required>
                        <label class="form-check-label pc-custom-avatar" for="avatar1">
                          <img src="./image/avatar/1.png" alt="pinguin">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="2" id="avatar2">
                        <label class="form-check-label pc-custom-avatar" for="avatar2">
                          <img src="./image/avatar/2.png" alt="alien">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="3" id="avatar3">
                        <label class="form-check-label pc-custom-avatar" for="avatar3">
                          <img src="./image/avatar/3.png" alt="dinossauro">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="4" id="avatar4">
                        <label class="form-check-label pc-custom-avatar" for="avatar4">
                          <img src="./image/avatar/4.png" alt="monstro">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="5" id="avatar5">
                        <label class="form-check-label pc-custom-avatar" for="avatar5">
                          <img src="./image/avatar/5.png" alt="planta">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="6" id="avatar6">
                        <label class="form-check-label pc-custom-avatar" for="avatar6">
                          <img src="./image/avatar/6.png" alt="pato">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="7" id="avatar7">
                        <label class="form-check-label pc-custom-avatar" for="avatar7">
                          <img src="./image/avatar/7.png" alt="cachorro">
                        </label>
                    </div>

                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="avatar" value="8" id="avatar8">
                        <label class="form-check-label pc-custom-avatar" for="avatar8">
                          <img src="./image/avatar/8.png" alt="caveira">
                        </label>
                    </div>
                </div>
                <button class="btn mt-3 pp-custom-btn">Salvar</button>
            </form>

            <%
                String avatar = request.getParameter("avatar");
                if(avatar!=null){
                    int avatarNum = Integer.parseInt(avatar);
                    Usuario userNewAvatar = new Usuario(uLogado.getNome(), uLogado.getSobrenome(), uLogado.getId(), avatarNum, uLogado.getEmail(), uLogado.isAdministrador());
                    DaoUsuario.alterarUsuario(userNewAvatar);
                    session.setAttribute("usuario",userNewAvatar);
                    response.sendRedirect("perfil.jsp");
                }
            %>
        </div>
    </div>

    <div class="custom-popup-alterarSenha hide" id="custom-popup-alterarSenha">
        <div class="d-flex justify-content-between">
            <strong>Alterar Senha</strong>
            <button type="button" class="btn-close" onclick="toggleAlterarSenha()"></button>
        </div>
        <form id="form-alterar-senha" action="editarPerfil.jsp" method="POST">
            <label class="mt-3 mb-3">Digite a nova senha:</label>
            <input type="password" class="form-control mb-2" name="senha1" id="senha1" required onchange="conferirSenhasCoincidem()" maxlength="50">

            <label>Confirme a nova senha:</label>
            <input type="password" class="form-control mb-2" name="senha2" id="senha2" required onchange="conferirSenhasCoincidem()" maxlength="50">
            <p class="pp-custom-failmsg hide" id="pp-custom-failmsg">Os campos não são iguais</p>
            <button class="btn pp-custom-btn" onclick="formSubmit()">Salvar</button>
        </form>
    </div>
    <%
        String senha1 = request.getParameter("senha1");
        if(senha1!=null){
            DaoUsuario.alterarSenhaUsuario(uLogado.getId(),senha1);
            response.sendRedirect("perfil.jsp");
        }
    %>

    <script>
        function toggleAlterarAvatar(){
            document.getElementById("custom-popup-trocarAvatar").classList.toggle('hide')
            document.getElementById("main-section").classList.toggle('blockScreen')
        }

        function toggleAlterarSenha(){
            document.getElementById("custom-popup-alterarSenha").classList.toggle('hide')
            document.getElementById("main-section").classList.toggle('blockScreen')
        }

        function conferirSenhasCoincidem(){
            const senha1= document.getElementById("senha1").value;
            const senha2= document.getElementById("senha2").value;
            let retorno = false;

            if(senha2.length>0&&senha1!=senha2){
                document.getElementById("pp-custom-failmsg").classList.remove('hide')
                retorno = false
            }
            else if(senha1==senha2){
                document.getElementById("pp-custom-failmsg").classList.add('hide')
                retorno = true
            }
            return retorno
        }

        function formSubmit(){
            const form= document.getElementById('form-alterar-senha')
            if(!form.checkValidity()){
            return}
            event.preventDefault()
            if(!conferirSenhasCoincidem()){return}
            else{form.submit()}
        }
    </script>

    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>