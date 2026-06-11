<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if (session.getAttribute("usuarioId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String usuarioNombre = (String) session.getAttribute("usuarioNombre");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Canción - Biblioteca de Música</title>
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
            background: linear-gradient(135deg, #26c281 0%, #1ba65a 100%);
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
        .form-info {
            background: #f8f9fa;
            border-left: 4px solid #667eea;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 25px;
            font-size: 14px;
            color: #555;
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
                        <a class="nav-link" href="<%= request.getContextPath() %>/logout">
                            <i class="bi bi-box-arrow-right"></i> Cerrar
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container container-main">
        <div class="form-container">
            <h1><i class="bi bi-plus-circle" style="color: #26c281;"></i> Agregar Nueva Canción</h1>
            <p>Completa los detalles de la canción que deseas agregar</p>

            <% if (request.getAttribute("error") != null) { %>
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-circle"></i>
                    <%= request.getAttribute("error") %>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            <% } %>

            <div class="form-info">
                <i class="bi bi-info-circle"></i>
                <strong>Nota:</strong> Para la portada, usa nombres como: queen.jpg, eagles.jpg, ledzeppelin.jpg, johnlennon.jpg, beatles.jpg, gnr.jpg, pinkfloyd.jpg, leonardcohen.jpg
            </div>

            <form method="POST" action="<%= request.getContextPath() %>/cancion">
                <input type="hidden" name="accion" value="agregar">

                <div class="form-group">
                    <label for="titulo" class="form-label required">Título</label>
                    <input type="text" class="form-control" id="titulo" name="titulo" required
                           placeholder="Ej: Bohemian Rhapsody">
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="artista" class="form-label required">Artista</label>
                        <input type="text" class="form-control" id="artista" name="artista" required
                               placeholder="Ej: Queen">
                    </div>
                    <div class="form-group">
                        <label for="genero" class="form-label required">Género</label>
                        <select class="form-control" id="genero" name="genero" required>
                            <option value="">Selecciona un género</option>
                            <option value="Rock">Rock</option>
                            <option value="Pop">Pop</option>
                            <option value="Hip-Hop">Hip-Hop</option>
                            <option value="Jazz">Jazz</option>
                            <option value="Clásica">Clásica</option>
                            <option value="Electrónica">Electrónica</option>
                            <option value="Reggae">Reggae</option>
                            <option value="Blues">Blues</option>
                            <option value="Otro">Otro</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="duracion" class="form-label required">Duración</label>
                        <input type="text" class="form-control" id="duracion" name="duracion" required
                               placeholder="Ej: 5:55">
                        <div class="help-text">Formato: MM:SS</div>
                    </div>
                    <div class="form-group">
                        <label for="album" class="form-label required">Álbum</label>
                        <input type="text" class="form-control" id="album" name="album" required
                               placeholder="Ej: A Night at the Opera">
                    </div>
                </div>

                <div class="form-group">
                    <label for="portada" class="form-label required">Portada (Nombre del Archivo)</label>
                    <input type="text" class="form-control" id="portada" name="portada" required
                           placeholder="Ej: queen.jpg">
                    <div class="help-text">Solo escribe el nombre del archivo de imagen</div>
                </div>

                <div class="button-group">
                    <button type="submit" class="btn btn-submit">
                        <i class="bi bi-check-circle"></i> Agregar Canción
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

