# 🏗️ DIAGRAMA DE FLUJO - Biblioteca de Música

## Flujo General de la Aplicación

```
┌─────────────────────────────────────────────────────────────┐
│                    USUARIO ACCEDE                           │
│              http://localhost:8080/Trabajo                  │
└──────────────────────────┬──────────────────────────────────┘
                           │
                    index.jsp redirige
                           │
                           ▼
         ┌─────────────────────────────────┐
         │      ¿Usuario autenticado?      │
         │   session.getAttribute(userId)  │
         └──────┬─────────────────┬────────┘
                │ NO              │ SÍ
                │                 │
                ▼                 ▼
         ┌──────────────┐  ┌──────────────────┐
         │  login.jsp   │  │  dashboard.jsp   │
         │              │  │  (o página req)  │
         │ - Validar    │  │                  │
         │ - Login      │  │ - Usuario OK     │
         │ - Error?     │  │ - Mostrar datos  │
         └──────┬───────┘  └────┬─────────────┘
                │               │
                │ SUCCESS       │
                └───────┬───────┘
                        │
                        ▼
        ┌─────────────────────────────────────┐
        │    ACCIONES DISPONIBLES             │
        └──────────────┬──────────────────────┘
                       │
        ┌──────────────┼──────────────┐
        │              │              │
        ▼              ▼              ▼
   ┌────────┐   ┌──────────┐   ┌──────────┐
   │Canciones│   │Favoritas │   │Dashboard │
   └────┬────┘   └────┬─────┘   └────┬─────┘
        │             │              │
        │             │         Otros enlaces
        │             │
        ▼             ▼
   ┌─────────────────────────────┐
   │   ACCIONES EN CANCIONES     │
   └──────┬──────────────────────┘
          │
   ┌──────┼──────┬──────────┐
   ▼      ▼      ▼          ▼
[AGREGAR] [EDITAR] [ELIMINAR] [FAVORITA]
   │      │      │          │
   │      │      │          └─→ DataService.agregarFavorita()
   │      │      │              │
   │      │      │              ▼
   │      │      │         Usuario.cancionesFavoritas ← ID
   │      │      │
   │      │      └─→ DataService.eliminarCancion()
   │      │          │
   │      │          ▼
   │      │     Remover de ArrayList
   │      │     Remover de todas favoritas
   │      │
   │      └─→ EditarCancionServlet
   │          │
   │          ▼
   │     DataService.actualizarCancion()
   │          │
   │          ▼
   │     Reemplazar en ArrayList
   │
   └─→ AgregarCancionServlet
       │
       ▼
  Validar campos
       │
       ├─ ¿Válido?
       │
       ├─ SÍ ──→ DataService.agregarCancion()
       │         │
       │         ▼
       │    Generar ID nuevo
       │    Agregar a ArrayList
       │         │
       │         ▼
       │    Redirigir a canciones.jsp
       │    "Canción agregada"
       │
       └─ NO ──→ Forward a agregar-cancion.jsp
                 Mostrar error

```

## Flujo de Datos de Usuario

```
┌─────────────────────────────────────┐
│   LOGIN SERVLET                     │
│   POST /login                       │
├─────────────────────────────────────┤
│ 1. Obtener email y password         │
│ 2. Validar NO null                  │
│ 3. Llamar DataService.autenticar()  │
└──────────────┬──────────────────────┘
               │
               ▼
    ┌─────────────────────────┐
    │   DataService           │
    │   autenticar()          │
    │                         │
    │ for(User u : usuarios)  │
    │   if(email && pwd)      │
    │     return u            │
    └──────────┬──────────────┘
               │
         ┌─────┴─────┐
         │ ENCONTRADO│
         ▼           │
    ┌─────────┐     NO
    │Crear    │      │
    │Sesión   │      │
    │HTTP     │      │
    └────┬────┘      │
         │           │
    setAttribute:    │
    - usuarioId      │
    - usuarioNombre  │
    - usuarioEmail   │
         │           │
         ▼           ▼
    Dashboard    Login error
    Success        message
```

## Flujo de DataService (Singleton)

