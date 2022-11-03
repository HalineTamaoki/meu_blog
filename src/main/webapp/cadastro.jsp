<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>

<%
    String validacao="";
    if(DaoUsuario.isEmailCorretoCadastro()){
        validacao= "'hide'";
    }
    else{
        validacao="'pl-custom-failmsg'";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - Cadastro</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-cadastro.css">
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="deslogar.jsp">Voltar para página inicial</a>
    </header>

    <section class="d-flex justify-content-center">
        <div class="pl-custom-container">
            <h1 class="text-center mb-4 display-5">Cadastrar</h1>

            <form action="cadastro.jsp" method="POST" id="form-cadastro">
                <p class="custom-p-avatar">Escolha o seu avatar:</p>

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

                <div>
                    <label class="form-label mt-3">Nome</label>
                    <input class="form-control" required type="text" name="nome" maxlength="100"/>
                </div>

                <div>
                    <label class="form-label mt-3">Sobrenome</label>
                    <input class="form-control" required type="text" name="sobrenome" maxlength="100"/>
                </div>

                <div>
                    <label class="form-label mt-3">Email</label>
                    <input class="form-control" required type="email" name="email" maxlength="100"/>
                    <p class=<%out.write(validacao);%>>Erro. Este e-mail já está cadastrado</p>
                </div>
                <div>
                    <label class="form-label mt-3">Senha</label>
                    <input class="form-control" required type="password" name="senha1" id="senha1" onchange="conferirSenhasCoincidem()" maxlength="50"/>
                </div>
                <div>
                    <label class="form-label mt-3">Repita a senha</label>
                    <input class="form-control" required type="password" name="senha2" id="senha2" onchange="conferirSenhasCoincidem()" maxlength="50"/>
                    <p class="pl-custom-failmsg hide" id="pl-custom-failmsg-senha2">As senhas não coincidem</p>
                </div>
                <div class="d-flex mt-5 justify-content-between align-items-center">
                    <button class="btn custom-btn" onclick="formSubmit()">Criar conta</button>
                </div>
            </form>
        </div>
        <script>
            function conferirSenhasCoincidem(){
                const senha1= document.getElementById("senha1").value;
                const senha2= document.getElementById("senha2").value;
                let retorno = false;

                if(senha2.length>0&&senha1!=senha2){
                    document.getElementById("pl-custom-failmsg-senha2").classList.remove('hide')
                    retorno = false
                }
                else if(senha1==senha2){
                    document.getElementById("pl-custom-failmsg-senha2").classList.add('hide')
                    retorno = true
                }
                return retorno
            }
            function formSubmit(){
                const form= document.getElementById('form-cadastro')
                if(!form.checkValidity()){
                return}
                event.preventDefault()
                if(!conferirSenhasCoincidem()){return}
                else{form.submit()}
            }
        </script>

        <%
            String avatar = request.getParameter("avatar");
            int avatarNum = 0;
            String nome = request.getParameter("nome");
            String sobrenome = request.getParameter("sobrenome");
            String email = request.getParameter("email");
            String senha = request.getParameter("senha1");

            if(nome!=null){
                if(avatar!=null){
                    avatarNum = Integer.parseInt(avatar);
                }

                if(DaoUsuario.isEmailDisponivel(email)){
                    Usuario u = new Usuario(nome, sobrenome, avatarNum, email, senha, false);
                    DaoUsuario.criarUsuario(u);
                    int idConsulta = DaoUsuario.consultarId(email);
                    u.setId(idConsulta);
                    DaoUsuario.setUsuarioLogado(u);
                    session.setAttribute("usuario","comumLogado");
                    response.sendRedirect("index.jsp");
                }
                else{
                    response.sendRedirect("cadastro.jsp");
                }
            }

        %>

    </section>

    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>