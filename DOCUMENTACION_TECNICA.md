# 📖 DOCUMENTACIÓN TÉCNICA - Biblioteca de Música

## Arquitectura del Sistema

```
┌─────────────────────────────────────────────────────────────┐
│                    CAPA DE PRESENTACIÓN (JSP)               │
│  login.jsp | dashboard.jsp | canciones.jsp | favoritas.jsp │
│         agregar-cancion.jsp | editar-cancion.jsp           │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                    CAPA DE SERVLETS                          │
│  LoginServlet | LogoutServlet | CancionServlet             │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│                CAPA DE NEGOCIOS (Service)                    │
│              DataService (Singleton Pattern)                │
└─────────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────────┐
│              CAPA DE DATOS (En Memoria)                      │
│  ArrayList<Cancion> | ArrayList<Usuario> | HashSet<Favoritas>
└─────────────────────────────────────────────────────────────┘
```

## Componentes Principales

### 1. MODELOS (Model)

#### `Usuario.java`
```java
- int id                          // Identificador único
- String nombre                   // Nombre del usuario
- String email                    // Email
- String contrasena               // Contraseña
- Set<Integer> cancionesFavoritas // IDs de canciones favoritas
```

**Métodos:**
- `agregarFavorita(int idCancion)` - Agregar a favoritas
- `quitarFavorita(int idCancion)` - Quitar de favoritas
- `isFavorita(int idCancion)` - Verificar si es favorita

#### `Cancion.java`
```java
- int id                // Identificador único
- String titulo         // Título de la canción
- String artista        // Artista/Banda
- String genero         // Género musical
- String duracion       // Duración (MM:SS)
- String album          // Nombre del álbum
- String portada        // Nombre de archivo de portada
```

### 2. SERVICIO DE DATOS (DataService)

Patrón: **Singleton**

```
DataService.getInstance()
    ↓
    └─→ cancionesList (ArrayList<Cancion>)
    └─→ usuariosList (ArrayList<Usuario>)
```

**Métodos Principales:**

#### Autenticación
```java
autenticar(String email, String contrasena) → Usuario
obtenerUsuarioPorId(int id) → Usuario
```

#### Gestión de Canciones
```java
obtenerTodasLasCanciones() → List<Cancion>
obtenerCancionPorId(int id) → Cancion
agregarCancion(Cancion cancion) → void
actualizarCancion(Cancion cancionActualizada) → boolean
eliminarCancion(int idCancion) → boolean
```

#### Gestión de Favoritas
```java
obtenerCancionesFavoritasUsuario(int idUsuario) → List<Cancion>
agregarFavorita(int idUsuario, int idCancion) → void
quitarFavorita(int idUsuario, int idCancion) → void
esFavorita(int idUsuario, int idCancion) → boolean
```

### 3. SERVLETS

#### `LoginServlet.java`
**URL:** `/login`  
**Método:** POST

**Flujo:**
```
1. POST /login con (email, contrasena)
2. Valida campos
3. Llama a DataService.autenticar()
4. Si autenticación es exitosa:
   - Crear HttpSession
   - Guardar atributos (usuarioId, usuarioNombre, usuarioEmail)
   - Redirigir a /dashboard.jsp
5. Si falla:
   - Forward a /login.jsp con error
```

#### `LogoutServlet.java`
**URL:** `/logout`  
**Método:** GET

**Flujo:**
```
1. GET /logout
2. Obtener sesión actual
3. Invalidar sesión
4. Redirigir a /login.jsp
```

#### `CancionServlet.java`
**URL:** `/cancion`  
**Métodos:** POST

**Acciones:**
```
accion=agregar
  - Validar campos
  - Crear nuevo Cancion
  - Guardar en DataService
  - Redirigir a /canciones.jsp

accion=editar
  - Obtener ID y validar
  - Actualizar Cancion
  - Redirigir a /canciones.jsp

accion=eliminar
  - Obtener ID
  - Eliminar de DataService
  - Redirigir a /canciones.jsp

accion=favorita
  - Obtener idCancion de sesión
  - Llamar DataService.agregarFavorita()
  - Redirigir a /canciones.jsp

accion=desfavorita
  - Obtener idCancion de sesión
  - Llamar DataService.quitarFavorita()
  - Redirigir a /canciones.jsp
```

### 4. PÁGINAS JSP

#### `login.jsp`
- Formulario de acceso
- Validación de email y contraseña
- Links informativos con usuarios de prueba

#### `dashboard.jsp`
- Panel de bienvenida
- Tarjetas de acceso rápido
- Información del usuario
- Navegación principal

#### `canciones.jsp`
- Grid responsive de canciones
- Cada tarjeta con:
  - Icono de portada
  - Título y artista (con acción de favorita)
  - Detalles (género, duración, álbum)
  - Botones de editar/eliminar
- Enlace para agregar

#### `favoritas.jsp`
- Similar a canciones.jsp
- Solo muestra favoritas del usuario actual
- Muestra contador de favoritas
- Opción de remover de favoritas

#### `agregar-cancion.jsp`
- Formulario con campos:
  - Título (texto)
  - Artista (texto)
  - Género (select)
  - Duración (texto)
  - Álbum (texto)
  - Portada (texto)
- Validaciones básicas

#### `editar-cancion.jsp`
- Similar a agregar-cancion.jsp
- Pre-cargado con datos actuales
- Más detalles de la canción