```
┌──────────────────────────────────────┐
│ Primera instancia de DataService     │
├──────────────────────────────────────┤
│                                      │
│  ¿instancia == null?                 │
│     │                                │
│     ├─ SÍ ──→ synchronized block     │
│     │         ├─ Crear instancia     │
│     │         ├─ Llamar init()       │
│     │         ├─ Cargar usuarios     │
│     │         └─ Cargar canciones    │
│     │                                │
│     └─ NO ──→ Retornar instancia     │
│                                      │
│  return instancia                    │
│                                      │
│  ┌─────────────────────────┐         │
│  │ EN MEMORIA:             │         │
│  │ ┌────────────────────┐  │         │
│  │ │ ArrayList<Usuario> │◄─┼─────┐  │
│  │ │  - Juan Pérez      │  │     │  │
│  │ │  - María García    │  │     │  │
│  │ │  - Carlos López    │  │     │  │
│  │ └────────────────────┘  │     │  │
│  │                         │     │  │
│  │ ┌────────────────────┐  │     │  │
│  │ │ArrayList<Cancion>  │◄─┼─────┤  │
│  │ │ - 8 canciones      │  │     │  │
│  │ │ - Precargadas      │  │     │  │
│  │ └────────────────────┘  │    Datos
│  │                         │    en vivo
│  │ Favorable map:          │     │  │
│  │ usuario1 -> {1, 3, 5}   │     │  │
│  │ usuario2 -> {2, 4}      │     │  │
│  │ usuario3 -> {}          │     │  │
│  └─────────────────────────┘     │  │
│                                  │  │
└──────────────────────────────────┼──┘
                                   │
                        Compartido por
                        toda la aplicación
                        (mientras servidor ▼
                         esté activo)
```

## Ciclo de Vida Completo

```
1. INICIO
   ├─ Tomcat inicia
   ├─ JSPs compiladas
   ├─ Servlets registrados
   └─ ¡Listo!

2. USUARIO ACCEDE
   ├─ Navegador pide /Trabajo
   ├─ index.jsp redirige a login.jsp
   ├─ login.jsp se muestra
   └─ Usuario ve formulario

3. LOGIN
   ├─ Usuario completa email/password
   ├─ Hace POST a /login
   ├─ LoginServlet procesa
   ├─ DataService autentica
   ├─ Sesión creada
   └─ Dashboard mostrado

4. NAVEGACIÓN
   ├─ Usuario accede canciones.jsp
   ├─ JSP verifica sesión OK
   ├─ JSP llama DataService.obtenerTodasLasCanciones()
   ├─ ArrayList devuelve 8 canciones
   ├─ JSP renderiza grid
   ├─ 8 tarjetas mostradas
   └─ Usuario ve canciones

5. ACCIÓN (ej: agregar)
   ├─ Usuario rellena form
   ├─ POST a /cancion?accion=agregar
   ├─ CancionServlet valida
   ├─ Crea objeto Cancion
   ├─ DataService.agregarCancion()
   ├─ ArrayList.add(cancion)
   ├─ Retorna
   ├─ Redirección a canciones.jsp
   └─ Nueva canción visible

6. LOGOUT
   ├─ Usuario hace clic "Cerrar Sesión"
   ├─ GET a /logout
   ├─ LogoutServlet ejecuta
   ├─ session.invalidate()
   ├─ Todos atributos borrados
   ├─ Redirección a login.jsp
   └─ Vuelta al inicio

7. CIERRE
   ├─ (Opcional) Admin detiene Tomcat
   ├─ Conexiones cierran
   ├─ DataService eliminado
   ├─ ArrayList usuarios desaparece
   ├─ ArrayList canciones desaparece
   └─ TODO REINICIALIZED en próximo inicio
```

## Árbol de Decisiones - Acciones

