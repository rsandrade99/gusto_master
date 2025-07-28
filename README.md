# GustoMaster

**GustoMaster** es una aplicación desarrollada con Flutter que permite al usuario gestionar una lista de preferencias personales de forma local, y enriquecer dicha información consumiendo datos de una API externa (PokeAPI). La aplicación utiliza una arquitectura limpia y escalable, incorporando buenas prácticas de desarrollo moderno en Flutter.

## Características principales

- Gestión de gustos personales almacenados localmente con Hive.
- Visualización detallada enriquecida mediante integración con PokeAPI.
- Eliminación segura de preferencias con confirmación.
- Recarga manual de datos mediante `pull-to-refresh`.
- Arquitectura modular basada en el patrón BLoC.
- Navegación declarativa mediante GoRouter.
- Separación clara entre presentación, lógica y datos.
- Inyección de dependencias para facilitar el mantenimiento y pruebas.

## Objetivo de la aplicación

Esta aplicación fue desarrollada como una prueba técnica para demostrar:

- Uso avanzado de Flutter con enfoque profesional.
- Aplicación de arquitectura limpia y desacoplada.
- Persistencia local eficiente y reactiva.
- Consumo de APIs REST externas de forma asíncrona y robusta.
- Manejo de estado predecible y mantenible con Cubit (BLoC).
- Buenas prácticas de diseño y experiencia de usuario.

## Estructura del proyecto

lib/
-├── config/ # Inyección de dependencias
-├── core/ # Funciones utilitarias
-├── data/
-│ └── models/ # Modelos de datos
-├── logic/
-│ ├── api_cubit/ # Estado de datos externos
-│ └── preference_cubit/ # Estado de datos locales
-├── presentation/
-│ ├── pages/ # Pantallas de la app
-│ └── widgets/ # Componentes reutilizables
-└── main.dart # Punto de entrada

## Tecnologías utilizadas

- Flutter 3.x
- Dart
- Hive + Hive Flutter
- Flutter BLoC (Cubit)
- GoRouter
- HTTP
- Provider

## Instalación y ejecución

1. Clona este repositorio:
   ```bash
   git clone https://github.com/usuario/gustomaster.git
   cd gustomaster
   ```
2. Instala las dependencias:
   ```bash
   flutter pub get
   ```
3. Instala las dependencias:
   ```bash
   flutter packages pub run build_runner build
   ```
4. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## Autor

**Robert Andrade**  
Ingeniero en Tecnologías de Información  
Desarrollador Flutter especializado en arquitectura escalable, diseño profesional y experiencia de usuario.
·[GitHub](https://github.com/rsandrade99) 
·[LinkedIn](https://www.linkedin.com/in/rsandradea99/) 
· rsandradea@gmail.com
·[Instagram](https://www.instagram.com/robert_0899/)
