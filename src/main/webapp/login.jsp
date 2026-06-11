<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hnuth.trabajo.model.Usuario" %>
<%@ page import="hnuth.trabajo.service.DataService" %>
<%
    request.setCharacterEncoding("UTF-8");
    String error = null;
    String email = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        email = request.getParameter("email") == null ? "" : request.getParameter("email").trim();
        String contrasena = request.getParameter("contrasena");

        if (email.isEmpty() || contrasena == null || contrasena.trim().isEmpty()) {
            error = "Por favor completa todos los campos.";
        } else {
            Usuario usuario = DataService.getInstance().autenticar(email, contrasena);
            if (usuario != null) {
                session.setAttribute("usuarioId", usuario.getId());
                session.setAttribute("usuarioNombre", usuario.getNombre());
                session.setAttribute("usuarioEmail", usuario.getEmail());
                session.setMaxInactiveInterval(30 * 60);
                response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
                return;
            }
            error = "Email o contraseña incorrectos.";
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Biblioteca de Música - Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 400px;
            width: 100%;
        }
        .logo-section {
            text-align: center;
            margin-bottom: 30px;
        }
        .logo-icon {
            font-size: 48px;
            color: #667eea;
            margin-bottom: 15px;
        }
        .login-container h1 {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .login-container p {
            color: #666;
            font-size: 14px;
            margin-bottom: 25px;
        }
        .form-control {
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-login:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 20px;
        }
        .demo-users {
            background: #f8f9fa;
            border-radius: 8px;
            padding: 15px;
            margin-top: 25px;
            font-size: 12px;
        }
        .demo-users h5 {
            font-size: 13px;
            color: #667eea;
            margin-bottom: 10px;
            font-weight: bold;
        }
        .demo-user-item {
            margin-bottom: 8px;
            color: #555;
        }
        .demo-user-item code {
            background: white;
            padding: 2px 6px;
            border-radius: 4px;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-music-note-beamed"></i>
            </div>
            <h1>Biblioteca de Música</h1>
            <p>Tu colección musical en línea</p>
        </div>

        <% if (error != null) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle"></i>
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form method="POST" action="<%= request.getContextPath() %>/login.jsp" class="needs-validation">
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email"
                       value="<%= email.replace("&", "&amp;").replace("\"", "&quot;").replace("<", "&lt;").replace(">", "&gt;") %>"
                       placeholder="tu@email.com" required>
            </div>
            <div class="mb-3">
                <label for="contrasena" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-login w-100 text-white">
                <i class="bi bi-box-arrow-in-right"></i> Iniciar Sesión
            </button>
        </form>

        <div style="text-align: center; margin-top: 25px; padding-top: 20px; border-top: 1px solid #eee;">
            <p style="color: #666; font-size: 14px; margin-bottom: 15px;">¿No tienes cuenta?</p>
            <a href="<%= request.getContextPath() %>/registro.jsp" class="btn btn-outline-primary w-100">
                <i class="bi bi-person-plus"></i> Crear una Nueva Cuenta
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

