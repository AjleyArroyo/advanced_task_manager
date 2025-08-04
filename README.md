# Challenge Advanced Task Manager

# Resumen

Administrador de tareas avanzado, el cual obtiene datos de https://jsonplaceholder.typicode.com/todos/ para traer las primeras tareas, luego las guarda en una BD usando Hive, para luego poder hacer la creación y edición directamente a la BD, los datos solo lo trae la primera vez para cargar la BD, luego todo se maneja con Hive

Tambien cuenta una vista de Países que obtiene los paises con Graphql desde https://countries.trevorblades.com/

# Especificaciones Tecnicas

- Se esta utilizando Clean Architecture
- Manejador de Estados: Riverpod
- Test Unitario de el repositorio que obtiene las tareas
- Test de Widget para la vista de Paises
- Hive
- Graphql
- Llamadas ApiRest usando Dio
- Uso de Freezed para modelos inmutables
- Mockito para mockear los test

# Recursos necesarios para compilar la App

- Descargar el proyecto del repositorio
- Instalar dependencias: flutter pub get
- En caso de errores con el freezed y test los modelos generados, volver a generarlos con: flutter pub run build_runner build --delete-conflicting-output
- Compilar el proyecto

Versiones con la que estoy trabajando:

- Flutter 3.32.6 • channel stable • https://github.com/flutter/flutter.git
- Tools • Dart 3.8.1 • DevTools 2.45.1

## Arquiteectura

```
┌────────────────────────────────────────────────────────────────┐
│                    Presentation Layer                          │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   Pages         │  │   Providers     │  │   Widgets       │ │
│  │                 │  │                 │  │   Components    │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
├────────────────────────────────────────────────────────────────┤
│                            Domain                              │
│         ┌─────────────────┐           ┌─────────────────┐      │
│         │   Entities.     │           │   Repository    │      │
│         │                 │           │                 │      │
│         └─────────────────┘           └─────────────────┘      │
├────────────────────────────────────────────────────────────────┤
│                      Data Layer                                │
│  ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐ │
│  │   DataSources   │  │   Data Models   │  │  Repositories   │ │
│  │                 │  │                 │  │                 │ │
│  └─────────────────┘  └─────────────────┘  └─────────────────┘ │
└────────────────────────────────────────────────────────────────┘
```
