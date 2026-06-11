<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="hnuth.trabajo.service.DataService" %>
<%@ page import="hnuth.trabajo.model.Cancion" %>
<%@ page import="java.util.List" %>
<%
    if (session.getAttribute("usuarioId") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    int usuarioId = (Integer) session.getAttribute("usuarioId");
    String usuarioNombre = (String) session.getAttribute("usuarioNombre");

    DataService dataService = DataService.getInstance();
    List<Cancion> cancionesFavoritas = dataService.obtenerCancionesFavoritasUsuario(usuarioId);
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Canciones Favoritas - Biblioteca de Música</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #f95959 0%, #e74c3c 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .navbar-brand {
            font-weight: bold;
            color: #e74c3c !important;
        }
        .container-main {
            margin-top: 30px;
            margin-bottom: 40px;
        }
        .page-header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .page-header h1 {
            color: #333;
            font-weight: bold;
            margin: 0;
        }
        .page-header .heart-icon {
            color: #f95959;
            margin-right: 10px;
        }
        .songs-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }
        .song-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        .song-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .song-cover {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #f95959 0%, #e74c3c 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 48px;
            position: relative;
            overflow: hidden;
        }
        .song-cover img {
            position: absolute;
            inset: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .remove-favorite {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.9);
            border-radius: 50%;
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            color: #f95959;
            transition: transform 0.2s ease;
        }
        .remove-favorite:hover {
            transform: scale(1.1);
        }
        .remove-favorite form {
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
            height: 100%;
        }
        .remove-favorite button {
            background: none;
            border: none;
            font-size: 20px;
            cursor: pointer;
            padding: 0;
            color: inherit;
        }
        .song-info {
            padding: 20px;
            flex: 1;
            display: flex;
            flex-direction: column;
        }
        .song-title {
            font-size: 18px;
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .song-artist {
            font-size: 14px;
            color: #f95959;
            margin-bottom: 10px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .song-details {
            font-size: 12px;
            color: #999;
            margin-bottom: 15px;
            flex: 1;
        }
        .song-details div {
            margin: 5px 0;
        }
        .detail-label {
            font-weight: bold;
            color: #666;
        }
        .song-actions {
            display: flex;
            gap: 10px;
        }
        .btn-sm {
            border-radius: 6px;
            font-size: 12px;
            padding: 8px 12px;
            flex: 1;
            border: none;
        }
        .btn-back {
            background: #3498db;
            color: white;
        }
        .btn-back:hover {
            background: #2980b9;
            color: white;
        }
        .empty-state {
            text-align: center;
            padding: 60px 20px;
            color: white;
        }
        .empty-state i {
            font-size: 64px;
            margin-bottom: 20px;
            opacity: 0.8;
        }
        .empty-state h2 {
            font-size: 28px;
            margin-bottom: 10px;
        }
        .empty-state p {
            font-size: 16px;
            opacity: 0.8;
        }
        .empty-state a {
            background: white;
            color: #f95959;
            font-weight: bold;
        }
        .empty-state a:hover {
            background: rgba(255, 255, 255, 0.9);
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
                            <i class="bi bi-collection-play"></i> Todas
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
        <!-- Page Header -->
        <div class="page-header">
            <h1>
                <i class="bi bi-heart-fill heart-icon"></i>
                Canciones Favoritas
                <span class="badge bg-danger ms-2"><%= cancionesFavoritas.size() %></span>
            </h1>
        </div>

        <!-- Favoritas Grid -->
        <% if (cancionesFavoritas.isEmpty()) { %>
            <div class="empty-state">
                <i class="bi bi-heart"></i>
                <h2>No tienes canciones favoritas aún</h2>
                <p>Marca tus canciones favoritas para que aparezcan aquí</p>
                <a href="<%= request.getContextPath() %>/canciones.jsp" class="btn mt-3">
                    <i class="bi bi-music-note-beamed"></i> Ver todas las canciones
                </a>
            </div>
        <% } else { %>
            <div class="songs-grid">
                <% for (Cancion cancion : cancionesFavoritas) { %>
                    <div class="song-card">
                        <div class="song-cover">
                            <i class="bi bi-music-note-beamed"></i>
                            <img src="<%= request.getContextPath() %>/images/<%= cancion.getPortada() %>"
                                 alt="Portada de <%= cancion.getTitulo() %>"
                                 onerror="this.style.display='none'">
                            <div class="remove-favorite">
                                <form method="POST" action="<%= request.getContextPath() %>/cancion" style="width:100%; height:100%;">
                                    <input type="hidden" name="accion" value="desfavorita">
                                    <input type="hidden" name="idCancion" value="<%= cancion.getId() %>">
                                    <button type="submit" title="Quitar de favoritas">
                                        <i class="bi bi-heart-fill"></i>
                                    </button>
                                </form>
                            </div>
                        </div>
                        <div class="song-info">
                            <div class="song-title"><%= cancion.getTitulo() %></div>
                            <div class="song-artist"><%= cancion.getArtista() %></div>
                            <div class="song-details">
                                <div><span class="detail-label">Género:</span> <%= cancion.getGenero() %></div>
                                <div><span class="detail-label">Duración:</span> <%= cancion.getDuracion() %></div>
                                <div><span class="detail-label">Álbum:</span> <%= cancion.getAlbum() %></div>
                            </div>
                            <div class="song-actions">
                                <a href="<%= request.getContextPath() %>/editar-cancion.jsp?id=<%= cancion.getId() %>" class="btn btn-sm btn-back">
                                    <i class="bi bi-pencil"></i> Editar
                                </a>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

