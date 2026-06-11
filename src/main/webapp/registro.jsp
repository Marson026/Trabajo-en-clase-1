<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hnuth.trabajo.service.DataService" %>
<%
    String error = "";
    String exito = "";

    if (request.getMethod().equals("POST")) {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contrasena = request.getParameter("contrasena");
        String contrasenaConfirm = request.getParameter("contrasenaConfirm");

        // Validaciones
        if (nombre == null || nombre.trim().isEmpty()) {
            error = "El nombre es requerido.";
        } else if (email == null || email.trim().isEmpty()) {
            error = "El email es requerido.";
        } else if (contrasena == null || contrasena.trim().isEmpty()) {
            error = "La contraseña es requerida.";
        } else if (contrasena.length() < 4) {
            error = "La contraseña debe tener al menos 4 caracteres.";
        } else if (!contrasena.equals(contrasenaConfirm)) {
            error = "Las contraseñas no coinciden.";
        } else {
            // Intentar crear el usuario
            DataService dataService = DataService.getInstance();
            if (dataService.crearUsuario(nombre, email, contrasena)) {
                exito = "Usuario creado exitosamente. Ahora puedes iniciar sesión.";
            } else {
                error = "El email ya está registrado. Intenta con otro.";
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro - Biblioteca de Música</title>
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
        .registro-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            padding: 40px;
            max-width: 450px;
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
        .registro-container h1 {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }
        .registro-container p {
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
        .btn-registro {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-registro:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 20px;
        }
        .login-link {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .login-link p {
            color: #666;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .login-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: bold;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="registro-container">
        <div class="logo-section">
            <div class="logo-icon">
                <i class="bi bi-music-note-beamed"></i>
            </div>
            <h1>Crear Cuenta</h1>
            <p>Únete a la Biblioteca de Música</p>
        </div>

        <% if (!error.isEmpty()) { %>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="bi bi-exclamation-circle"></i>
                <%= error %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <% if (!exito.isEmpty()) { %>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="bi bi-check-circle"></i>
                <%= exito %>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <% } %>

        <form method="POST" action="<%= request.getContextPath() %>/registro.jsp" class="needs-validation">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre Completo</label>
                <input type="text" class="form-control" id="nombre" name="nombre" placeholder="Tu nombre completo" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" placeholder="tu@email.com" required>
            </div>
            <div class="mb-3">
                <label for="contrasena" class="form-label">Contraseña</label>
                <input type="password" class="form-control" id="contrasena" name="contrasena" placeholder="••••••••" required>
                <small class="text-muted">Mínimo 4 caracteres</small>
            </div>
            <div class="mb-3">
                <label for="contrasenaConfirm" class="form-label">Confirmar Contraseña</label>
                <input type="password" class="form-control" id="contrasenaConfirm" name="contrasenaConfirm" placeholder="••••••••" required>
            </div>
            <button type="submit" class="btn btn-registro w-100 text-white">
                <i class="bi bi-person-plus"></i> Crear Cuenta
            </button>
        </form>

        <div class="login-link">
            <p>¿Ya tienes cuenta?</p>
            <a href="<%= request.getContextPath() %>/login.jsp">
                <i class="bi bi-box-arrow-in-right"></i> Inicia Sesión aquí
            </a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