```
¿Qué quiere hacer el usuario?

                         ├─ VER CANCIONES
                         │  └─ JSP directamente
                         │     No requiere POST
                         │
                         ├─ AGREGAR CANCIÓN
                         │  ├─ Formularion en agregar-cancion.jsp
                         │  ├─ POST a /cancion?accion=agregar
                         │  ├─ CancionServlet valida
                         │  ├─ SI OK: DataService.agregarCancion()
                         │  └─ NO: error mensaje
                         │
                         ├─ EDITAR CANCIÓN
                         │  ├─ Formulario en editar-cancion.jsp?id=X
                         │  ├─ Pre-cargado con datos
                         │  ├─ POST a /cancion?accion=editar
                         │  ├─ CancionServlet valida
                         │  ├─ SI OK: DataService.actualizarCancion()
                         │  └─ NO: error mensaje
                         │
                         ├─ ELIMINAR CANCIÓN
                         │  ├─ Form inline con POST
                         │  ├─ Confirmación JS
                         │  ├─ POST a /cancion?accion=eliminar
                         │  ├─ DataService.eliminarCancion()
                         │  └─ Remover de favoritasTambién
                         │
                         ├─ MARCAR FAVORITA
                         │  ├─ Form en tarjeta
                         │  ├─ POST a /cancion?accion=favorita
                         │  ├─ DataService.agregarFavorita()
                         │  ├─ usuario.cancionesFavoritas.add(idCancion)
                         │  └─ Corazón relleno
                         │
                         └─ VER FAVORITAS
                            ├─ favoritas.jsp
                            ├─ JSP obtiene idUsuario de sesión
                            ├─ DataService.obtenerCancionesFavoritasUsuario()
                            ├─ Filtra canciones
                            └─ Solo muestra favoritas
```

## Protección de Sesión

```
¿Cada JSP verificar sesión?

login.jsp ─────────────────────────────────────┐
  ¿Autenticado? NO → Mostrar formulario        │
  ¿Autenticado? SÍ → Redirigir dashboard      │
                                               │
dashboard.jsp ─────────────────────────────────┤
  ¿Autenticado? NO → Redirigir login.jsp      │
  ¿Autenticado? SÍ → Mostrar panel           │
                                               │
canciones.jsp ─────────────────────────────────┤
  ¿Autenticado? NO → Redirigir login.jsp      │
  ¿Autenticado? SÍ → Mostrar canciones       │
                                               │
favoritas.jsp ─────────────────────────────────┤
  ¿Autenticado? NO → Redirigir login.jsp      │
  ¿Autenticado? SÍ → Mostrar favoritas solo  │
                                               │
agregar-cancion.jsp ───────────────────────────┤
  ¿Autenticado? NO → Redirigir login.jsp      │
  ¿Autenticado? SÍ → Mostrar form             │
                                               │
editar-cancion.jsp ────────────────────────────┤
  ¿Autenticado? NO → Redirigir login.jsp      │
  ¿Autenticado? SÍ → Mostrar form prepoblado │
                                               │
sesion-expirada.jsp ────────────────────────────┤
  Página de informar sesión expirada           │
                                               │
logout ─────────────────────────────────────────┘
  POST → Servlet
  invalidate() sesión
  Redirige login.jsp
```

## Relación entre Clases

```
                    ┌─────────────────┐
                    │  SERVLET LAYER  │
                    └────────┬────────┘
                             │
         ┌─────────┬─────────┴────────┬────────┐
         │         │                  │        │
    LoginServlet   │            CancionServlet
    LogoutServlet  │
         │         │                  │        │
         └─────────┴────────┬─────────┴────────┘
                            │
                    ┌───────▼────────┐
                    │ DataService    │ ◄─── SINGLETON
                    │ (Service Layer)│
                    └───────┬────────┘
                            │
         ┌──────────┬───────┴────────┬──────────┐
         │          │                │          │
    ┌────▼────┐ ┌──▼────┐ ┌────────▼──┐ ┌────▼──┐
    │ Usuario ┌─┤Cancion│ │List ops   │ │ Favs  │
    │(model)  │ └───────┘ │(CRUD)     │ │ Map   │
    └─────────┘ └──────────┴───────────┘ └───────┘
         │
    ┌────▼─────────────────────┐
    │ EN MEMORIA:              │
    │ ArrayList<Usuario>  (3)  │
    │ ArrayList<Cancion>  (8)  │
    │ Set<Integer> favs/user   │
    └──────────────────────────┘
```

---

**Este diagrama muestra cómo los datos fluyen a través de toda la aplicación. 🎵**

