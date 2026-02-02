import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter_draftea_challenge/core/persistence/pokemon_table.dart';

part 'app_database.g.dart';

/// Base de datos principal de la aplicación
@DriftDatabase(tables: [PokemonTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// Crea la conexión a la base de datos usando drift_flutter
  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'pokedex_db');
  }
}
