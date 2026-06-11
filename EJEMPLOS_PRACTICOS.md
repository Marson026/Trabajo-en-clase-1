# 🎯 EJEMPLOS PRÁCTICOS - Biblioteca de Música

## Ejemplo 1: Accediendo la Primera Vez

### Paso 1: Inicia el servidor
```bash
cd "C:\Users\mjsae\Videos\Trabajo en clase 1\Trabajo en clase 1\Trabajo en clase 1"
mvn clean tomcat7:run
```

### Paso 2: Ve a tu navegador
```
http://localhost:8080/Trabajo
```

Serás redirigido automáticamente a `/login.jsp`

### Paso 3: Usa credenciales de demostración
```
Email: juan@example.com
Contraseña: 12345
```

### Paso 4: ¡Entra al Dashboard!
Se te mostrará el panel de bienvenida con opciones para:
- Ver todas las canciones
- Ver favoritas
- Agregar nuevas canciones
- Ver tu perfil

---

## Ejemplo 2: Explorando Todas las Canciones

### Haz clic en "Ver Colección" o "Todas las Canciones"

**Verás:**
- Grid de 8 canciones precargadas
- Cada canción mostrará:
  - Título: Bohemian Rhapsody
  - Artista: Queen
  - Género: Rock
  - Duración: 5:55
  - Álbum: A Night at the Opera

### Interacciones disponibles:
```
1. MARCAR COMO FAVORITA
   └─ Haz clic en el corazón ❤️
   └─ El corazón se llenará
   └─ Verás la canción en "Favoritas"

2. EDITAR
   └─ Haz clic en "Editar"
   └─ Se abre el formulario con datos actuales
   └─ Modifica lo que quieras
   └─ Haz clic en "Guardar Cambios"

3. ELIMINAR
   └─ Haz clic en "Eliminar"
   └─ Confirma en el diálogo
   └─ Se eliminará (y de favoritas de todos)

4. AGREGAR
   └─ Haz clic en "Agregar Canción"
   └─ Se abre formulario nuevo
   └─ Completa los campos
   └─ Haz clic en "Agregar Canción"
```

---

## Ejemplo 3: Agregando una Nueva Canción

### Haz clic en "Agregar Canción" o "Nueva Canción"

### Completa el formulario:

```
Título:     Smells Like Teen Spirit
Artista:    Nirvana
Género:     Rock (selecciona del dropdown)
Duración:   5:01
Álbum:      Nevermind
Portada:    nirvana.jpg
```

### Luego:
```
Haz clic en "Agregar Canción"
  ↓
Verás mensaje "Canción agregada exitosamente"
  ↓
Aparecerá en el listado de todas las canciones
```

### Nota sobre portadas:
```
Aunque escribas "custom.jpg", solo es un nombre
El proyecto usa iconografía Bootstrap por ahora
Puedes agregar imágenes locales en src/main/webapp/images/ después
```

---

## Ejemplo 4: Editando una Canción Existente

### Caso: Cambiar la duración de una canción

1. Accede a "Todas las Canciones"
2. Busca: "Imagine" de John Lennon
3. Haz clic en "Editar"
4. Verás el formulario con:
   - Título: Imagine
   - Artista: John Lennon
   - Género: Pop (ya seleccionado)
   - Duración: 3:03
   - Álbum: Imagine
   - Portada: johnlennon.jpg

### Modifica:
```
Cambio la duración de 3:03 a 3:05
(por ejemplo, si fue una versión diferente)
```

### Haz clic en "Guardar Cambios"
```
Mensaje: "Canción actualizada exitosamente"
Verás 3:05 en el listado
```

---

## Ejemplo 5: Gestión de Favoritas Personal

### Usuario: Juan (juan@example.com)

1. Inicia sesión como Juan
2. Ve a "Todas las Canciones"
3. Marca como favoritas:
   - ❤️ Bohemian Rhapsody - Queen
   - ❤️ Imagine - John Lennon
4. Haz clic en "Mis Favoritas"
5. Verás solo esas 2 canciones

### Ahora usa otro usuario: María

1. Cierra sesión (Cerrar)
2. Accede: maria@example.com / password
3. Ve a "Mis Favoritas"
4. Verás lista vacía (o con favoritas de María si las tiene)

**Conclusión:** Cada usuario tiene sus propias favoritas 👤

---

## Ejemplo 6: Eliminar una Canción

### Caso: Eliminar "Strawberry Fields Forever"

1. Ve a "Todas las Canciones"
2. Busca: Strawberry Fields Forever de The Beatles
3. Haz clic en "Eliminar"
4. Se abre confirmación: "¿Eliminar esta canción?"
5. Haz clic en "Aceptar"

### Resultado:
```
✅ Canción eliminada de:
   - Listado general
   - Favoritas de todos los usuarios
   - Base de datos en memoria

✅ Mensaje: "Canción eliminada exitosamente"
```

---

## Ejemplo 7: Ciclo Completo de Sesión

