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
    <title>Dashboard - Biblioteca de Música</title>
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
        }
        .dashboard-header {
            background: white;
            border-radius: 15px;
            padding: 40px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .dashboard-header h1 {
            color: #333;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .dashboard-header p {
            color: #666;
            font-size: 16px;
        }
        .welcome-user {
            color: #667eea;
            font-weight: bold;
        }
        .dashboard-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-bottom: 40px;
        }
        .card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
            background: white;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
        }
        .card-icon {
            font-size: 40px;
            margin-bottom: 15px;
        }
        .card-title {
            color: #333;
            font-weight: bold;
            font-size: 18px;
            margin-bottom: 10px;
        }
        .card-text {
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .card-link {
            text-decoration: none;
            color: white;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 10px 20px;
            border-radius: 8px;
            display: inline-block;
            transition: transform 0.2s ease;
            font-weight: bold;
        }
        .card-link:hover {
            transform: scale(1.05);
            color: white;
        }
        .card-body {
            padding: 30px;
            text-align: center;
        }
        .icon-blue {
            color: #667eea;
        }
        .icon-purple {
            color: #764ba2;
        }
        .icon-pink {
            color: #f95959;
        }
        .icon-green {
            color: #26c281;
        }
        .footer-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 40px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
        }
        .footer-section h3 {
            color: #333;
            font-weight: bold;
            margin-bottom: 20px;
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
                        <span class="nav-link text-muted">
                            Hola, <span class="welcome-user"><%= usuarioNombre %></span>
                        </span>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/logout">
                            <i class="bi bi-box-arrow-right"></i> Cerrar Sesión
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container container-main pb-5">
        <div class="dashboard-header">
            <h1><i class="bi bi-music-note-beamed" style="color: #667eea;"></i> Bienvenido a tu Biblioteca de Música</h1>
            <p>Gestiona, organiza y disfruta tu colección musical favorita</p>
        </div>

        <!-- Dashboard Cards -->
        <div class="dashboard-cards">
            <!-- Todas las Canciones -->
            <div class="card">
                <div class="card-body">
                    <div class="card-icon icon-blue">
                        <i class="bi bi-collection-play"></i>
                    </div>
                    <div class="card-title">Todas las Canciones</div>
                    <p class="card-text">Explora y gestiona tu colección completa de música</p>
                    <a href="<%= request.getContextPath() %>/canciones.jsp" class="card-link">
                        <i class="bi bi-arrow-right"></i> Ver Colección
                    </a>
                </div>
            </div>

            <!-- Canciones Favoritas -->
            <div class="card">
                <div class="card-body">
                    <div class="card-icon icon-pink">
                        <i class="bi bi-heart-fill"></i>
                    </div>
                    <div class="card-title">Canciones Favoritas</div>
                    <p class="card-text">Accede a tus canciones marcadas como favoritas</p>
                    <a href="<%= request.getContextPath() %>/favoritas.jsp" class="card-link">
                        <i class="bi bi-arrow-right"></i> Mis Favoritas
                    </a>
                </div>
            </div>

            <!-- Agregar Canción -->
            <div class="card">
                <div class="card-body">
                    <div class="card-icon icon-green">
                        <i class="bi bi-plus-circle-fill"></i>
                    </div>
                    <div class="card-title">Agregar Canción</div>
                    <p class="card-text">Añade nuevas canciones a tu biblioteca</p>
                    <a href="<%= request.getContextPath() %>/agregar-cancion.jsp" class="card-link">
                        <i class="bi bi-arrow-right"></i> Nueva Canción
                    </a>
                </div>
            </div>

            <!-- Mi Perfil -->
            <div class="card">
                <div class="card-body">
                    <div class="card-icon icon-purple">
                        <i class="bi bi-person-circle"></i>
                    </div>
                    <div class="card-title">Mi Perfil</div>
                    <p class="card-text">Email: <strong><%= session.getAttribute("usuarioEmail") %></strong></p>
                    <a href="<%= request.getContextPath() %>/editar-perfil.jsp" class="card-link">
                        <i class="bi bi-pencil"></i> Editar Perfil
                    </a>
                </div>
            </div>
        </div>

        <!-- Group Info Section -->
        <div class="footer-section">
            <h3><i class="bi bi-people-fill" style="color: #667eea;"></i> Integrantes del Grupo</h3>
            <div style="background: #f8f9fa; border-radius: 8px; padding: 20px; margin-top: 15px;">
                <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 15px;">
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #667eea;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 1</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Zurisaday Alvarenga Almendarez</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 202220020115</p>
                    </div>
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #764ba2;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 2</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Cristhian Illa</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 202210020278</p>
                    </div>
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #f95959;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 3</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Brayan Edgardo Aguilar Aguilera</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 202320110146</p>
                    </div>
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #667eea;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 4</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Emerson Ricardo Jimenez</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 202310080212</p>
                    </div>
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #667eea;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 5</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Luis Alberto Colindres Ventura</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 201930060108 </p>
                    </div>
                    <div style="padding: 15px; background: white; border-radius: 8px; border-left: 4px solid #667eea;">
                        <p style="margin: 0; color: #999; font-size: 12px;">Integrante 6</p>
                        <p style="margin: 5px 0 0 0; color: #333; font-weight: bold; font-size: 16px;">Nombre: Marlon Jared Saenz Blanco</p>
                        <p style="margin: 5px 0 0 0; color: #666; font-size: 14px;">Número de Cuenta: 202230010131</p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

