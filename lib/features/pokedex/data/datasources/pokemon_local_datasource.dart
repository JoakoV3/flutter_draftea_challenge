import 'package:drift/drift.dart';
import 'package:flutter_draftea_challenge/core/persistence/app_database.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/mappers/pokemon_mapper.dart';
import 'package:flutter_draftea_challenge/features/pokedex/data/models/pokemon_entity.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_detail.dart';
import 'package:flutter_draftea_challenge/features/pokedex/domain/models/pokemon_list_response.dart';

abstract interface class PokemonLocalDatasource {
  /// Guarda una lista de pokemones en la BD
  Future<void> savePokemonList(PokemonListResponse pokemonList);

  /// Obtiene la lista de pokemones con paginación
  Future<PokemonListResponse> getPokemonList({int? limit, int? offset});

  /// Guarda el detalle completo de un pokemon
  Future<void> savePokemonDetail(PokemonDetail pokemonDetail);

  /// Obtiene el detalle de un pokemon por ID
  Future<PokemonDetail?> getPokemonDetail(int id);
}

class PokemonLocalDatasourceImpl implements PokemonLocalDatasource {
  final AppDatabase _database;

  PokemonLocalDatasourceImpl(this._database);

  @override
  Future<void> savePokemonList(PokemonListResponse pokemonList) async {
    final table = _database.pokemonTable;

    for (final pokemon in pokemonList.pokemons) {
      final entity = pokemon.toEntity();

      // Insertar o actualizar, preservando datos de detalle existentes
      await _database
          .into(table)
          .insertOnConflictUpdate(
            PokemonTableCompanion(
              id: Value(entity.id),
              name: Value(entity.name),
              imageUrl: Value(entity.imageUrl),
              lastUpdated: Value(entity.lastUpdated),
              // No actualizar campos de detalle (mantener los existentes si hay)
            ),
          );
    }
  }

  @override
  Future<PokemonListResponse> getPokemonList({int? limit, int? offset}) async {
    final table = _database.pokemonTable;

    // Query con paginación
    var query = _database.select(table)
      ..orderBy([(t) => OrderingTerm.asc(t.id)]);

    if (offset != null) {
      query = query..limit(limit ?? 15, offset: offset);
    } else if (limit != null) {
      query = query..limit(limit);
    }

    final results = await query.get();

    // Convertir entities a PokemonListItem
    final pokemons = results.map((row) {
      return row.toEntity().toListItem();
    }).toList();

    // Calcular si hay más datos disponibles
    // Contar total de pokemones en BD
    final countQuery = _database.selectOnly(table)
      ..addColumns([table.id.count()]);
    final countResult = await countQuery.getSingle();
    final totalCount = countResult.read(table.id.count()) ?? 0;

    final currentOffset = offset ?? 0;
    final currentLimit = limit ?? 15;
    final hasMore = (currentOffset + currentLimit) < totalCount;

    return PokemonListResponse(
      pokemons: pokemons,
      hasMore: hasMore,
      count: totalCount,
    );
  }

  @override
  Future<void> savePokemonDetail(PokemonDetail pokemonDetail) async {
    final table = _database.pokemonTable;
    final entity = pokemonDetail.toEntity();

    // Insertar o actualizar con todos los datos
    await _database
        .into(table)
        .insertOnConflictUpdate(
          PokemonTableCompanion(
            id: Value(entity.id),
            name: Value(entity.name),
            imageUrl: Value(entity.imageUrl),
            height: Value(entity.height),
            weight: Value(entity.weight),
            types: Value(PokemonEntity.encodeStringList(entity.types)),
            abilities: Value(PokemonEntity.encodeStringList(entity.abilities)),
            stats: Value(PokemonEntity.encodeStats(entity.stats)),
            sprites: Value(PokemonEntity.encodeSprites(entity.sprites)),
            lastUpdated: Value(entity.lastUpdated),
          ),
        );
  }

  @override
  Future<PokemonDetail?> getPokemonDetail(int id) async {
    final table = _database.pokemonTable;

    final query = _database.select(table)..where((t) => t.id.equals(id));
    final results = await query.get();

    if (results.isEmpty) return null;

    final entity = results.first.toEntity();

    // Solo retornar si tiene datos completos
    return entity.toDetailOrNull();
  }
}
