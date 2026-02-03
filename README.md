# Prueba técnica — Flutter Mobile + Web (Pokédex)

Este repositorio contiene la solución a la prueba técnica para el puesto de Flutter Developer.

## Preguntas Obligatorias para el README

### 1. Arquitectura y escalabilidad
**¿Qué arquitectura/patrón usaste y por qué es adecuado para escalar a un producto real (incluyendo Web)?**

Implementé una Feature-First Clean Architecture (FFCA), organizada en tres capas bien definidas (Domain, Data y Presentation), junto con Cubits para la gestión de estado.

- **Domain:** contiene modelos puros (como PokemonDetail y PokemonListItem), contratos de repositorios y excepciones de dominio.

- **Data:** implementa los repositorios siguiendo un enfoque offline-first, utilizando Streams, datasources remotos (Dio) y locales (Drift), además de mappers y modelos de entidad.

- **Presentation:** maneja la lógica de la UI mediante Cubits y vistas con diseño responsive (mobile, desktop y tablet) usando ScreenLayout.

La separación por capas es escalable ya que permite la escalabilidad de features individuales, el testing de cada capa de forma aislada y la reutilización de código al evitar el acoplamiento.


### 2. Trade-offs
**¿Qué trade-offs tomaste por el timebox de 1 día?**

Por el timebox de 1 día prioricé funcionalidad core sobre optimizaciones:

- Dependency Injection manual en lugar de get_it → Más rápido de implementar, suficiente para el scope
- Sin paginación infinita optimizada -> Implementé scroll infinito básico pero sin virtualización 
- Tests unitarios solo en datasources -> No alcancé a testear Cubits ni Repository 
- Sin manejo de imágenes offline -> Solo cacheo datos JSON, las imágenes dependen de red. Se podria haber utilizado `cached_network_image`
- UI simple sin hacer llamadas a otros endpoints en detalle para obtener mas información o traducciones. 
- Textos hardcodeados -> No implementé l10n para las traducciones 

### 3. Gestión de estado y side-effects
**Describe tu flujo "UI → estado → datos" y cómo evitas acoplamiento entre capas.**

Desacoplamiento:
- La UI no conoce Repository: Solo interactúa con Cubits vía context.read<Cubit>()
- El Cubit no conoce Datasources: Solo usa la abstracción PokemonRepository
- El Repository coordina sources: Patrón offline-first con Streams (emite local primero, luego remote)
- Excepciones de dominio: NetworkException (capa data) → PokemonFetchException (capa domain) para no exponer detalles de implementación

Ejemplo: 

1. `PokemonListCubit.loadPokemons()` 
2. `_repository.getPokemonList()` -> Stream emite 2 veces (local + remote) 
3. Cubit actualiza estado en cada emisión -> UI se reconstruye automáticamente


### 4. Offline y caché
**Explica tu estrategia de persistencia: qué guardas, cómo versionas/invalidas, cómo resuelves conflictos entre "dato cacheado" y "dato remoto".**

Implementé una estrategia offline-first utilizando Drift como base de datos local.
En lugar de separar la información en múltiples tablas (lista y detalle), opté por una única tabla con campos nulleables que se completan una vez se consulta el detalle.

**¿Qué guardo?**

- **Lista de Pokémon**: `id`, `name`, `imageUrl`
- **Detalle del Pokémon**: `stats`, `types`, `abilities`, `sprites`
- **Control de estado**: flag `hasDetail` para indicar si el detalle completo ya fue descargado

Todo se persiste en una única tabla (`pokemon_table`).

**¿Cómo funciona?**

- **Lectura**: siempre emito primero los datos locales (si existen) y luego los datos remotos.
- **Escritura**: cada fetch exitoso actualiza o inserta en la base de datos mediante *upsert* por `id`.
- **Carga progresiva**: al entrar al detalle de un Pokémon, se completan los campos nulleables y se marca `hasDetail = true`.
- **Resolución de conflictos**: los datos remotos siempre sobrescriben a los locales (*source of truth = API*).

Este enfoque reduce la complejidad del modelo, evita joins innecesarios y mantiene una experiencia offline consistente incluso con datos parciales.


### 5. Flutter Web
**¿Qué decisiones tomaste para que la experiencia en Web sea buena (responsive, navegación, performance, interacción tipo desktop)? ¿Qué limitaciones tuviste/anticipas y cómo las mitigarías?**

**Decisiones para Web**

- **Navegación nativa**: uso de `go_router` con `usePathUrlStrategy()` para URLs limpias  
  (ej: `/pokemon/25` en lugar de `/#/pokemon/25`)
- **Responsive design**: `ScreenLayout` con breakpoints  
  Desktop usa grid de 2 columnas, mobile una lista vertical
- **Separación de vistas por plataforma (desktop / mobile)**  
  Archivos y widgets específicos por layout, lo que mantiene el código más claro, legible y fácil de mantener.
- **Persistencia local**: Drift Web configurado con `sqlite3.wasm` y `drift_worker.js` para usar IndexedDB

**Limitaciones**

