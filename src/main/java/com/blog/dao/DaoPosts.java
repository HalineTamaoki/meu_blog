package com.blog.dao;

import com.blog.entidades.Post;
import com.blog.entidades.Usuario;
import com.blog.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DaoPosts {

    public static void createTable(){
        Connection con = Conexao.conectar();

        if (con!=null) {
            String sql = "create table if not exists posts (" +
                            "id int primary key auto_increment," +
                            "titulo varchar(255)," +
                            "texto varchar(10000),"+
                            "dataPost date default (current_date()));";
            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.execute();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public static boolean salvar(){
        return false;
    }

    public static List<Post> consultar(){
        List<Post> listaPost = new ArrayList<Post>();
        Connection con = Conexao.conectar();

        try {
            PreparedStatement stm = con.prepareStatement("select * from posts");
            ResultSet rs = stm.executeQuery();
            while (rs.next()){
                Post p = new Post();
                p.setId(rs.getInt("id"));
                p.setTitulo(rs.getString("titulo"));
                p.setTexto(rs.getString("texto"));
                p.setData(rs.getDate("dataPost"));
                listaPost.add(p);
            }
        } catch (SQLException e) {
            return listaPost;
        }
        return listaPost;
    }

    public static List<Post> consultarInvertido(){
        List<Post> lista1 = consultar();
        List<Post> lista2 = new ArrayList<Post>();
        int i = lista1.size() -1;

        for (Post p:lista1){
            lista2.add(lista1.get(i));
            i--;
        }
        return lista2;
    }

    public static List<Post> consultar10(){
        List<Post> lista1 = consultar();
        List<Post> lista2 = new ArrayList<Post>();
        int i = lista1.size() -1;

        for (Post p:lista1){
            if (lista2.size()==10){
                return lista2;
            }
            lista2.add(lista1.get(i));
            i--;
        }
        return lista2;
    }

    public static Post consultarPost(int id){
        Connection con = Conexao.conectar();
        Post p = new Post();

        try {
            PreparedStatement stm = con.prepareStatement("select * from posts where id=?");
            stm.setInt(1,id);
            ResultSet rs = stm.executeQuery();

            if (rs.next()){
                p.setId(rs.getInt("id"));
                p.setTitulo(rs.getString("titulo"));
                p.setTexto(rs.getString("texto"));
                p.setData(rs.getDate("dataPost"));
            }

        } catch (SQLException e) {
            return p;
        }

        return p;
    }

    public static void criarPost(String titulo, String texto){
        Connection con = Conexao.conectar();

        String sql = "insert into posts(titulo, texto) values (?,?);";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, titulo);
            stm.setString(2, texto);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void alterarPost(Post p){
        Connection con = Conexao.conectar();

        String sql = "update posts set titulo=?, texto=? where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, p.getTitulo());
            stm.setString(2, p.getTexto());
            stm.setInt(3, p.getId());

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void excluirPost(int id){
        Connection con = Conexao.conectar();

        String sql = "delete from posts where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
