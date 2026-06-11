# 🚀 GUÍA RÁPIDA DE INSTALACIÓN Y EJECUCIÓN

## Paso 1: Abre el Proyecto en IntelliJ IDEA

1. Abre IntelliJ IDEA
2. Ve a `File > Open`
3. Selecciona la carpeta del proyecto: `C:\Users\mjsae\Videos\Trabajo en clase 1\Trabajo en clase 1\Trabajo en clase 1`
4. Espera a que se cargue todo (Maven descargará las dependencias)

## Paso 2: Configura el Servidor (Tomcat)

### Opción A: Usando Maven (Recomendado)
```bash
mvn clean tomcat7:run
```

La aplicación estará disponible en:
```
http://localhost:8080/Trabajo
```

### Opción B: Configurar Tomcat en IntelliJ

1. Ve a `Run > Edit Configurations`
2. Haz clic en `+` y selecciona `Tomcat Server > Local`
3. Nombre: "Tomcat Local"
4. En "Deployment":
   - Haz clic en `+` > `Artifact`
   - Selecciona `Trabajo:war exploded`
   - Application context: `/Trabajo`
5. Haz clic en `Apply` > `OK`
6. Presiona `Shift + F10` para ejecutar

## Paso 3: Accede a la Aplicación

Abre tu navegador y ve a:
```
http://localhost:8080/Trabajo
```

Se te redirigirá automáticamente a la página de login.

## Paso 4: Inicia Sesión

Usa uno de estos usuarios de prueba:

```
Email: juan@example.com
Contraseña: 12345
```

O:
```
Email: maria@example.com
Contraseña: password
```

O:
```
Email: carlos@example.com
Contraseña: carlos123
```

## Funcionalidades Disponibles

### 🎵 Dashboard
Panel principal con accesos rápidos a todas las funciones

### 📋 Todas las Canciones
- Ver todas las 8 canciones precargadas
- Agregar nuevas canciones
- Editar canciones existentes
- Eliminar canciones
- Marcar como favoritas ❤️

### ❤️ Mis Favoritas
- Ver solo tus canciones marcadas como favoritas
- Cada usuario tiene su propia lista de favoritas
- Quitar de favoritas

### ➕ Agregar Canción
Rellena el formulario con:
- **Título**: Nombre de la canción
- **Artista**: Nombre del artista
- **Género**: Selecciona de la lista (Rock, Pop, etc.)
- **Duración**: Formato MM:SS (ej: 5:30)
- **Álbum**: Nombre del álbum
- **Portada**: Nombre del archivo de imagen (ej: queen.jpg)

### ✏️ Editar Canción
Haz clic en "Editar" en cualquier canción para modificar sus datos

### 🗑️ Eliminar Canción
Haz clic en "Eliminar" para remover una canción (se confirmará)

## 📱 Características del Diseño

✅ Interfaz moderna con Bootstrap 5
✅ Responsivo para móviles y desktop
✅ Iconografía clara con Bootstrap Icons
✅ Colores modernos y gradientes
✅ Animaciones suaves
✅ Fácil navegación

## 🔄 Características de Datos

💾 **Datos en memoria** - No usa base de datos
🔄 **Precargados** - 8 canciones al iniciar
👤 **3 usuarios de prueba** - Para testing
🔐 **Sesiones seguras** - Login funcional por usuario

## 📊 Estructura de Datos

### Usuario
- ID
- Nombre
- Email
- Contraseña
- Lista de favoritas

### Canción
- ID
- Título
- Artista
- Género
- Duración
- Álbum
- Portada

## 🛑 Problemas Comunes y Soluciones

### "Puerto 8080 ya está en uso"
Cambia el puerto en la configuración de Tomcat o detén el proceso que usa el puerto.

### "Falta dependencias de Maven"
Ejecuta:
```bash
mvn clean install
```

### "No puedo acceder a http://localhost:8080/Trabajo"
1. Verifica que Tomcat está ejecutándose
2. Comprueba que usas el puerto correcto
3. Reinicia el servidor

### "Las canciones no se guardan"
Los datos están EN MEMORIA y se pierden al reiniciar. Esto es normal 😊

## 💡 Tips de Uso

1. **Prueba adicionar canciones**: Usa datos reales o ficticios
2. **Marca favoritas**: Haz clic en el corazón en cualquier canción
3. **Cambia de usuario**: Cierra sesión y accede con otro usuario
4. **Las favoritas son por usuario**: Cada usuario tiene sus propias favoritas

## 🎓 Propósito Educativo

Este proyecto fue creado para aprender:
- ✅ JSP (Java Server Pages)
- ✅ Servlets
- ✅ Sesiones HTTP
- ✅ Formularios web
- ✅ Gestión de datos en memoria
- ✅ Bootstrap para diseño responsive
- ✅ Arquitectura MVC básica

## 📞 Soporte

Si encuentras problemas:
1. Verifica el archivo `pom.xml` con las dependencias correctas
2. Asegúrate de tener Java 8 o superior: `java -version`
3. Ten Maven 3.5+: `mvn -version`
4. Revisa la consola de Tomcat para mensajes de error

---

**¡Listo para empezar! Abre IntelliJ y comienza a explorar tu Biblioteca de Música 🎵**

