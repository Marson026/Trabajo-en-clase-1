<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hnuth.trabajo.service.DataService" %>
<%@ page import="hnuth.trabajo.model.Usuario" %>
<%
    if (session.getAttribute("usuarioId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int usuarioId = (Integer) session.getAttribute("usuarioId");
    DataService dataService = DataService.getInstance();
    Usuario usuario = dataService.obtenerUsuarioPorId(usuarioId);

    String error = "";
    String exito = "";

    if (request.getMethod().equals("POST")) {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String contrasenaActual = request.getParameter("contrasenaActual");
        String contrasenanueva = request.getParameter("contrasenaNueva");
        String contrasenaConfirm = request.getParameter("contrasenaConfirm");

        // Validaciones
        if (nombre == null || nombre.trim().isEmpty()) {
            error = "El nombre es requerido.";
        } else if (email == null || email.trim().isEmpty()) {
            error = "El email es requerido.";
        } else if (!usuario.getContrasena().equals(contrasenaActual)) {
            error = "La contraseña actual es incorrecta.";
        } else if (!contrasenanueva.isEmpty() && contrasenaConfirm.isEmpty()) {
            error = "Debes confirmar la contraseña nueva.";
        } else if (!contrasenanueva.isEmpty() && !contrasenaConfirm.isEmpty() && !contrasenanueva.equals(contrasenaConfirm)) {
            error = "Las contraseñas nuevas no coinciden.";
        } else if (!contrasenanueva.isEmpty() && contrasenanueva.length() < 4) {
            error = "La contraseña nueva debe tener al menos 4 caracteres.";
        } else {
            // Comprobar si el email ya existe (pero no sea el mismo usuario)
            boolean emailExiste = false;
            for (Usuario u : dataService.obtenerTodosLosUsuarios()) {
                if (u.getEmail().equals(email) && u.getId() != usuarioId) {
                    emailExiste = true;
                    break;
                }
            }

            if (emailExiste) {
                error = "El email ya está siendo usado por otro usuario.";
            } else {
                // Actualizar datos
                usuario.setNombre(nombre);
                usuario.setEmail(email);
                if (!contrasenanueva.isEmpty()) {
                    usuario.setContrasena(contrasenanueva);
                }

                if (dataService.actualizarUsuario(usuario)) {
                    // Actualizar sesión
                    session.setAttribute("usuarioNombre", nombre);
                    session.setAttribute("usuarioEmail", email);
                    exito = "Perfil actualizado exitosamente.";
                } else {
                    error = "Error al actualizar el perfil.";
                }
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Perfil - Biblioteca de Música</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        .navbar-brand {
            font-weight: bold;
            color: #667eea !important;
            font-size: 20px;
        }
        .brand-icon {
            font-size: 24px;
            margin-right: 10px;
        }
        .container-main {
            margin-top: 40px;
            margin-bottom: 40px;
        }
        .perfil-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 600px;
            margin: 0 auto;
        }
        .perfil-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .perfil-icon {
            font-size: 60px;
            color: #667eea;
            margin-bottom: 15px;
        }
        .perfil-header h1 {
            color: #333;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .perfil-header p {
            color: #666;
            font-size: 16px;
        }
        .form-label {
            color: #333;
            font-weight: 600;
            margin-bottom: 8px;
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
        .btn-enviar {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }
        .btn-enviar:hover {
            background: linear-gradient(135deg, #764ba2 0%, #667eea 100%);
            transform: translateY(-2px);
            box-shadow: 0 5px 20px rgba(102, 126, 234, 0.4);
        }
        .btn-cancelar {
            background: #e0e0e0;
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: bold;
            transition: transform 0.2s ease;
        }
        .btn-cancelar:hover {
            background: #d0d0d0;
            transform: translateY(-2px);
        }
        .alert {
            border-radius: 8px;
            border: none;
            margin-bottom: 20px;
        }
        .section-titulo {
            color: #333;
            font-weight: bold;
            font-size: 16px;
            margin-top: 25px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #667eea;
        }
        .small-text {
            font-size: 12px;
            color: #999;
            margin-top: 5px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/dashboard.jsp">
                <i class="bi bi-music-note-beamed brand-icon"></i>
                Biblioteca Musical
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/dashboard.jsp">
                            <i class="bi bi-arrow-left"></i> Volver al Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/logout.jsp">
                            <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container container-main">
        <div class="perfil-card">
            <div class="perfil-header">
                <div class="perfil-icon">
                    <i class="bi bi-person-circle"></i>
                </div>
                <h1>Editar Perfil</h1>
                <p>Actualiza tu información personal</p>
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

            <form method="POST" action="<%= request.getContextPath() %>/editar-perfil.jsp">
                <!-- Información Personal -->
                <div class="section-titulo">
                    <i class="bi bi-person"></i> Información Personal
                </div>

                <div class="mb-3">
                    <label for="nombre" class="form-label">Nombre Completo</label>
                    <input type="text" class="form-control" id="nombre" name="nombre" value="<%= usuario.getNombre() %>" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" class="form-control" id="email" name="email" value="<%= usuario.getEmail() %>" required>
                </div>

                <!-- Seguridad -->
                <div class="section-titulo">
                    <i class="bi bi-shield-lock"></i> Seguridad
                </div>

                <div class="mb-3">
                    <label for="contrasenaActual" class="form-label">Contraseña Actual</label>
                    <input type="password" class="form-control" id="contrasenaActual" name="contrasenaActual" placeholder="••••••••" required>
                    <div class="small-text">Requerida para confirmar cambios</div>
                </div>

                <div class="mb-3">
                    <label for="contrasenanueva" class="form-label">Contraseña Nueva (Opcional)</label>
                    <input type="password" class="form-control" id="contrasenaNueva" name="contrasenaNueva" placeholder="Deja en blanco para no cambiar">
                    <div class="small-text">Mínimo 4 caracteres</div>
                </div>

                <div class="mb-3">
                    <label for="contrasenaConfirm" class="form-label">Confirmar Contraseña Nueva</label>
                    <input type="password" class="form-control" id="contrasenaConfirm" name="contrasenaConfirm" placeholder="Confirma la nueva contraseña">
                </div>

                <!-- Botones -->
                <div class="d-grid gap-2 d-sm-flex">
                    <button type="submit" class="btn btn-enviar text-white flex-sm-fill">
                        <i class="bi bi-check-circle"></i> Guardar Cambios
                    </button>
                    <a href="<%= request.getContextPath() %>/dashboard.jsp" class="btn btn-cancelar flex-sm-fill">
                        <i class="bi bi-x-circle"></i> Cancelar
                    </a>
                </div>
            </form>

            <div style="margin-top: 30px; padding-top: 20px; border-top: 1px solid #eee; text-align: center;">
                <small class="text-muted">ID de Usuario: <%= usuarioId %></small>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>


