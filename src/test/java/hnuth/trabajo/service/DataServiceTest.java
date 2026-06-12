package hnuth.trabajo.service;

import hnuth.trabajo.model.Cancion;
import hnuth.trabajo.model.Usuario;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class DataServiceTest {

    @Test
    void cadaUsuarioTieneUnaColeccionIndependienteConLasCancionesIniciales() {
        DataService dataService = DataService.getInstance();
        String email = "prueba-" + System.nanoTime() + "@example.com";

        assertTrue(dataService.crearUsuario("Usuario prueba", email, "1234"));
        Usuario nuevoUsuario = dataService.autenticar(email, "1234");
        assertNotNull(nuevoUsuario);

        int nuevoUsuarioId = nuevoUsuario.getId();
        int otroUsuarioId = 1;
        assertEquals(8, dataService.obtenerTodasLasCanciones(nuevoUsuarioId).size());

        Cancion agregada = new Cancion(0, "Solo mia", "Artista", "Rock", "3:30", "Album", "portada.jpg");
        assertTrue(dataService.agregarCancion(nuevoUsuarioId, agregada));

        assertEquals(9, dataService.obtenerTodasLasCanciones(nuevoUsuarioId).size());
        assertEquals(8, dataService.obtenerTodasLasCanciones(otroUsuarioId).size());

        assertTrue(dataService.eliminarCancion(nuevoUsuarioId, 1));
        assertNull(dataService.obtenerCancionPorId(nuevoUsuarioId, 1));
        assertNotNull(dataService.obtenerCancionPorId(otroUsuarioId, 1));
    }

    @Test
    void editarUnaCancionSoloModificaLaCopiaDelUsuario() {
        DataService dataService = DataService.getInstance();
        int primerUsuarioId = 1;
        int segundoUsuarioId = 2;
        Cancion originalSegundoUsuario = dataService.obtenerCancionPorId(segundoUsuarioId, 2);
        assertNotNull(originalSegundoUsuario);
        String tituloOriginal = originalSegundoUsuario.getTitulo();

        Cancion editada = new Cancion(2, "Titulo privado", "Artista", "Rock", "4:00", "Album", "eagles.jpg");
        assertTrue(dataService.actualizarCancion(primerUsuarioId, editada));

        assertEquals("Titulo privado", dataService.obtenerCancionPorId(primerUsuarioId, 2).getTitulo());
        assertEquals(tituloOriginal, dataService.obtenerCancionPorId(segundoUsuarioId, 2).getTitulo());
    }
}
