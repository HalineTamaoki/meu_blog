package com.blog.entidades;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Post {
    private int id;
    private String titulo;
    private String texto;
    private Date data;

    public Post() {
    }

    public Post(String titulo, String texto) {
        this.titulo = titulo;
        this.texto = texto;
    }

    public Post(int id, String titulo, String texto) {
        this.id = id;
        this.titulo = titulo;
        this.texto = texto;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public String getTextoCaracteres(int num) {
        if (texto.length()>num){
            texto=texto.substring(0,num)+"...";
        }
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getData() throws ParseException {
        SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
        String str = fmt.format(data);

        return str;
    }

    public void setData(Date data) {
        this.data = data;
    }
}
