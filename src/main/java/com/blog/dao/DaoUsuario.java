package com.blog.dao;

import com.blog.entidades.Usuario;
import com.blog.util.Conexao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DaoUsuario {
    private static boolean loginCorreto = true;
    private static boolean emailCorretoCadastro = true;

    public static void setEmailCorretoCadastro(boolean emailCorretoCadastro) {
        DaoUsuario.emailCorretoCadastro = emailCorretoCadastro;
    }

    public static boolean isLoginCorreto() {
        return loginCorreto;
    }
    public static boolean isEmailCorretoCadastro() {
        return emailCorretoCadastro;
    }

    public static void createTable(){
        Connection con = Conexao.conectar();

        if (con!=null) {
            String sql = "create table if not exists usuarios (" +
                    "id int primary key auto_increment," +
                    "nome varchar(100)," +
                    "sobrenome varchar(100)," +
                    "email varchar(100)," +
                    "avatarNum int," +
                    "administrador boolean,"+
                    "senha varchar(50));";

            try {
                PreparedStatement stm = con.prepareStatement(sql);
                stm.execute();
                if (!existeAdm()){
                    Usuario u = new Usuario("adm","adm",1,"adm@email.com","adm@email.com",true);
                    criarUsuario(u);
                    loginCorreto = true;
                }
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
    }

    public static boolean existeAdm(){
        Connection con = Conexao.conectar();

        String sql = "select * from usuarios where administrador = true;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
            if (rs.next()){
                return true;
            }
            else return false;
        } catch (SQLException e) {
            return false;
        }
    }

    public static void criarUsuario(Usuario u) {
        Connection con = Conexao.conectar();

        String sql = "insert into usuarios(nome, sobrenome, email, avatarNum, administrador, senha) values (?,?,?,?,?,?);";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, u.getNome());
            stm.setString(2, u.getSobrenome());
            stm.setString(3, u.getEmail());
            stm.setInt(4, u.getAvatarNum());
            stm.setBoolean(5, u.isAdministrador());
            stm.setString(6, u.getSenha());

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static Usuario fazerLogin(String email, String senha){
        Connection con = Conexao.conectar();

        String sql = "select * from usuarios where email = ? and senha = ?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            stm.setString(2, senha);
            ResultSet rs = stm.executeQuery();
            if (rs.next()){
                Usuario u = new Usuario();
                u.setId(rs.getInt("id"));
                u.setNome(rs.getString("nome"));
                u.setSobrenome(rs.getString("sobrenome"));
                u.setEmail(rs.getString("email"));
                u.setAvatarNum(rs.getInt("avatarNum"));
                u.setAdministrador(rs.getBoolean("administrador"));

                return u;
            }
            else {
                loginCorreto = false;
                return null;
            }
        } catch (SQLException e) {
            return null;
        }
    }

    public static boolean isEmailDisponivel(String email){
        Connection con = Conexao.conectar();

        String sql = "select * from usuarios where email = ?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()){
                emailCorretoCadastro = false;
                return false;
            }
            else {
                return true;
            }
        } catch (SQLException e) {
            return false;
        }
    }

    public static int consultarId(String email){
        Connection con = Conexao.conectar();
        int result = 0;

        String sql = "select id from usuarios where email = ?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, email);
            ResultSet rs = stm.executeQuery();
            if (rs.next()){
                result=(rs.getInt("id"));
            }
            return result;
        } catch (SQLException e) {
            return result;
        }
    }

    public static void deslogar(){
        loginCorreto=true;
        emailCorretoCadastro = true;
    }

    public static void alterarUsuario(Usuario u){
        Connection con = Conexao.conectar();

        String sql = "update usuarios set nome=?, sobrenome=?, email=?, avatarNum=? where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, u.getNome());
            stm.setString(2, u.getSobrenome());
            stm.setString(3, u.getEmail());
            stm.setInt(4, u.getAvatarNum());
            stm.setInt(5, u.getId());

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void alterarSenhaUsuario(int id, String senha){
        Connection con = Conexao.conectar();

        String sql = "update usuarios set senha=? where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, senha);
            stm.setInt(2, id);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public static void excluirUsuario(int id){
        Connection con = Conexao.conectar();

        String sql = "delete from usuarios where id=?;";
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setInt(1, id);

            stm.execute();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
