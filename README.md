<img src="https://raw.githubusercontent.com/HalineTamaoki/meu_blog/main/src/main/webapp/image/pagina-inicial.png" alt="Imagem da página inicial do blog">

# Blog

Esse projeto foi desenvolvido como atividade avaliativa de JSP do curso da Proway junto à T-Systems. Ele consiste em um blog, com opção de gerenciamento por um administrador.

## Como executar
A fim de executar corretamente, recomendo executar usando o MySQL Workbench, na ordem numérica dos arquivos.

## Funcionalidades
Cada tipo de usuário terá funcionalidades distintas de acordo com o permissionamento:
- Usuário comum não cadastrado: pode ver os posts e seus comentários. Pode logar ou se cadastrar.
- Usuário comum cadastrado: pode ver os posts e seus comentários. Pode comentar, ver seu perfil e modificá-lo.
- Administrador: além das funcionalidades do usuário comum cadastrado, pode gerenciar comentários e posts. Pode aprovar ou reprovar os comentários enviados para que seja ou não exibido.

##Outros detalhes:
- Na página inicial são listadas as dez últimas postagens registradas. Exibe-se o título e os primeiros quinze caracteres do texto principal da postagem (considerando espaços) e um botão
para ter acesso a postagem completa.
- Quando clicado para ver a postagem completa, a página exibe o título, texto e abaixo de cada postagem, os comentários, e um botão para comentar. O comentário só é exibido após a aprovação do administrador. 
- O administrador pode criar, listar, alterar e remover postagens.

Espero que gostem! 😃
