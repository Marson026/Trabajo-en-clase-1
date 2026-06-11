package hnuth.trabajo.servlet;

import hnuth.trabajo.model.Cancion;
import hnuth.trabajo.service.DataService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cancion")
public class CancionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("usuarioId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        DataService dataService = DataService.getInstance();

        try {
            if ("agregar".equals(accion)) {
                agregarCancion(request, response, dataService);
            } else if ("editar".equals(accion)) {
                editarCancion(request, response, dataService);
            } else if ("eliminar".equals(accion)) {
                eliminarCancion(request, response, dataService);
            } else if ("favorita".equals(accion)) {
                marcarFavorita(request, response, dataService, session);
            } else if ("desfavorita".equals(accion)) {
                desmarcarFavorita(request, response, dataService, session);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos inválidos");
            request.getRequestDispatcher("/canciones.jsp").forward(request, response);
        }
    }

    private void agregarCancion(HttpServletRequest request, HttpServletResponse response, DataService dataService)
            throws ServletException, IOException {
        String titulo = request.getParameter("titulo");
        String artista = request.getParameter("artista");
        String genero = request.getParameter("genero");
        String duracion = request.getParameter("duracion");
        String album = request.getParameter("album");
        String portada = request.getParameter("portada");

        // Validaciones
        if (titulo == null || titulo.trim().isEmpty() ||
            artista == null || artista.trim().isEmpty() ||
            genero == null || genero.trim().isEmpty() ||
            duracion == null || duracion.trim().isEmpty() ||
            album == null || album.trim().isEmpty() ||
            portada == null || portada.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/agregar-cancion.jsp").forward(request, response);
            return;
        }

        Cancion cancion = new Cancion(0, titulo, artista, genero, duracion, album, portada);
        dataService.agregarCancion(cancion);

        request.setAttribute("exito", "Canción agregada exitosamente");
        request.getRequestDispatcher("/canciones.jsp").forward(request, response);
    }

    private void editarCancion(HttpServletRequest request, HttpServletResponse response, DataService dataService)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String titulo = request.getParameter("titulo");
        String artista = request.getParameter("artista");
        String genero = request.getParameter("genero");
        String duracion = request.getParameter("duracion");
        String album = request.getParameter("album");
        String portada = request.getParameter("portada");

        // Validaciones
        if (titulo == null || titulo.trim().isEmpty() ||
            artista == null || artista.trim().isEmpty() ||
            genero == null || genero.trim().isEmpty() ||
            duracion == null || duracion.trim().isEmpty() ||
            album == null || album.trim().isEmpty() ||
            portada == null || portada.trim().isEmpty()) {
            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("/editar-cancion.jsp?id=" + id).forward(request, response);
            return;
        }

        Cancion cancion = new Cancion(id, titulo, artista, genero, duracion, album, portada);
        if (dataService.actualizarCancion(cancion)) {
            request.setAttribute("exito", "Canción actualizada exitosamente");
            request.getRequestDispatcher("/canciones.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Canción no encontrada");
            request.getRequestDispatcher("/canciones.jsp").forward(request, response);
        }
    }

    private void eliminarCancion(HttpServletRequest request, HttpServletResponse response, DataService dataService)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        if (dataService.eliminarCancion(id)) {
            request.setAttribute("exito", "Canción eliminada exitosamente");
        } else {
            request.setAttribute("error", "Canción no encontrada");
        }

        request.getRequestDispatcher("/canciones.jsp").forward(request, response);
    }

    private void marcarFavorita(HttpServletRequest request, HttpServletResponse response, DataService dataService, HttpSession session)
            throws IOException {
        int idCancion = Integer.parseInt(request.getParameter("idCancion"));
        int idUsuario = (Integer) session.getAttribute("usuarioId");

        dataService.agregarFavorita(idUsuario, idCancion);
        response.sendRedirect(request.getContextPath() + "/canciones.jsp");
    }

    private void desmarcarFavorita(HttpServletRequest request, HttpServletResponse response, DataService dataService, HttpSession session)
            throws IOException {
        int idCancion = Integer.parseInt(request.getParameter("idCancion"));
        int idUsuario = (Integer) session.getAttribute("usuarioId");

        dataService.quitarFavorita(idUsuario, idCancion);
        response.sendRedirect(request.getContextPath() + "/canciones.jsp");
    }
}

