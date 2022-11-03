<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoUsuario"%>
<%@page import="com.blog.entidades.Usuario"%>

<%
    String validacao="";
    if(DaoUsuario.isLoginCorreto()){
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
    <title>Meu blog - Login</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-login.css">
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="deslogar.jsp">Voltar para página inicial</a>
    </header>

    <section class="d-flex justify-content-center">
        <div class="pl-custom-container">
            <form action="login.jsp" method="POST">
                <h1 class="text-center mb-4 display-5">Fazer Login</h1>
                <div>
                    <label class="form-label">Email</label>
                    <input class="form-control" required type="email" name="email" maxlength="100"/>
                    <p class=<%out.write(validacao);%>>Credenciais inválidas</p>
                </div>
                <div>
                    <label class="form-label mt-4">Senha</label>
                    <input class="form-control" required type="password" name="senha" maxlength="50"/>
                    <p class=<%out.write(validacao);%>>Credenciais inválidas</p>
                </div>
                <div class="d-flex mt-5 justify-content-between align-items-center">
                    <a href="cadastro.jsp" class="btn" id="custom-button1">Criar conta</a>
                    <button class="btn" id="custom-button2">Avançar</button>
                </div>
            </form>
        </div>

        <%
            String email = request.getParameter("email");
            String senha = request.getParameter("senha");

            if(DaoUsuario.fazerLogin(email, senha)){
                response.sendRedirect("index.jsp");
            }
        %>
    </section>

    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>