- Sin scroll restauration: Al volver de detalle, la lista no recuerda posición. Se podría implementar utilizando `ScrollController` y guardando el estado en el Cubit.
- Sin paginación infinita optimizada: Se podría implementar utilizando `InfiniteScrollPhysics` y guardando el estado en el Cubit.
- Imágenes no optimizadas: No uso lazy loading ni WebP (podría afectar performance). Se podría implementar utilizando `cached_network_image`.



### 6. Calidad
**Menciona 3 decisiones de "código limpio" aplicadas (con ejemplo puntual del repo).**

1. **Separación de responsabilidades (Single Responsibility Principle)**: 
   Uso de widgets especializados (ej: `pokemon_header.dart`, `pokemon_stats.dart`) para que cada componente tenga una única responsabilidad, facilitando su mantenimiento y testeo.

2. **Mappers explícitos entre capas**: 
   `PokemonMapper` convierte `PokemonEntity` (data) ↔ `PokemonDetail` (domain), desacoplando la base de datos de la lógica de negocio y permitiendo cambios en la persistencia sin afectar el dominio.

3. **Excepciones de dominio personalizadas**: 
   Jerarquía de excepciones específicas (`PokemonException`, `PokemonDetailFetchException`, `PokemonListFetchException`) que traducen errores técnicos (`NetworkException`) a errores de negocio, evitando que detalles de implementación se filtren a capas superiores.
### 7. Testing
**¿Qué testeaste y por qué? Si no alcanzaste, ¿qué tests agregarías primero (prioridad) y qué asegurarían?**

Implementé tests unitarios para ambos datasources (local y remoto) utilizando `mocktail` para mocks y `drift` con base de datos en memoria:

- **`pokemon_local_datasource_test.dart`** 
  - CRUD completo (guardar/recuperar lista y detalle)
  - Paginación (limit/offset)
  - Upsert (actualización sin sobrescribir datos de detalle)
  - Serialización de JSON (stats, sprites, types)
  - Casos edge (límite 0, offset > total, múltiples guardados)

- **`pokemon_remote_datasource_test.dart`**
  - Llamadas HTTP exitosas con mocks de Dio
  - Manejo de excepciones de red (`NoInternetConnectionException`, `ConnectionTimeoutException`, `BadResponseException`)
  - Construcción correcta de URLs con parámetros

**¿Por qué estos tests?**

Los datasources son la **capa crítica** donde ocurren errores de parsing, red y persistencia. Testearlos garantiza que el resto de la app funcione correctamente si estas capas están bien.

**Tests faltantes:**

Me quedó pendiente testear el repository y los cubits, pero considero que los datasources son la capa más crítica y la que más errores puede generar.


### 8. Git
**¿Cómo estructuraste tus commits (granularidad, mensajes, convención) para facilitar review y mantenimiento?**

Utilicé **Conventional Commits** con prefijos feat, refactor, test, feature.

**Commits atómicos** por capa/feature: cada commit representa una unidad de trabajo completa y funcional
- Ejemplos:
  - `feat: configure drift database for web` (configuración específica de Web)
  - `feat: Implement local data persistence for Pokemon details using drift` (persistencia completa)
  - `feat: Add custom error page and domain-specific Pokemon exceptions` (manejo de errores)

### 9. Pendientes
**¿Qué dejaste fuera? Lista priorizada (top 3-5) con cómo lo implementarías.**

1. **Tests de Repository y Cubits** (alta prioridad)
   - **Qué:** Tests unitarios para `PokemonRepositoryImpl` y `PokemonListCubit`/`PokemonDetailCubit`
   - **Cómo:** Usar `mocktail` para mockear datasources, verificar emisiones de Stream con `expectLater`, testear todos los estados del Cubit
   - **Por qué:** Asegura que la lógica de negocio y orquestación funciona correctamente

2. **Internacionalización (i18n)** (media prioridad)
   - **Qué:** Soporte multiidioma con `flutter_localizations` y archivos `.arb`
   - **Cómo:** Crear `lib/l10n/app_en.arb` y `app_es.arb`, usar `AppLocalizations.of(context)` en widgets
   - **Por qué:** Textos hardcodeados dificultan escalabilidad internacional

3. **Scroll restoration en Web** (media prioridad)
   - **Qué:** Restaurar posición del scroll al volver de la página de detalle
   - **Cómo:** Guardar `ScrollController.offset` en el Cubit, restaurar en `initState` con `WidgetsBinding.instance.addPostFrameCallback`
   - **Por qué:** Mejora UX en navegación Web (comportamiento esperado en apps nativas)

4. **Caché de imágenes offline** (baja prioridad)
   - **Qué:** Persistir imágenes localmente para modo offline completo
   - **Cómo:** Usar `cached_network_image` con `CacheManager` personalizado
   - **Por qué:** Actualmente las imágenes requieren conexión incluso con datos cacheados

5. **Paginación infinita optimizada** (baja prioridad)
   - **Qué:** Virtualización de lista para mejor performance con miles de Pokémon
   - **Cómo:** Implementar `ListView.builder` con `ScrollController` que detecte scroll al 80% y cargue siguiente página
   - **Por qué:** Mejora performance y reduce uso de memoria en listas largas
