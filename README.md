<img src="https://raw.githubusercontent.com/HalineTamaoki/meu_blog/main/src/main/webapp/image/pagina-inicial.png" alt="Imagem da página inicial do blog">

# Blog

Esse projeto foi desenvolvido como atividade avaliativa de JSP do curso da Proway junto à T-Systems. Ele consiste em um blog, com opção de gerenciamento por um administrador.

## Como executar
A fim de executar corretamente, siga os passos abaixo:
1. Crie um banco de dados MySQL. Você pode criar com o mesmo nome usado no projeto usando o código abaixo no servidor de banco de dados:
``` 
CREATE SCHEMA `meu_blog`;
```

2. No arquivo Conexao.java ([src\main\java\com\blog\util](https://github.com/HalineTamaoki/meu_blog/blob/main/src/main/java/com/blog/util/Conexao.java)):
  1. Na linha 11, insira o link para seu banco de dados. Caso haja criado com o mesmo nome do meu, não é necessário alterar.
  2. Na linha 12 insira o seu usuário para acesso ao seu banco, e na 13, substitua "xxx

## Funcionalidades
Cada tipo de usuário terá funcionalidades distintas de acordo com o permissionamento:
- Usuário comum não cadastrado: pode ver os posts e seus comentários. Pode logar ou se cadastrar.
- Usuário comum cadastrado: pode ver os posts e seus comentários. Pode comentar, ver seu perfil e modificá-lo.
- Administrador: além das funcionalidades do usuário comum cadastrado, pode gerenciar comentários e posts. Pode aprovar ou reprovar os comentários enviados para que seja ou não exibido.

## Outros detalhes:
- Na página inicial são listadas as dez últimas postagens registradas. Exibe-se o título e os primeiros quinze caracteres do texto principal da postagem (considerando espaços) e um botão
para ter acesso a postagem completa.
- Quando clicado para ver a postagem completa, a página exibe o título, texto e abaixo de cada postagem, os comentários, e um botão para comentar. O comentário só é exibido após a aprovação do administrador. 
- O administrador pode criar, listar, alterar e remover postagens.
- Foi implementado o uso de sessões para validar as páginas. Isso permite que apenas as funcionalidades por tipo de usuário funcionem.

Espero que gostem! 😃
