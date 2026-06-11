<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hnuth.trabajo.service.DataService" %>
<%@ page import="hnuth.trabajo.model.Cancion" %>
<%
    request.setCharacterEncoding("UTF-8");

    if (session.getAttribute("usuarioId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String usuarioNombre = (String) session.getAttribute("usuarioNombre");

    int idCancion = 0;
    try {
        idCancion = Integer.parseInt(request.getParameter("id"));
    } catch (Exception e) {
        response.sendRedirect(request.getContextPath() + "/canciones.jsp");
        return;
    }

    DataService dataService = DataService.getInstance();
    Cancion cancion = dataService.obtenerCancionPorId(idCancion);
    String error = null;

    if (cancion == null) {
        response.sendRedirect(request.getContextPath() + "/canciones.jsp");
        return;
    }

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String titulo = request.getParameter("titulo") == null ? "" : request.getParameter("titulo").trim();
        String artista = request.getParameter("artista") == null ? "" : request.getParameter("artista").trim();
        String genero = request.getParameter("genero") == null ? "" : request.getParameter("genero").trim();
        String duracion = request.getParameter("duracion") == null ? "" : request.getParameter("duracion").trim();
        String album = request.getParameter("album") == null ? "" : request.getParameter("album").trim();
        String portada = request.getParameter("portada") == null ? "" : request.getParameter("portada").trim();

        if (titulo.isEmpty() || artista.isEmpty() || genero.isEmpty()
                || duracion.isEmpty() || album.isEmpty() || portada.isEmpty()) {
            error = "Todos los campos son obligatorios.";
        } else if (!duracion.matches("\\d{1,3}:[0-5]\\d")) {
            error = "La duración debe tener el formato MM:SS.";
        } else {
            Cancion cancionActualizada = new Cancion(
                    idCancion, titulo, artista, genero, duracion, album, portada
            );
            dataService.actualizarCancion(cancionActualizada);
            response.sendRedirect(request.getContextPath() + "/canciones.jsp");
            return;
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Canción - Biblioteca de Música</title>
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
        }
        .navbar-brand {
            font-weight: bold;
            color: #667eea !important;
        }
        .container-main {
            margin-top: 30px;
            margin-bottom: 40px;
        }
        .form-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            padding: 40px;
            max-width: 600px;
            margin: 0 auto;
        }
        .form-container h1 {
            color: #333;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .form-container p {
            color: #666;
            margin-bottom: 30px;
        }
        .form-label {
            color: #333;
            font-weight: bold;
            margin-bottom: 8px;
        }
        .form-control {
            border-radius: 8px;
            border: 2px solid #e0e0e0;
            padding: 12px 15px;
            font-size: 14px;
            transition: border-color 0.3s ease;
            margin-bottom: 20px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-submit {
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            color: white;
            font-weight: bold;
            transition: transform 0.2s ease;
            width: 48%;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            color: white;
        }
        .btn-cancel {
            background: #95a5a6;
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            color: white;
            font-weight: bold;
            transition: transform 0.2s ease;
            width: 48%;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
        }
        .btn-cancel:hover {
            background: #7f8c8d;
            color: white;
            text-decoration: none;
        }
        .button-group {
            display: flex;
            gap: 20px;
            justify-content: center;
            margin-top: 30px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }
        .form-row .form-group {
            margin-bottom: 0;
        }
        .required::after {
            content: "*";
            color: red;
            margin-left: 5px;
        }
        .help-text {
            font-size: 12px;
            color: #999;
            margin-top: -15px;
            margin-bottom: 15px;
        }
        .song-info-box {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <!-- Navbar -->
    <nav class="navbar navbar-expand-lg">
        <div class="container-fluid px-4">
            <a class="navbar-brand" href="<%= request.getContextPath() %>/dashboard.jsp">
                <i class="bi bi-music-note-beamed"></i> Biblioteca Musical
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/dashboard.jsp">
                            <i class="bi bi-house"></i> Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/canciones.jsp">
                            <i class="bi bi-collection-play"></i> Canciones
                        </a>
                    </li>
                    <li class="nav-item">
                        <span class="nav-link">Hola, <%= usuarioNombre %></span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/logout.jsp">
                            <i class="bi bi-box-arrow-right"></i> Cerrar
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container container-main">
        <div class="form-container">
            <h1><i class="bi bi-pencil-square" style="color: #3498db;"></i> Editar Canción</h1>
            <p>Modifica los detalles de la canción</p>

            <% if (error != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle"></i>
                    <%= error %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="song-info-box">
                <i class="bi bi-music-note-beamed"></i>
                <strong><%= cancion.getTitulo() %></strong> por <strong><%= cancion.getArtista() %></strong>
            </div>

            <form method="POST" action="<%= request.getContextPath() %>/editar-cancion.jsp">
                <input type="hidden" name="id" value="<%= cancion.getId() %>">

                <div class="form-group">
                    <label for="titulo" class="form-label required">Título</label>
                    <input type="text" class="form-control" id="titulo" name="titulo"
                           value="<%= cancion.getTitulo() %>" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="artista" class="form-label required">Artista</label>
                        <input type="text" class="form-control" id="artista" name="artista"
                               value="<%= cancion.getArtista() %>" required>
                    </div>
                    <div class="form-group">
                        <label for="genero" class="form-label required">Género</label>
                        <select class="form-control" id="genero" name="genero" required>
                            <option value="">Selecciona un género</option>
                            <option value="Rock" <%= "Rock".equals(cancion.getGenero()) ? "selected" : "" %>>Rock</option>
                            <option value="Pop" <%= "Pop".equals(cancion.getGenero()) ? "selected" : "" %>>Pop</option>
                            <option value="Hip-Hop" <%= "Hip-Hop".equals(cancion.getGenero()) ? "selected" : "" %>>Hip-Hop</option>
                            <option value="Jazz" <%= "Jazz".equals(cancion.getGenero()) ? "selected" : "" %>>Jazz</option>
                            <option value="Clásica" <%= "Clásica".equals(cancion.getGenero()) ? "selected" : "" %>>Clásica</option>
                            <option value="Electrónica" <%= "Electrónica".equals(cancion.getGenero()) ? "selected" : "" %>>Electrónica</option>
                            <option value="Reggae" <%= "Reggae".equals(cancion.getGenero()) ? "selected" : "" %>>Reggae</option>
                            <option value="Blues" <%= "Blues".equals(cancion.getGenero()) ? "selected" : "" %>>Blues</option>
                            <option value="Otro" <%= "Otro".equals(cancion.getGenero()) ? "selected" : "" %>>Otro</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="duracion" class="form-label required">Duración</label>
                        <input type="text" class="form-control" id="duracion" name="duracion"
                               value="<%= cancion.getDuracion() %>" required>
                        <div class="help-text">Formato: MM:SS</div>
                    </div>
                    <div class="form-group">
                        <label for="album" class="form-label required">Álbum</label>
                        <input type="text" class="form-control" id="album" name="album"
                               value="<%= cancion.getAlbum() %>" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="portada" class="form-label required">Portada (Nombre del Archivo)</label>
                    <input type="text" class="form-control" id="portada" name="portada"
                           value="<%= cancion.getPortada() %>" required>
                    <div class="help-text">Solo escribe el nombre del archivo de imagen</div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-submit">
                        <i class="bi bi-check-circle"></i> Guardar Cambios
                    </button>
                    <a href="<%= request.getContextPath() %>/canciones.jsp" class="btn btn-cancel">
                        <i class="bi bi-x-circle"></i> Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

