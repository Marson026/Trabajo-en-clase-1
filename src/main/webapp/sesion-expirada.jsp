<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Si el usuario está autenticado, redirigir al dashboard
    if (session.getAttribute("usuarioId") != null) {
        response.sendRedirect(request.getContextPath() + "/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sesión Expirada - Biblioteca de Música</title>
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
        .error-container {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.3);
            padding: 60px 40px;
            max-width: 500px;
            width: 100%;
            text-align: center;
        }
        .error-icon {
            font-size: 64px;
            color: #f39c12;
            margin-bottom: 20px;
        }
        .error-container h1 {
            color: #333;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .error-container p {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }
        .btn-retry {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px 30px;
            color: white;
            font-weight: bold;
            transition: transform 0.2s ease;
        }
        .btn-retry:hover {
            transform: translateY(-2px);
            color: white;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-icon">
            <i class="bi bi-clock-history"></i>
        </div>
        <h1>Sesión Expirada</h1>
        <p>
            Tu sesión ha expirado por inactividad o fue cerrada.
            <br>
            Por favor, inicia sesión nuevamente para continuar.
        </p>
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-retry">
            <i class="bi bi-box-arrow-in-right"></i> Volver a Iniciar Sesión
        </a>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

