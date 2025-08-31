# Reto de Automatización QA - BackEnd (ServeRest Usuarios con Karate)

Suite de pruebas automatizadas para la **API de Usuarios de [ServeRest](https://serverest.dev)** usando **Karate DSL**. Cumple con los requerimientos del documento del reto (objetivo, CRUD, esquemas, casos positivos/negativos, organización y README).

## Requisitos
- Java 17+
- Maven 3.9+
- IntelliJ IDEA 
- Acceso a internet (para consumir https://serverest.dev)

## Estructura
```
.
├── docs/
│   └── STRATEGY.md
├── pom.xml
├── README.md
├── src
│   └── test
│       ├── java
│       │   ├── com
│       │   │   └── reto
│       │   │       ├── tests
│       │   │       │   └── UsuariosTest.java
│       │   │       └── util
│       │   │           └── DataGenerator.java
│       └── resources
│           ├── karate-config.js
│           ├── features
│           │   ├── auth
│           │   │   └── login.feature
│           │   └── usuarios
│           │       ├── usuarios-listar.feature
│           │       ├── usuarios-crear.feature
│           │       ├── usuarios-detalle.feature
│           │       ├── usuarios-actualizar.feature
│           │       └── usuarios-eliminar.feature
│           └── schemas
│               └── usuario.json
```

## Configuración
Opcionalmente puedes configurar credenciales de un **usuario administrador** si tu flujo lo requiere (algunas operaciones de ServeRest pueden estar protegidas). Define variables de entorno o propiedades Maven:

```bash
# Variables de entorno (recomendado)
export ADMIN_EMAIL="tu-admin@example.com"
export ADMIN_PASSWORD="TuPassword123"

# O como propiedades al ejecutar Maven
mvn -DADMIN_EMAIL=tu-admin@example.com -DADMIN_PASSWORD=TuPassword123 test
```

> El `karate-config.js` lee `ADMIN_EMAIL` y `ADMIN_PASSWORD`. Si no se proveen, usará valores dummy.

## Cómo importar en IntelliJ
1. **File → New → Project from Existing Sources...** y selecciona el `pom.xml`.
2. Acepta los valores por defecto y espera a que Maven descargue dependencias.
3. Abre `UsuariosTest.java` y ejecuta el runner JUnit desde el ícono de "play".

## Ejecución por CLI
```bash
# Todos los tests
mvn -q -Dtest=UsuariosTest test

# Filtrar por tag (ej: excluir @wip ya está por defecto en el runner)
mvn -q -Dkarate.options="--tags @smoke" test
```

## Notas sobre la API y estabilidad
- Los tests crean y limpian datos sobre la marcha (creación/consulta/actualización/eliminación).
- Dado que el entorno de ServeRest es público, podrían existir **fluctuaciones** en códigos de estado y mensajes para recursos inexistentes; por eso se contemplan validaciones flexibles en algunos escenarios negativos.

## Validación de esquemas
- Se incluye `schemas/usuario.json` para validar estructura base de un usuario. También se usan **match** con tipos (`#string`, `#number`, etc.) dentro de los feature files.

## Cobertura
- **GET /usuarios** – listar (positivo).
- **POST /usuarios** – crear (positivo) + duplicado (negativo).
- **GET /usuarios/{_id}** – detalle (positivo) + inexistente (negativo).
- **PUT /usuarios/{_id}** – actualizar (positivo) + email duplicado (negativo).
- **DELETE /usuarios/{_id}** – eliminar (positivo) + inexistente (negativo).

## CI/CD (opcional)
Ejemplo básico de ejecución en CI:
```yaml
# GitHub Actions (ejemplo)
name: karate-tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-java@v4
        with:
          distribution: temurin
          java-version: '17'
      - run: mvn -q -Dtest=UsuariosTest test
```
