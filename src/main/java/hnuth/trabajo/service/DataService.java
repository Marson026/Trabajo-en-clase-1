package hnuth.trabajo.service;

import hnuth.trabajo.model.Cancion;
import hnuth.trabajo.model.Usuario;

import java.util.ArrayList;
import java.util.List;

public class DataService {
    private static DataService instancia;
    private final List<Cancion> cancionesIniciales;
    private final List<Usuario> usuarios;
    private static final Object lock = new Object();

    private DataService() {
        this.cancionesIniciales = new ArrayList<>();
        this.usuarios = new ArrayList<>();
        inicializarDatos();
    }

    public static DataService getInstance() {
        if (instancia == null) {
            synchronized (lock) {
                if (instancia == null) {
                    instancia = new DataService();
                }
            }
        }
        return instancia;
    }

    private void inicializarDatos() {
        cancionesIniciales.add(new Cancion(1, "Bohemian Rhapsody", "Queen", "Rock", "5:55", "A Night at the Opera", "queen.jpg"));
        cancionesIniciales.add(new Cancion(2, "Hotel California", "Eagles", "Rock", "6:30", "Hotel California", "eagles.jpg"));
        cancionesIniciales.add(new Cancion(3, "Stairway to Heaven", "Led Zeppelin", "Rock", "8:02", "Led Zeppelin IV", "ledzeppelin.jpg"));
        cancionesIniciales.add(new Cancion(4, "Imagine", "John Lennon", "Pop", "3:03", "Imagine", "johnlennon.jpg"));
        cancionesIniciales.add(new Cancion(5, "Strawberry Fields Forever", "The Beatles", "Pop", "3:46", "Magical Mystery Tour", "beatles.jpg"));
        cancionesIniciales.add(new Cancion(6, "November Rain", "Guns N' Roses", "Rock", "5:29", "Use Your Illusion I", "gnr.jpg"));
        cancionesIniciales.add(new Cancion(7, "Comfortably Numb", "Pink Floyd", "Rock", "6:23", "The Wall", "pinkfloyd.jpg"));
        cancionesIniciales.add(new Cancion(8, "Hallelujah", "Leonard Cohen", "Pop", "4:36", "Various Positions", "leonardcohen.jpg"));

        agregarUsuarioInicial(new Usuario(1, "Juan Pérez", "juan@example.com", "12345"));
        agregarUsuarioInicial(new Usuario(2, "María García", "maria@example.com", "password"));
        agregarUsuarioInicial(new Usuario(3, "Carlos López", "carlos@example.com", "carlos123"));
    }

    private void agregarUsuarioInicial(Usuario usuario) {
        usuario.inicializarCanciones(cancionesIniciales);
        usuarios.add(usuario);
    }

    public Usuario autenticar(String email, String contrasena) {
        for (Usuario usuario : usuarios) {
            if (usuario.getEmail().equals(email) && usuario.getContrasena().equals(contrasena)) {
                return usuario;
            }
        }
        return null;
    }

    public Usuario obtenerUsuarioPorId(int id) {
        for (Usuario usuario : usuarios) {
            if (usuario.getId() == id) {
                return usuario;
            }
        }
        return null;
    }

    public List<Usuario> obtenerTodosLosUsuarios() {
        return new ArrayList<>(usuarios);
    }

    public synchronized boolean crearUsuario(String nombre, String email, String contrasena) {
        for (Usuario usuario : usuarios) {
            if (usuario.getEmail().equals(email)) {
                return false;
            }
        }

        int nuevoId = usuarios.stream()
                .mapToInt(Usuario::getId)
                .max()
                .orElse(0) + 1;

        Usuario nuevoUsuario = new Usuario(nuevoId, nombre, email, contrasena);
        nuevoUsuario.inicializarCanciones(cancionesIniciales);
        usuarios.add(nuevoUsuario);
        return true;
    }

    public boolean actualizarUsuario(Usuario usuarioActualizado) {
        for (int i = 0; i < usuarios.size(); i++) {
            if (usuarios.get(i).getId() == usuarioActualizado.getId()) {
                usuarios.set(i, usuarioActualizado);
                return true;
            }
        }
        return false;
    }

    public List<Cancion> obtenerTodasLasCanciones(int idUsuario) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return new ArrayList<>();
        }
        return new ArrayList<>(usuario.getCanciones());
    }

    public Cancion obtenerCancionPorId(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return null;
        }
        for (Cancion cancion : usuario.getCanciones()) {
            if (cancion.getId() == idCancion) {
                return cancion;
            }
        }
        return null;
    }

    public synchronized boolean agregarCancion(int idUsuario, Cancion cancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return false;
        }

        List<Cancion> canciones = usuario.getCanciones();
        if (cancion.getId() == 0) {
            int nuevoId = canciones.stream()
                    .mapToInt(Cancion::getId)
                    .max()
                    .orElse(0) + 1;
            cancion.setId(nuevoId);
        }
        canciones.add(cancion);
        return true;
    }

    public synchronized boolean actualizarCancion(int idUsuario, Cancion cancionActualizada) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return false;
        }

        List<Cancion> canciones = usuario.getCanciones();
        for (int i = 0; i < canciones.size(); i++) {
            if (canciones.get(i).getId() == cancionActualizada.getId()) {
                canciones.set(i, cancionActualizada);
                return true;
            }
        }
        return false;
    }

    public synchronized boolean eliminarCancion(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return false;
        }

        boolean eliminada = usuario.getCanciones().removeIf(c -> c.getId() == idCancion);
        if (eliminada) {
            usuario.quitarFavorita(idCancion);
        }
        return eliminada;
    }

    public List<Cancion> obtenerCancionesFavoritasUsuario(int idUsuario) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return new ArrayList<>();
        }

        List<Cancion> favoritas = new ArrayList<>();
        for (Cancion cancion : usuario.getCanciones()) {
            if (usuario.isFavorita(cancion.getId())) {
                favoritas.add(cancion);
            }
        }
        return favoritas;
    }

    public void agregarFavorita(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario != null && obtenerCancionPorId(idUsuario, idCancion) != null) {
            usuario.agregarFavorita(idCancion);
        }
    }

    public void quitarFavorita(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario != null) {
            usuario.quitarFavorita(idCancion);
        }
    }

    public boolean esFavorita(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        return usuario != null && usuario.isFavorita(idCancion);
    }
}
