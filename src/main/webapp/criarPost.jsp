<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.blog.dao.DaoPosts"%>
<%@page import="com.blog.entidades.Post"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Meu blog - Escrever Posts</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Secular+One">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
    <link rel="stylesheet" href="./css/style.css">
    <link rel="stylesheet" href="./css/pagina-gerenciamento.css">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3" crossorigin="anonymous"></script>
</head>
<body>
    <header class="d-flex justify-content-between align-items-center">
        <a href="gerenciarPost.jsp">Voltar para gerenciamento de Posts</a>
    </header>

    <section>
        <div class="section-title text-start mb-4">
            <h1 class="fs-2">ESCREVER POST</h1>
        </div>
        <form action="criarPost.jsp" method="POST" >
            <div>
                <label for="titulo" class="form-label">Título:</label>
                <input class="form-control mb-4" type="text" id="titulo" name="titulo" placeholder="Digite o título do post" required maxlength="255" />
            </div>
            <div class="mt-3">
                <label for="comentario" class="form-label mb-3">Escreva o texto do post </label>
                <textarea class="form-control" id="comentario-input" name="texto" rows="12" required maxlength="10000"></textarea>
            </div>
            <button class="btn custom-btn mt-4">Publicar</button>
        </form>

        <%
            String titulo = request.getParameter("titulo");
            String texto = request.getParameter("texto");

            if(titulo!=null&&texto!=null){
                DaoPosts.criarPost(titulo,texto);
                response.sendRedirect("gerenciarPost.jsp");
            }
        %>
    </section>
    <footer>
        Developed by @HalineTamaoki
    </footer>
</body>
</html>