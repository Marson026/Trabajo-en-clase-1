# 🎯 PREGUNTAS FRECUENTES - Biblioteca de Música

## General

### ¿Necesito instalar algo especial?
```
✅ Java 8 o superior
✅ Maven 3.5+
✅ Un navegador web moderno
❌ NO necesitas SQL
❌ NO necesitas MySQL
❌ NO necesitas Spring
```

### ¿Los datos se guardan?
```
❌ NO - Los datos están EN MEMORIA
✅ Se pierden al reiniciar el servidor
✅ Perfecto para pruebas y desarrollo
   Esto es por diseño
```

### ¿Cuánto tiempo tarda en iniciarse?
```
Primera ejecución: ~30-60 segundos
  (Maven descarga dependencias)

Ejecuciones posteriores: ~10-15 segundos
  (Solo inicia la aplicación)
```

## Autenticación

### ¿Cuáles son los usuarios de prueba?

```
Email:           Contraseña:     Nombre:
juan@example.com 12345          Juan Pérez
maria@example.com password        María García
carlos@example.com carlos123       Carlos López
```

### ¿Puedo cambiar una contraseña?
```
❌ NO - Los datos son precargados
✅ Edita DataService.java para cambiar contraseñas
✅ O conecta una base de datos
```

### ¿Qué pasa si olvido la contraseña?
```
❌ NO hay recuperación de contraseña
✅ Los datos están en el código (DataService)
✅ Usa una de las 3 credenciales de prueba
```

### ¿Las sesiones son seguras?
```
✅ HttpOnly cookies (protegidas)
✅ Session ID seguro
✅ Timeout de 30 minutos
✅ Logout limpia la sesión
❌ NO es seguridad empresarial
✅ Bueno para pruebas educativas
```

## Canciones

### ¿Cuántas canciones hay precargadas?
```
8 canciones en total:
1. Bohemian Rhapsody - Queen
2. Hotel California - Eagles
3. Stairway to Heaven - Led Zeppelin
4. Imagine - John Lennon
5. Strawberry Fields Forever - The Beatles
6. November Rain - Guns N' Roses
7. Comfortably Numb - Pink Floyd
8. Hallelujah - Leonard Cohen
```

### ¿Qué información tiene cada canción?
```
✅ Título
✅ Artista
✅ Género (Rock, Pop, Jazz, etc.)
✅ Duración (MM:SS)
✅ Álbum
✅ Portada (nombre de archivo)
```

### ¿Puedo agregar más de 8 canciones?
```
✅ SÍ - Agrega todas que quieras
✅ Usa "Agregar Canción"
✅ Se guardan en memoria
❌ Se pierden al reiniciar
```

### ¿Qué pasa si elimino una canción?
```
✅ Se elimina del listado
✅ Se elimina de favoritas de todos
✅ No se puede recuperar (en esta sesión)
❌ Se reinicia al reiniciar servidor
```

### ¿Puedo editar una canción?
```
✅ SÍ - Haz clic en "Editar"
✅ Modifica cualquier campo
✅ Cambios se guardan en memoria
✅ Todos los usuarios ven el cambio
```

## Favoritas

### ¿Cómo marco una canción como favorita?
```
1. Ve a "Todas las Canciones"
2. Busca la canción
3. Haz clic en el corazón ❤️
4. El corazón se llena
5. Aparece en "Mis Favoritas"
```

### ¿Qué pasa con mis favoritas si cierro sesión?
```
✅ Se guardan en la memoria
✅ Al volver a iniciar sesión con mismo usuario
✅ Verás las mismas favoritas
❌ Se pierden al reiniciar servidor
```

### ¿Otros usuarios ven mis favoritas?
```
❌ NO - Son completamente privadas
✅ Cada usuario tiene sus propias favoritas
✅ Datos en Sets separados
```

### ¿Cuántas favoritas puedo tener?
```
✅ ILIMITADO - Agrega todas que quieras
✅ Solo limitado por memoria disponible
```

## Interfaz

### ¿Por qué se ve tan bonito?
```
✅ Bootstrap 5.3.2 (framework CSS popular)
✅ Diseño responsive
✅ Bootstrap Icons (iconografía)
✅ Gradientes y animaciones personalizadas
✅ CSS moderno incluido
```

### ¿Funciona en móvil?
```
✅ SÍ - 100% responsive
✅ Se adapta a cualquier tamaño de pantalla
✅ Navegación intuitiva en móvil
```

### ¿Por qué no hay portadas reales?
```
❌ El proyecto usa iconos por defecto
✅ Puedes agregar imágenes locales:
   1. Crea carpeta: src/main/webapp/images/
   2. Agrega archivos JPG/PNG
   3. En formulario escribe nombre: portada.jpg
   4. Haz referencia en JSP
```

## Técnico

