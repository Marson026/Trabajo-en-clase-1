package hnuth.trabajo.service;

import hnuth.trabajo.model.Cancion;
import hnuth.trabajo.model.Usuario;

import java.util.*;

public class DataService {
    private static DataService instancia;
    private List<Cancion> canciones;
    private List<Usuario> usuarios;
    private static final Object lock = new Object();

    // Constructor privado para singleton
    private DataService() {
        this.canciones = new ArrayList<>();
        this.usuarios = new ArrayList<>();
        inicializarDatos();
    }

    // Método para obtener la instancia única
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

    // Inicializar datos precargados
    private void inicializarDatos() {
        // Usuarios precargados
        usuarios.add(new Usuario(1, "Juan Pérez", "juan@example.com", "12345"));
        usuarios.add(new Usuario(2, "María García", "maria@example.com", "password"));
        usuarios.add(new Usuario(3, "Carlos López", "carlos@example.com", "carlos123"));

        // Canciones precargadas
        canciones.add(new Cancion(1, "Bohemian Rhapsody", "Queen", "Rock", "5:55", "A Night at the Opera", "queen.jpg"));
        canciones.add(new Cancion(2, "Hotel California", "Eagles", "Rock", "6:30", "Hotel California", "eagles.jpg"));
        canciones.add(new Cancion(3, "Stairway to Heaven", "Led Zeppelin", "Rock", "8:02", "Led Zeppelin IV", "ledzeppelin.jpg"));
        canciones.add(new Cancion(4, "Imagine", "John Lennon", "Pop", "3:03", "Imagine", "johnlennon.jpg"));
        canciones.add(new Cancion(5, "Strawberry Fields Forever", "The Beatles", "Pop", "3:46", "Magical Mystery Tour", "beatles.jpg"));
        canciones.add(new Cancion(6, "November Rain", "Guns N' Roses", "Rock", "5:29", "Use Your Illusion I", "gnr.jpg"));
        canciones.add(new Cancion(7, "Comfortably Numb", "Pink Floyd", "Rock", "6:23", "The Wall", "pinkfloyd.jpg"));
        canciones.add(new Cancion(8, "Hallelujah", "Leonard Cohen", "Pop", "4:36", "Various Positions", "leonardcohen.jpg"));
    }

    // ===== MÉTODOS PARA USUARIOS =====
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

    public boolean crearUsuario(String nombre, String email, String contrasena) {
        // Verificar que el email no exista
        for (Usuario usuario : usuarios) {
            if (usuario.getEmail().equals(email)) {
                return false; // El email ya existe
            }
        }

        // Generar nuevo ID
        int nuevoId = usuarios.stream()
                .mapToInt(Usuario::getId)
                .max()
                .orElse(0) + 1;

        Usuario nuevoUsuario = new Usuario(nuevoId, nombre, email, contrasena);
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

    // ===== MÉTODOS PARA CANCIONES =====
    public List<Cancion> obtenerTodasLasCanciones() {
        return new ArrayList<>(canciones);
    }

    public Cancion obtenerCancionPorId(int id) {
        for (Cancion cancion : canciones) {
            if (cancion.getId() == id) {
                return cancion;
            }
        }
        return null;
    }

    public void agregarCancion(Cancion cancion) {
        if (cancion.getId() == 0) {
            // Generar nuevo ID
            int nuevoId = canciones.stream()
                    .mapToInt(Cancion::getId)
                    .max()
                    .orElse(0) + 1;
            cancion.setId(nuevoId);
        }
        canciones.add(cancion);
    }

    public boolean actualizarCancion(Cancion cancionActualizada) {
        for (int i = 0; i < canciones.size(); i++) {
            if (canciones.get(i).getId() == cancionActualizada.getId()) {
                canciones.set(i, cancionActualizada);
                return true;
            }
        }
        return false;
    }

    public boolean eliminarCancion(int idCancion) {
        boolean eliminada = canciones.removeIf(c -> c.getId() == idCancion);
        if (eliminada) {
            // También eliminar de las listas de favoritas de todos los usuarios
            for (Usuario usuario : usuarios) {
                usuario.quitarFavorita(idCancion);
            }
        }
        return eliminada;
    }

    public List<Cancion> obtenerCancionesFavoritasUsuario(int idUsuario) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario == null) {
            return new ArrayList<>();
        }

        List<Cancion> favoritas = new ArrayList<>();
        for (Cancion cancion : canciones) {
            if (usuario.isFavorita(cancion.getId())) {
                favoritas.add(cancion);
            }
        }
        return favoritas;
    }

    // ===== MÉTODOS PARA FAVORITAS =====
    public void agregarFavorita(int idUsuario, int idCancion) {
        Usuario usuario = obtenerUsuarioPorId(idUsuario);
        if (usuario != null) {
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
        if (usuario != null) {
            return usuario.isFavorita(idCancion);
        }
        return false;
    }
}

