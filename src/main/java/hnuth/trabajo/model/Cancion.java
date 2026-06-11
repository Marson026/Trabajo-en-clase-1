package hnuth.trabajo.model;

import java.io.Serializable;

public class Cancion implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String titulo;
    private String artista;
    private String genero;
    private String duracion;
    private String album;
    private String portada;

    public Cancion(int id, String titulo, String artista, String genero, String duracion, String album, String portada) {
        this.id = id;
        this.titulo = titulo;
        this.artista = artista;
        this.genero = genero;
        this.duracion = duracion;
        this.album = album;
        this.portada = portada;
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

    public String getArtista() {
        return artista;
    }

    public void setArtista(String artista) {
        this.artista = artista;
    }

    public String getGenero() {
        return genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public String getDuracion() {
        return duracion;
    }

    public void setDuracion(String duracion) {
        this.duracion = duracion;
    }

    public String getAlbum() {
        return album;
    }

    public void setAlbum(String album) {
        this.album = album;
    }

    public String getPortada() {
        return portada;
    }

    public void setPortada(String portada) {
        this.portada = portada;
    }

    @Override
    public String toString() {
        return "Cancion{" +
                "id=" + id +
                ", titulo='" + titulo + '\'' +
                ", artista='" + artista + '\'' +
                ", genero='" + genero + '\'' +
                ", duracion='" + duracion + '\'' +
                ", album='" + album + '\'' +
                ", portada='" + portada + '\'' +
                '}';
    }
}

