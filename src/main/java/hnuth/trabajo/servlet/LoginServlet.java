package hnuth.trabajo.servlet;

import hnuth.trabajo.model.Usuario;
import hnuth.trabajo.service.DataService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");

        // Validaciones básicas
        if (email == null || email.trim().isEmpty() ||
            contrasena == null || contrasena.trim().isEmpty()) {
            request.setAttribute("error", "Por favor completa todos los campos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Autenticar usuario
        DataService dataService = DataService.getInstance();
        Usuario usuario = dataService.autenticar(email, contrasena);

        if (usuario != null) {
            // Crear sesión
            HttpSession session = request.getSession(true);
            session.setAttribute("usuarioId", usuario.getId());
            session.setAttribute("usuarioNombre", usuario.getNombre());
            session.setAttribute("usuarioEmail", usuario.getEmail());
            session.setMaxInactiveInterval(30 * 60); // 30 minutos

            response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        } else {
            request.setAttribute("error", "Email o contraseña incorrectos");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
}

