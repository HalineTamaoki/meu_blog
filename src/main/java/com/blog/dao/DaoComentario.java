package com.blog.dao;

import com.blog.entidades.Comentario;
import com.blog.entidades.Post;
import com.blog.entidades.Usuario;
import com.blog.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoComentario {

    public static void createTable(){
        Connection con = Conexao.conectar();

        if (con!=null) {
            String sql = "create table if not exists comentarios ("+
                        "id int primary key auto_increment,"+
                        "idPost int,"+
                        "idUsuario int,"+
                        "comentario varchar(255),"+
                        "dataComentario date default (current_date()),"+
                        "situacao varchar (30),"+
                        "constraint fk_post foreign key (idPost) references posts(id),"+
                        "constraint fk_usuario foreign key (idUsuario) references usuarios(id));";

            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.execute();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public static List<Comentario> consultar(){
        List<Comentario> listaComentario = new ArrayList<Comentario>();
        Connection con = Conexao.conectar();

        try {
            PreparedStatement stm = con.prepareStatement("select c.id as idComent, p.id as idPost, u.id as idUsuario, c.comentario, c.dataComentario, c.situacao, p.titulo, u.nome, u.sobrenome\n" +
                                                                "from comentarios c\n" +
                                                                "inner join posts p on c.idPost = p.id\n" +
                                                                "inner join usuarios u on u.id=c.idUsuario\n"+
                                                                "order by c.id DESC;");
            ResultSet rs = stm.executeQuery();
            while (rs.next()){
                Comentario c = new Comentario();
                Usuario u = new Usuario();
                Post p = new Post();
                c.setId(rs.getInt("idComent"));
                p.setId(rs.getInt("idPost"));
                u.setId(rs.getInt("idUsuario"));
                c.setComentario(rs.getString("comentario"));
                c.setDataComentario(rs.getDate("dataComentario"));
                c.setSituacao(rs.getString("situacao"));
                p.setTitulo(rs.getString("titulo"));
                u.setNome(rs.getString("nome"));
                u.setSobrenome(rs.getString("sobrenome"));
                c.setUsuario(u);
                c.setPost(p);
                listaComentario.add(c);
            }

            return listaComentario;
        } catch (SQLException e) {
            return listaComentario;
        }
    }

    public static List<Comentario> consultarComentarioPostAprovado(int id){
        Connection con = Conexao.conectar();
        List<Comentario> listaComentario = new ArrayList<Comentario>();

        try {
            PreparedStatement stm = con.prepareStatement("select c.id as idComent, c.comentario, c.dataComentario, u.avatarNum, u.nome, u.sobrenome\n" +
                                                            "from comentarios c\n" +
                                                            "inner join posts p on c.idPost = p.id\n" +
                                                            "inner join usuarios u on u.id=c.idUsuario\n" +
                                                            "where p.id=? and situacao='Aprovado';");
            stm.setInt(1,id);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Comentario c = new Comentario();
                Usuario u = new Usuario();
                c.setId(rs.getInt("idComent"));
                c.setComentario(rs.getString("comentario"));
                c.setDataComentario(rs.getDate("dataComentario"));
                u.setAvatarNum(rs.getInt("avatarNum"));
                u.setNome(rs.getString("nome"));
                u.setSobrenome(rs.getString("sobrenome"));
                c.setUsuario(u);
                listaComentario.add(c);
            }

            return listaComentario;
        } catch (SQLException e) {
            return listaComentario;
        }
    }

    public static List<Comentario> consultarComentarioAguardandoAprovacao(){
        Connection con = Conexao.conectar();
        List<Comentario> listaComentario = new ArrayList<Comentario>();

        try {
            PreparedStatement stm = con.prepareStatement("select c.id as idComent, c.comentario, c.dataComentario, u.nome, u.sobrenome, p.titulo\n" +
                    "from comentarios c\n" +
                    "inner join posts p on c.idPost = p.id\n" +
                    "inner join usuarios u on u.id=c.idUsuario\n" +
                    "where c.situacao='Aguardando Aprovação';\n");
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Comentario c = new Comentario();
                Usuario u = new Usuario();
                Post p = new Post();
                c.setId(rs.getInt("idComent"));
                c.setComentario(rs.getString("comentario"));
                c.setDataComentario(rs.getDate("dataComentario"));
                u.setNome(rs.getString("nome"));
                u.setSobrenome(rs.getString("sobrenome"));
                p.setTitulo(rs.getString("titulo"));
                c.setUsuario(u);
                c.setPost(p);
                listaComentario.add(c);
            }

            return listaComentario;
        } catch (SQLException e) {
            return listaComentario;
        }
    }

    public static void criarComentario(int idPost, int idUsuario, String comentario){
        Connection con = Conexao.conectar();

        String sql = "insert into comentarios(idPost, idUsuario, comentario, situacao) values (?,?,?,?);";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idPost);
            stm.setInt(2, idUsuario);
            stm.setString(3, comentario);
            stm.setString(4, "Aguardando Aprovação");

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void alterarSituacao(int idComentario, String situacao){
        Connection con = Conexao.conectar();

        String sql = "update comentarios set situacao=? where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, situacao);
            stm.setInt(2, idComentario);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void excluirComentarioPost(int idPost){
        Connection con = Conexao.conectar();

        String sql = "delete from comentarios where idPost=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idPost);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void excluirComentarioUsuario(int idUsuario){
        Connection con = Conexao.conectar();

        String sql = "delete from comentarios where idUsuario=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, idUsuario);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}