### ¿Cuáles son las dependencias?
```xml
✅ jakarta.servlet (Servlets)
✅ junit (Pruebas - opcional)
❌ NO Spring
❌ NO Hibernate
❌ NO MySQL driver
```

### ¿Cómo actualizo el código?
```
1. Edita en IntelliJ
2. Maven reconstruye automáticamente
3. Tomcat detiene la aplicación
4. Recarga con cambios nuevos
5. Actualiza navegador
```

### ¿Cómo agrego una nueva página?
```
1. Crea archivo: src/main/webapp/nueva.jsp
2. Usa template Bootstrap (copia otra página)
3. Reemplaza contenido
4. Agrega link en navegación
5. Reinicia si es necesario
```

### ¿Cómo conectó una base de datos?
```
Futuro:
1. Agrega driver JDBC (MySQL, PostgreSQL)
2. Crea tablas en BD
3. Reemplaza DataService.java
4. Usa Connection, Statement, ResultSet
5. Similar al que ya existe, pero con BD
```

## Errores Comunes

### "404 not found" al acceder
```
Causa: Puerto incorrecto o aplicación no en raíz
Solución:
  Usa: http://localhost:8080/Trabajo
  NO:  http://localhost:8080/
```

### "Puerto ya está en uso"
```
Causa: Otro proceso usa puerto 8080
Soluciones:
  1. Cambia puerto en Tomcat (8081, 8082)
  2. O cierra el proceso anterior
  3. O reinicia el equipo
```

### "Clase no encontrada" durante ejecución
```
Causa: Maven no compiló correctamente
Solución:
  mvn clean install
  mvn clean tomcat7:run
```

### "Las canciones desaparecieron"
```
Causa: Reiniciaste el servidor
Solución: Normal en proyectos con datos en memoria
  Datos se reinician (by design)
```

### "Mi favorita no se guardó"
```
Causa: Sesión expiró o servidor se reinició
Solución:
  1. Verifica sesión activa
  2. Reinicia sesión si necesario
  3. Marca nuevamente como favorita
```

### "No puedo iniciar sesión"
```
Causas posibles:
  1. Email incorrecto
  2. Contraseña incorrecto
  3. Servidor no está corriendo
Solución:
  1. Usa: juan@example.com / 12345
  2. Verifica servidor está activo
  3. Revisa puerto http://localhost:8080/Trabajo
```

## Mejoras y Extensiones

### ¿Cómo agrego una nueva funcionalidad?

**Ejemplo: Calificación de canciones**

```
1. Agrega campo a Cancion.java:
   private int calificacion;

2. Crea getter/setter

3. Agrega método a DataService:
   calificarCancion(int idCancion, int rating)

4. Crea JSP para mostrar estrellas

5. Crea formulario en canción

6. Maneja POST en CancionServlet
```

### ¿Cómo cambio el tema de colores?

```
Abre cualquier JSP:
  Busca: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  Reemplaza con otros colores hex
  Ejemplo: #ff6b6b, #4ecdc4

O:
  Edita Bootstrap CSS directamente
  Usa variables CSS
  Personaliza según tu gusto
```

### ¿Cómo agrego un formulario de búsqueda?

```
1. Agrega input search en canciones.jsp
2. Captura valor con JavaScript
3. Filtra canciones en client-side (JavaScript)
4. O envía POST a nuevo Servlet de búsqueda
```

## Rendimiento

### ¿Es lenta la aplicación?
```
❌ NO - Usa datos en memoria (muy rápido)
✅ Responde en <100ms típicamente
✅ Sin queries SQL ni latencia BD
⚠️ Limitado a una instancia, no escalable
```

### ¿Hay límite de usuarios?
```
Técnicamente: SÍ (memoria del servidor)
Práctico: ~1000+ usuarios sin problemas
  (Depende de calorías de TU servidor)

Producción:
  ❌ NO escalable
  ✅ Perfecta para desarrollo/testing
```

## Despliegue

### ¿Cómo despliego en producción?
```
⚠️ NO RECOMENDADO en producción así
✅ Mejor crecer a:
   - Spring Boot + MySQL
   - Express + MongoDB
   - Django + PostgreSQL
   
Este proyecto es EDUCATIVO
```

### ¿Puedo usar en Heroku/AWS?
```
✅ SÍ - Puedes empacar como WAR
✅ Deplorar en Tomcat en la nube
❌ Pero datos se pierden al reiniciar
   (pods en contenedores se reinician)
   
Necesitarías:
  - Base de datos en la nube
  - Actualizar código para usar BD
```

---

## 📞 ¿Más preguntas?

Si tu pregunta no está aquí:

1. 📖 Lee `README.md`
2. 📚 Lee `DOCUMENTACION_TECNICA.md`
3. 🎯 Lee `EJEMPLOS_PRACTICOS.md`
4. 💻 Revisa el código fuente
5. 🔍 Busca en Google

---

**¡Espero haber resuelto tus dudas! 🎵**

