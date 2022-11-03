package com.blog.entidades;

public class Usuario {
    private String nome;
    private String sobrenome;
    private int id;
    private int avatarNum;
    private String email;
    private boolean administrador;
    private String senha;

    public Usuario(String nome, String sobrenome, int avatarNum, String email, String senha, boolean administrador) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.avatarNum = avatarNum;
        this.email = email;
        this.senha = senha;
        this.administrador = administrador;
    }

    public Usuario(String nome, String sobrenome, int id, int avatarNum, String email, boolean administrador) {
        this.nome = nome;
        this.sobrenome = sobrenome;
        this.id = id;
        this.avatarNum = avatarNum;
        this.email = email;
        this.administrador = administrador;
    }

    public Usuario() {
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getSobrenome() {
        return sobrenome;
    }

    public void setSobrenome(String sobrenome) {
        this.sobrenome = sobrenome;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAvatarNum() {
        return avatarNum;
    }

    public void setAvatarNum(int avatarNum) {
        this.avatarNum = avatarNum;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public boolean isAdministrador() {
        return administrador;
    }

    public void setAdministrador(boolean administrador) {
        this.administrador = administrador;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
}
