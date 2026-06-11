package hnuth.trabajo.model;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

public class Usuario implements Serializable {
    private static final long serialVersionUID = 1L;
    private int id;
    private String nombre;
    private String email;
    private String contrasena;
    private Set<Integer> cancionesFavoritas;

    public Usuario(int id, String nombre, String email, String contrasena) {
        this.id = id;
        this.nombre = nombre;
        this.email = email;
        this.contrasena = contrasena;
        this.cancionesFavoritas = new HashSet<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContrasena() {
        return contrasena;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    public Set<Integer> getCancionesFavoritas() {
        return cancionesFavoritas;
    }

    public void agregarFavorita(int idCancion) {
        this.cancionesFavoritas.add(idCancion);
    }

    public void quitarFavorita(int idCancion) {
        this.cancionesFavoritas.remove(idCancion);
    }

    public boolean isFavorita(int idCancion) {
        return this.cancionesFavoritas.contains(idCancion);
    }

    @Override
    public String toString() {
        return "Usuario{" +
                "id=" + id +
                ", nombre='" + nombre + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}

