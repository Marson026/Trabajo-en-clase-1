# Biblioteca de Música - Aplicación Web JSP

Una aplicación web moderna y funcional de gestión de biblioteca de música desarrollada en Java con JSP, sin base de datos.

## 📋 Características

✅ **Login funcional** con sesiones seguras  
✅ **Gestión completa de canciones** (agregar, editar, eliminar)  
✅ **Sistema de favoritas** personalizado por usuario  
✅ **Interfaz moderna** con Bootstrap 5  
✅ **Datos en memoria** - listas de Java en tiempo de ejecución  
✅ **Información completa** - título, artista, género, duración, álbum  
✅ **Diseño responsive** - funciona en móviles y computadoras  

## 🚀 Estructura del Proyecto

```
src/
├── main/
│   ├── java/
│   │   └── hnuth/trabajo/
│   │       ├── model/
│   │       │   ├── Cancion.java          # Modelo de canciones
│   │       │   └── Usuario.java          # Modelo de usuarios
│   │       ├── service/
│   │       │   └── DataService.java      # Servicio de datos en memoria
│   │       └── servlet/
│   │           ├── LoginServlet.java     # Manejo de login
│   │           ├── LogoutServlet.java    # Manejo de logout
│   │           └── CancionServlet.java   # Gestión de canciones
│   └── webapp/
│       ├── login.jsp                     # Página de login
│       ├── dashboard.jsp                 # Dashboard principal
│       ├── canciones.jsp                 # Listado de todas las canciones
│       ├── favoritas.jsp                 # Canciones favoritas
│       ├── agregar-cancion.jsp           # Formulario para agregar
│       ├── editar-cancion.jsp            # Formulario para editar
│       └── WEB-INF/
│           └── web.xml                   # Configuración web
└── test/                                 # Pruebas unitarias
```

## 👤 Usuarios de Prueba

Usa cualquiera de estos usuarios para acceder:

| Email | Contraseña | Nombre |
|-------|-----------|--------|
| juan@example.com | 12345 | Juan Pérez |
| maria@example.com | password | María García |
| carlos@example.com | carlos123 | Carlos López |

## 🎵 Canciones Precargadas

El sistema viene con 8 canciones populares precargadas:

1. **Bohemian Rhapsody** - Queen (Rock, 5:55)
2. **Hotel California** - Eagles (Rock, 6:30)
3. **Stairway to Heaven** - Led Zeppelin (Rock, 8:02)
4. **Imagine** - John Lennon (Pop, 3:03)
5. **Strawberry Fields Forever** - The Beatles (Pop, 3:46)
6. **November Rain** - Guns N' Roses (Rock, 5:29)
7. **Comfortably Numb** - Pink Floyd (Rock, 6:23)
8. **Hallelujah** - Leonard Cohen (Pop, 4:36)

## 🔧 Cómo Ejecutar

### 1. **Compilar el Proyecto**
```bash
mvn clean install
```

### 2. **Ejecutar en el Servidor**
```bash
mvn tomcat7:run
```
O con Maven 3.5+:
```bash
mvn tomcat:run
```

### 3. **Acceder a la Aplicación**
```
http://localhost:8080/Trabajo
```

## 📱 Navegación Principal

### 1. **Login** (`/login.jsp`)
- Acceso inicial
- Autenticación de usuarios
- Validación de credenciales

### 2. **Dashboard** (`/dashboard.jsp`)
- Panel de bienvenida
- Accesos rápidos a todas las funciones
- Información del usuario

### 3. **Todas las Canciones** (`/canciones.jsp`)
- Listado de canciones completo
- Editar/Eliminar canciones
- Marcar como favoritas
- Agregar nuevas canciones

### 4. **Canciones Favoritas** (`/favoritas.jsp`)
- Canciones marcadas como favoritas
- Remover de favoritas
- Editar canciones favoritas

### 5. **Agregar Canción** (`/agregar-cancion.jsp`)
- Formulario para agregar nuevas canciones
- Validación de campos
- Guía de nombres de portadas

### 6. **Editar Canción** (`/editar-cancion.jsp`)
- Modificar detalles de canciones
- Validación de entrada
- Confirmación de cambios

## 🔐 Seguridad

- ✅ **Sesiones HTTP** para mantener la autenticación
- ✅ **Validaciones en servidor** de todos los formularios
- ✅ **Tiempo de sesión** configurable (30 minutos por defecto)
- ✅ **HttpOnly cookies** para proteger sesiones

## 💾 Almacenamiento de Datos

Todos los datos se guardan **en memoria** usando:
- Listas de Java (`ArrayList`)
- Sets para favoritas (`HashSet`)
- Patrón **Singleton** para el servicio de datos

Los datos se initialized al iniciar la aplicación y se pierden al reiniciar.

## 🎨 Diseño

- **Bootstrap 5.3.2** para estilos responsive
- **Bootstrap Icons** para iconografía
- **Gradientes personalizados** en colores
- **Animaciones suaves** en interacciones
- **Modo oscuro amigable** con paleta moderna

## ✨ Funcionalidades Avanzadas

### Favoritas Personalizadas
- Cada usuario tiene su lista de favoritas
- Los datos se sincronizar entre páginas
- Las favoritas se eliminan con la canción

### Validación en Cliente y Servidor
- Validación de campos obligatorios
- Verificación de formato correcto
- Mensajes de error claros

### Datos Precargados
- Usuario, canciones y estructura lista
- Sin necesidad de configuración inicial
- Datos de ejemplo diversos

## 📝 Requisitos del Sistema

- **Java 8 o superior**
- **Maven 3.5+**
- **Tomcat 9+** (o servidor compatible)
- **Navegador moderno** (Chrome, Firefox, Safari, Edge)

## 🛠️ Tecnologías Utilizadas

- **Java 8**
- **JSP (Java Server Pages)**
- **Jakarta Servlet API**
- **Bootstrap 5.3.2**
- **Maven**
- **Listas de Java para persistencia en memoria**

## 💡 Notas de Desarrollo

- El proyecto **NO usa SQL ni base de datos**
- El proyecto **NO usa Spring ni frameworks complejos**
- Solo **Servlets si son necesarios** para POST de formularios
- La mayoría de la lógica está en **JSP puro**
- Los datos se reinician cada vez que se reinicia la aplicación

## 📄 Licencia

Proyecto educativo de prueba.

## 🤝 Contribuciones

Siéntete libre de modificar, mejorar y expandir el proyecto según tus necesidades.

---

**¡Disfruta tu Biblioteca de Música! 🎵**

