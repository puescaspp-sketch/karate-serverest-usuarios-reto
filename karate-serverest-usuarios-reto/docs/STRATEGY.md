# Estrategia de Automatización y Patrones

## Objetivos
- Validar operaciones CRUD para el recurso **Usuarios** en ServeRest.
- Asegurar **cobertura** de casos positivos y negativos, con **validación de esquemas** y generación de datos.

## Patrones / Buenas prácticas
- **Estructura por recurso:** carpeta `features/usuarios` agrupando endpoints relacionados.
- **Background** para configurar `baseUrl` y dependencias comunes.
- **Data on demand**: `DataGenerator` genera `nome`, `email`, `password` únicos para evitar colisiones.
- **Idempotencia**: los tests crean datos y luego los limpian (delete cuando aplica).
- **Esquemas**: `schemas/usuario.json` y tipos de Karate (`#string`, `#number`) para respuestas.
- **Tags** (`@smoke`, `@wip`) para seleccionar subconjuntos en CI.
- **Runner único** con JUnit5 (`UsuariosTest`) para simplificar ejecución.
- **Configuración externalizada**: `karate-config.js` lee `ADMIN_EMAIL`/`ADMIN_PASSWORD` cuando se requiere autenticación.

## Riesgos y mitigaciones
- **Entorno compartido / público**: puede devolver códigos distintos para recursos inexistentes. Se usa validación laxa de mensajes y, cuando es razonable, se aceptan variantes.
- **Datos duplicados**: se generan emails únicos con UUID.
- **Latencia / timeouts**: timeouts configurados en Karate (15s).

## Futuras mejoras
- Implementar **hooks** para limpieza centralizada.
- Reportes enriquecidos con `karate-report` (ya incluidos por defecto en target/karate-reports).
- Añadir **contratos** con JSON Schema más estricto por endpoint.