## 🔐 Flujos de Seguridad

### Flujo de Login
```
Usuario accede /login.jsp
  ↓
Usuario completa formulario y POST a /login
  ↓
LoginServlet valida email y contraseña
  ↓
DataService.autenticar() busca usuario
  ↓
Si existe:
  - Crear sesión
  - Guardar usuarioId en sesión
  - Redirigir a dashboard
  ↓
Si no existe:
  - Mostrar error
  - Volver a login.jsp
```

### Flujo de Protección de Sesión
```
Acceder a cualquier página protegida (ej: dashboard.jsp)
  ↓
JSP verifica: session.getAttribute("usuarioId") == null
  ↓
Si es null:
  - Sesión no válida
  - Redirigir a /login.jsp
  ↓
Si existe:
  - Permitir acceso
  - Mostrar contenido
```

## 📊 Gestión de Datos

### Inicialización (Ejecución Principal)

```java
DataService.getInstance() {
    // Primera ejecución (Singleton)
    if (instancia == null) {
        instancia = new DataService();
        inicializarDatos();
    }
    return instancia;
}

inicializarDatos() {
    // Cargar 3 usuarios
    usuarios.add(new Usuario(1, "Juan Pérez", ...));
    usuarios.add(new Usuario(2, "María García", ...));
    usuarios.add(new Usuario(3, "Carlos López", ...));
    
    // Cargar 8 canciones
    canciones.add(new Cancion(1, "Bohemian Rhapsody", ...));
    // ... más canciones
}
```

### Ciclo de Vida de una Canción

```
CREAR:
  agregarCancion(Cancion cancion)
    ├─ Generar nuevo ID
    ├─ Agregar a ArrayList
    └─ Retornar

LEER:
  obtenerCancionPorId(int id)
    └─ Buscar en ArrayList y retornar

ACTUALIZAR:
  actualizarCancion(Cancion cancionActualizada)
    ├─ Buscar en ArrayList
    ├─ Reemplazar objeto
    └─ Retornar boolean

ELIMINAR:
  eliminarCancion(int idCancion)
    ├─ Remover de ArrayList
    ├─ Remover de favoritas de todos usuarios
    └─ Retornar boolean
```

## 🔄 Ciclo de Vida de una Sesión

```
1. LOGIN
   └─ nueva HttpSession
   └─ session.setAttribute()

2. NAVEGACIÓN
   └─ JSP verifica session.getAttribute("usuarioId")
   └─ Si existe, está autenticado

3. ACCIONES
   └─ Servlet recibe request
   └─ Obtiene usuarioId de sesión
   └─ Ejecuta acción con ese usuarioId

4. LOGOUT
   └─ session.invalidate()
   └─ Todos los atributos se eliminan
   └─ Redirigir a login

5. TIMEOUT
   └─ Si inactividad > 30 minutos
   └─ Sesión expira automáticamente
   └─ Redirigir a sesion-expirada.jsp
```

## 💾 Persistencia de Datos

### Almacenamiento
```
En Memoria = while (servidor está corriendo)
```

**Ventajas:**
- ✅ Rápido
- ✅ Simple
- ✅ No requiere BD
- ✅ Perfecto para pruebas

**Desventajas:**
- ❌ Datos se pierden al reiniciar
- ❌ No escalable
- ❌ Solo una instancia de servidor

### Reseteado de Datos
```
Al reiniciar servidor
  ↓
Nuevo DataService.getInstance()
  ↓
inicializarDatos()
  ↓
Todos los datos se re-cargan
```

## 🎨 Estructura de Respuestas al Cliente

### Respuesta Exitosa
```html
- Redirigir a página relevante (302 redirect)
- O: Mostrar página con atributo "exito"
```

### Respuesta de Error
```html
- Forward a página anterior
- Mostrar request.setAttribute("error", "mensaje")
- JSP muestra el alert de error
```

## 🔍 Validaciones

### Cliente (JSP)
```
- HTML5 required en inputs
- Hints de formato
- Confirmación en acciones destructivas
```

### Servidor (Servlet)
```
- null checks
- isEmpty() para strings
- try-catch para parsing números
- Verificar existencia de recursos
```

## 📱 Responsive Design

Bootstrap 5 garantiza:
```
- Dispositivos móviles (320px+)
- Tablets (768px+)
- Desktop (1024px+)
- Grillas responsivas
- Navegación adaptable
```

## 🌐 URLs del Proyecto

```
Login:              http://localhost:8080/Trabajo/login.jsp
Dashboard:          http://localhost:8080/Trabajo/dashboard.jsp
Canciones:          http://localhost:8080/Trabajo/canciones.jsp
Favoritas:          http://localhost:8080/Trabajo/favoritas.jsp
Agregar Canción:    http://localhost:8080/Trabajo/agregar-cancion.jsp
Editar Canción:     http://localhost:8080/Trabajo/editar-cancion.jsp?id=1
Logout:             http://localhost:8080/Trabajo/logout
Sesión Expirada:    http://localhost:8080/Trabajo/sesion-expirada.jsp
```

## 📦 Dependencias Maven

```xml
- jakarta.servlet:jakarta.servlet-api (6.1.0)
  Proporciona HttpServlet, HttpSession, etc.

- junit:junit (pruebas, opcional)
```

---

**Este documento técnico sirve como referencia para entender la arquitectura completa del proyecto.**

