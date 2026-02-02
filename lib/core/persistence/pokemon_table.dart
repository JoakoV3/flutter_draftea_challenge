import 'package:drift/drift.dart';

/// Tabla Drift para almacenar pokemones con datos básicos y detalles completos
/// Soporta almacenamiento parcial (solo lista) o completo (lista + detalles)
class PokemonTable extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get imageUrl => text()();

  // Campos de detalle
  // Estos campos se llenan cuando se consulta el detalle del Pokemon
  IntColumn get height => integer().nullable()();
  IntColumn get weight => integer().nullable()();
  TextColumn get types => text().nullable()();
  TextColumn get abilities => text().nullable()();
  TextColumn get stats => text().nullable()();
  TextColumn get sprites => text().nullable()();

  /// Timestamp de la última actualización (para invalidación de caché futura)
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