### Paso 1: Login
```
http://localhost:8080/Trabajo
  ↓
Redirige a login.jsp
  ↓
Ingresa: juan@example.com / 12345
  ↓
Sesión creada con:
  - usuarioId: 1
  - usuarioNombre: "Juan Pérez"
  - usuarioEmail: "juan@example.com"
```

### Paso 2: Navegación
```
Puedes acceder a cualquier página
sin volver a autenticarte
  ↓
dashboard.jsp
  ↓
canciones.jsp
  ↓
favoritas.jsp
  ↓
datos guardados en sesión
```

### Paso 3: Inactividad (30 minutos)
```
Si permaneces sin hacer nada > 30 minutos
  ↓
Sesión expira automáticamente
  ↓
Al hacer cualquier acción:
  ↓
Redirige a login.jsp
```

### Paso 4: Logout Manual
```
Haz clic en "Cerrar Sesión"
  ↓
Servlet LogoutServlet:
  - Invalida sesión
  - Limpia todos los atributos
  
Redirige a login.jsp
```

---

## Ejemplo 8: Búsqueda por Usuario

### Usuario Juan Pérez
```
Email:     juan@example.com
Password:  12345
Role:      (simplemente usuario regular)
```

### Prueba:
1. Actualiza una canción
2. Agrega una canción nueva
3. Marca favoritas
4. Cierra sesión

### Ahora como Carlos López
```
Email:     carlos@example.com
Password:  carlos123
```

### Verás:
```
✅ Las canciones que Juan actualizó
✅ La nueva canción que Juan agregó
✅ Pero NO las favoritas de Juan
✅ Puedes tener tus propias favoritas
```

---

## Ejemplo 9: Validaciones en Acción

### Intenta agregar una canción SIN llenar todos los campos

**Caso: Dejas vacío el campo Artista**

```
Resultado: Campo requerido (HTML5)
           El navegador NO permite submit

Si de alguna forma envía sin llenar:
           Servlet valida
           Si falta: Muestra error
           Forward a form nuevamente
```

---

## Ejemplo 10: Simulando Múltiples Usuarios

### Abrir en ventanas diferentes

**Ventana 1 - Juan:**
```
URL: http://localhost:8080/Trabajo/canciones.jsp
Sesión: juan@example.com
Acciones: Agrega canción, marca favoritas
```

**Ventana 2 - María:**
```
URL: http://localhost:8080/Trabajo/canciones.jsp
Sesión: maria@example.com (nueva sesión)
Acciones: Ve cambios de Juan, tiene sus propias favoritas
```

**Ventana 3 - Datos compartidos:**
```
Ambos ven las mismas canciones editadas
Pero cada uno mantiene sus favoritas separadas
```

---

## Ejemplo 11: Estructura de Datos Bajo el Capó

### Al iniciar la aplicación:

```java
// Creación automática de usuarios
usuarios = [
  Usuario(1, "Juan Pérez", "juan@example.com", "12345"),
  Usuario(2, "María García", "maria@example.com", "password"),
  Usuario(3, "Carlos López", "carlos@example.com", "carlos123")
]

// Creación de canciones
canciones = [
  Cancion(1, "Bohemian Rhapsody", "Queen", ...),
  Cancion(2, "Hotel California", "Eagles", ...),
  ... 6 más
]

// Favoritas (vacío al inicio)
juan.cancionesFavoritas = [] // Set vacío
maria.cancionesFavoritas = []
carlos.cancionesFavoritas = []
```

### Después de acciones del usuario:

```
Juan marca "Bohemian Rhapsody" como favorita:
  juan.cancionesFavoritas.add(1)
  
Juan agrega nueva canción:
  canciones.add(Cancion(9, "Nueva", ...))
  
Se elimina "Hotel California":
  canciones.remove(Cancion(2, ...))
  (también de todas las favoritas)
```

---

## Ejemplo 12: Error Common - Sesión Nula

### Acceso directo sin login:

**Intenta:**
```
http://localhost:8080/Trabajo/dashboard.jsp
```

**Sin pasar por login:**

```
JSP verifica: session.getAttribute("usuarioId")
  ↓
Retorna null (no hay sesión activa)
  ↓
Condición: if (session.getAttribute("usuarioId") == null)
  ↓
response.sendRedirect("/login.jsp")
  ↓
Eres redirigido al login
```

**Propósito:** Proteger páginas que requieren autenticación

---

## 🎓 Conceptos Aprendidos

A través de estos ejemplos, has visto:

✅ **Sesiones HTTP** - Mantener usuario autenticado  
✅ **Validaciones** - Evitar datos inválidos  
✅ **CRUD Operations** - Create, Read, Update, Delete  
✅ **Seguridad básica** - Protección de páginas  
✅ **Interfaz multi-usuario** - Datos compartidos, favoritas privadas  
✅ **Manejo de errores** - Mensajes claros al usuario  
✅ **Bootstrap** - Diseño responsive moderno  

---

**¡Ahora eres capaz de usar todas las funciones de la Biblioteca de Música! 🎵**

